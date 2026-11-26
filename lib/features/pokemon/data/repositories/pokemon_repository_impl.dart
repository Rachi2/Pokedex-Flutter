import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/database/sync_metadata_dao.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_sync_status.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_filter.dart';

import '../datasources/catalog_preferences_local_datasource.dart';
import '../datasources/pokemon_local_datasource.dart';
import '../mappers/pokemon_mapper.dart';
import '../sync/catalog_sync_coordinator.dart';

/// Intermediario del catalogo: cumple el contrato PokemonRepository.
///
/// Los watch... leen solo de Drift; las descargas se las pide al coordinador
/// y el filtro elegido lo guarda en preferences.
class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({
    required this._local,
    required this._syncDao,
    required this._coordinator,
    required this._preferences,
  });

  final PokemonLocalDataSource _local;
  final SyncMetadataDao _syncDao;
  final CatalogSyncCoordinator _coordinator;
  final CatalogPreferencesLocalDataSource _preferences;

  @override
  Stream<List<Pokemon>> watchCatalog([
    CatalogFilter filter = const CatalogFilter(),
  ]) {
    return _local
        .watchCatalog(filter)
        .map((rows) => rows.map(PokemonMapper.toEntity).toList());
  }

  @override
  Stream<int> watchSavedCount() => _local.watchSavedCount();

  @override
  Future<CatalogFilter> loadSavedFilter() => _preferences.loadFilter();

  @override
  Future<void> saveFilter(CatalogFilter filter) =>
      _preferences.saveFilter(filter);

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

  /// Conversion de estado: fila de sync_metadata -> entidad del dominio.
  CatalogSyncStatus _toSyncStatus(SyncMetadataRow? row) {
    if (row == null) return const CatalogSyncStatus(state: SyncState.idle);

    final total = row.totalRemote;
    return CatalogSyncStatus(
      state: row.status,
      lastSyncedAt: row.lastSuccessAt,
      hasMorePages: total == null || row.nextOffset < total,
      totalRemote: total,
    );
  }
}
