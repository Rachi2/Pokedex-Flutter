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
    this.pageDelay = const Duration(milliseconds: 500),
  });

  final AppDatabase _database;
  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;
  final SyncMetadataDao _syncDao;
  final ConnectivityRepository _connectivity;
  final Duration pageDelay;

  static const _key = SyncMetadataDao.catalogKey;

  /// La descarga en curso, o null si no hay ninguna.
  Future<void>? _running;

  /// La actualizacion en segundo plano en curso, o null si no hay ninguna.
  Future<void>? _batch;

  /// La conexion volvio durante una actualizacion: al terminar, otra.
  var _updateAgain = false;

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

  /// Al abrir la app con la API disponible y cada vez que vuelve la conexion,
  /// actualiza el catalogo (OF-12).
  void _onStatusChanged(ServiceStatus status) {
    final cameBack = status.canReachApi && _lastStatus != ServiceStatus.online;
    _lastStatus = status;
    if (cameBack) unawaited(_updateCatalog());
  }

  /// Si ya hay una actualizacion en segundo plano devuelve esa misma, y anota
  /// que al terminar hay que hacer otra: la conexion volvio mientras corria y
  /// esa tanda pudo haberse detenido por la caida.
  Future<void> _updateCatalog() {
    final current = _batch;
    if (current != null) {
      _updateAgain = true;
      return current;
    }
    _updateAgain = false;
    return _batch = _runBatch().whenComplete(() {
      _batch = null;
      if (_updateAgain && _canDownload) unawaited(_updateCatalog());
    });
  }

  /// Online-Preferred (P-02): con la API disponible, primero vuelve a
  /// descargar las paginas ya guardadas, para que lo que se ve sea la version
  /// actual de PokeAPI (y si un dato se altero en la base, se sobrescribe),
  /// y despues sigue con las que faltan. Entre paginas espera [pageDelay].
  ///
  /// Durante toda la tanda sync_metadata queda en "syncing", asi el indicador
  /// no parpadea entre paginas (IND-06). Los errores no se lanzan: quedan
  /// registrados en sync_metadata y se reintenta al volver la conexion.
  Future<void> _runBatch() async {
    try {
      final saved = await _syncDao.get(_key);
      final savedUpTo = saved?.nextOffset ?? 0;
      var offset = 0;
      debugPrint('[Sync] Actualizando el catalogo ($savedUpTo ya guardados)');

      while (_canDownload) {
        if (offset < savedUpTo) {
          final pageOffset = offset;
          await _exclusive(() => _syncPage(pageOffset, keepSyncing: true));
          offset += catalogPageSize;
        } else if (await _hasMorePages()) {
          await _exclusive(() => _syncNextPage(keepSyncing: true));
        } else {
          break;
        }
        await Future<void>.delayed(pageDelay);
      }
      await _finishBatch();
    } on Failure catch (failure) {
      debugPrint('[Sync] La actualizacion se detuvo: ${failure.message}');
    } catch (error) {
      debugPrint('[Sync] Error inesperado en la actualizacion: $error');
    }
  }

  /// Ejecuta una descarga sin pisar otra: si el usuario ya pidio una pagina,
  /// espera a que termine y luego hace la suya.
  Future<void> _exclusive(Future<void> Function() download) async {
    final current = _running;
    if (current != null) {
      try {
        await current;
      } on Object {
        // El error de esa descarga ya quedo registrado; aqui solo se espera.
      }
    }
    await (_running = download().whenComplete(() => _running = null));
  }

  bool get _canDownload => !_disposed && (_lastStatus?.canReachApi ?? false);

  Future<bool> _hasMorePages() async {
    final metadata = await _syncDao.get(_key);
    final total = metadata?.totalRemote;
    return total == null || (metadata?.nextOffset ?? 0) < total;
  }

  /// Al terminar la tanda (completa, o cortada porque se fue la red) el
  /// estado sigue en "syncing": se pasa a "success" con lo que se guardo.
  Future<void> _finishBatch() async {
    if (_disposed || _running != null) return;
    final metadata = await _syncDao.get(_key);
    if (metadata != null && metadata.status == SyncState.syncing) {
      await _syncDao.markSuccess(_key, nextOffset: metadata.nextOffset);
    }
  }

  Future<void> _syncNextPage({bool keepSyncing = false}) async {
    final metadata = await _syncDao.get(_key);
    final offset = metadata?.nextOffset ?? 0;
    final total = metadata?.totalRemote;

    if (total != null && offset >= total) {
      debugPrint('[Sync] El catalogo ya esta completo ($total Pokemon)');
      return;
    }
    await _syncPage(offset, keepSyncing: keepSyncing);
  }

  /// Descarga la pagina que empieza en [offset] y la guarda en Drift.
  ///
  /// Si algo falla marca el estado como error y no borra nada.
  Future<void> _syncPage(int offset, {bool keepSyncing = false}) async {
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
          keepSyncing: keepSyncing,
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
