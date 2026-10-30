import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/sync_metadata_dao.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_sync_status.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';

import '../datasources/pokemon_local_datasource.dart';
import '../mappers/pokemon_mapper.dart';
import '../sync/catalog_sync_coordinator.dart';

/// Cumple el contrato PokemonRepository.
///
/// Los watch... leen solo de Drift; las descargas se las pide al coordinador.
class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({
    required this._local,
    required this._syncDao,
    required this._coordinator,
  });

  final PokemonLocalDataSource _local;
  final SyncMetadataDao _syncDao;
  final CatalogSyncCoordinator _coordinator;

  @override
  Stream<List<Pokemon>> watchCatalog() {
    return _local.watchCatalog().map(
      (rows) => rows.map(PokemonMapper.toEntity).toList(),
    );
  }

  @override
  Stream<Pokemon?> watchPokemon(int id) {
    return _local
        .watchById(id)
        .map((row) => row == null ? null : PokemonMapper.toEntity(row));
  }

  @override
  Future<void> loadNextPage() => _coordinator.syncNextPage();

  @override
  Future<void> refresh() => _coordinator.refresh();

  @override
  Stream<CatalogSyncStatus> watchCatalogSync() {
    return _syncDao.watch(SyncMetadataDao.catalogKey).map(_toSyncStatus);
  }

  /// Fila de sync_metadata -> entidad del dominio.
  CatalogSyncStatus _toSyncStatus(SyncMetadataRow? row) {
    if (row == null) return const CatalogSyncStatus(state: SyncState.idle);

    final total = row.totalRemote;
    return CatalogSyncStatus(
      state: row.status,
      lastSyncedAt: row.lastSuccessAt,
      hasMorePages: total == null || row.nextOffset < total,
    );
  }
}
