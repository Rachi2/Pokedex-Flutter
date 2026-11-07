import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/sync_metadata_dao.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/features/connectivity/domain/entities/service_status.dart';
import 'package:pokedex/features/connectivity/domain/repositories/connectivity_repository.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_sync_status.dart';

import '../datasources/pokemon_local_datasource.dart';
import '../datasources/pokemon_remote_datasource.dart';
import '../graphql/pokemon_queries.dart';
import '../mappers/pokemon_mapper.dart';

/// Coordina la descarga del catalogo: PokeAPI -> Drift.
class CatalogSyncCoordinator {
  CatalogSyncCoordinator({
    required this._database,
    required this._remote,
    required this._local,
    required this._syncDao,
    required this._connectivity,
  });

  final AppDatabase _database;
  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;
  final SyncMetadataDao _syncDao;
  final ConnectivityRepository _connectivity;

  static const _key = SyncMetadataDao.catalogKey;

  /// La descarga en curso, o null si no hay ninguna.
  Future<void>? _running;

  StreamSubscription<ServiceStatus>? _connectivitySubscription;
  ServiceStatus? _lastStatus;
  var _disposed = false;

  /// Empieza a escuchar la conectividad. Se llama una vez al abrir la app,
  /// sin await, para que la app abra de inmediato (OF-03).
  void start() {
    unawaited(_start());
  }

  Future<void> _start() async {
    await _recoverInterruptedSync();
    if (_disposed) return;
    _connectivitySubscription ??= _connectivity.watchStatus().listen(
      _onStatusChanged,
    );
  }

  /// Si la app se cerro a mitad de una descarga, sync_metadata quedo en
  /// "syncing". Se marca como fallida para no quedar trabados y para que se
  /// reintente sola cuando haya conexion.
  Future<void> _recoverInterruptedSync() async {
    final metadata = await _syncDao.get(_key);
    if (_running == null && metadata?.status == SyncState.syncing) {
      await _syncDao.markFailed(_key);
    }
  }

  /// Deja de escuchar la conectividad.
  Future<void> dispose() async {
    _disposed = true;
    await _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }

  /// Descarga la siguiente pagina del catalogo.
  ///
  /// Si ya hay una descarga en curso devuelve esa misma en vez de empezar
  /// otra (RNF-RES-03).
  Future<void> syncNextPage() {
    return _running ??= _syncNextPage().whenComplete(() => _running = null);
  }

  /// Vuelve a pedir la primera pagina sin borrar lo que ya esta guardado.
  Future<void> refresh() {
    return _running ??= _syncPage(0).whenComplete(() => _running = null);
  }

  /// Cuando la conexion vuelve, sincroniza solo (OF-12).
  void _onStatusChanged(ServiceStatus status) {
    final cameBack = status.canReachApi && _lastStatus != ServiceStatus.online;
    _lastStatus = status;
    if (cameBack) unawaited(_syncIfNeeded());
  }

  /// Sincroniza si no hay nada guardado o si la ultima vez fallo.
  /// Los errores no se lanzan: ya quedan registrados en sync_metadata.
  Future<void> _syncIfNeeded() async {
    try {
      final metadata = await _syncDao.get(_key);
      final isEmpty = await _local.count() == 0;
      if (isEmpty || metadata?.status == SyncState.error) {
        await syncNextPage();
      }
    } on Failure catch (failure) {
      debugPrint(
        '[Sync] La sincronizacion automatica fallo: ${failure.message}',
      );
    }
  }

  Future<void> _syncNextPage() async {
    final metadata = await _syncDao.get(_key);
    final offset = metadata?.nextOffset ?? 0;
    final total = metadata?.totalRemote;

    if (total != null && offset >= total) {
      debugPrint('[Sync] El catalogo ya esta completo ($total Pokemon)');
      return;
    }
    await _syncPage(offset);
  }

  /// Descarga la pagina que empieza en [offset] y la guarda en Drift.
  ///
  /// Si algo falla marca el estado como error y no borra nada.
  Future<void> _syncPage(int offset) async {
    await _syncDao.markSyncing(_key);
    try {
      final page = await _remote.fetchPage(
        offset: offset,
        limit: catalogPageSize,
      );

      final now = DateTime.now();
      final rows = [
        for (final dto in page.pokemon)
          PokemonMapper.toRows(dto, updatedAt: now),
      ];

      // Nunca retrocede: un refresh de la primera pagina no pierde el avance.
      final saved = await _syncDao.get(_key);
      final nextOffset = max(saved?.nextOffset ?? 0, offset + catalogPageSize);

      // Pokemon y sync_metadata en la misma transaccion:
      // o se guarda todo o no se guarda nada.
      await _database.transaction(() async {
        await _local.upsertPage(rows);
        await _syncDao.markSuccess(
          _key,
          nextOffset: nextOffset,
          totalRemote: page.totalCount,
        );
      });
      debugPrint(
        '[Sync] Guardados ${rows.length} Pokemon, siguiente offset: $nextOffset',
      );
    } on Failure {
      await _syncDao.markFailed(_key);
      rethrow;
    } catch (error) {
      debugPrint('[Sync] Error inesperado: $error');
      await _syncDao.markFailed(_key);
      throw const UnknownFailure();
    }
  }
}
