import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/di/core_providers.dart';

import 'data/datasources/pokemon_detail_local_datasource.dart';
import 'data/datasources/pokemon_local_datasource.dart';
import 'data/datasources/pokemon_remote_datasource.dart';
import 'data/repositories/pokemon_detail_repository_impl.dart';
import 'data/repositories/pokemon_repository_impl.dart';
import 'data/sync/catalog_sync_coordinator.dart';
import 'domain/repositories/pokemon_detail_repository.dart';
import 'domain/repositories/pokemon_repository.dart';
import 'domain/usecases/load_next_page.dart';
import 'domain/usecases/load_pokemon_detail.dart';
import 'domain/usecases/refresh_catalog.dart';
import 'domain/usecases/watch_catalog.dart';
import 'domain/usecases/watch_catalog_sync.dart';
import 'domain/usecases/watch_pokemon.dart';
import 'domain/usecases/watch_pokemon_detail.dart';
import 'domain/usecases/watch_type_chart.dart';

// Ensamblaje de la feature pokemon:
// datasources -> coordinador -> repositorio -> casos de uso.
// Para una prueba se puede reemplazar cualquier pieza con overrides
// del ProviderScope.

/// Conducto remoto: el datasource que habla con PokeAPI.
final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((
  ref,
) {
  return PokemonRemoteDataSource(ref.watch(graphqlClientProvider));
});

/// Conducto local: el datasource del catalogo en Drift.
final pokemonLocalDataSourceProvider = Provider<PokemonLocalDataSource>((ref) {
  return PokemonLocalDataSource(ref.watch(databaseProvider));
});

/// Director de descargas: el coordinador, que deja de escuchar la red al
/// apagarse Riverpod.
final catalogSyncCoordinatorProvider = Provider<CatalogSyncCoordinator>((ref) {
  final database = ref.watch(databaseProvider);
  final coordinator = CatalogSyncCoordinator(
    database: database,
    remote: ref.watch(pokemonRemoteDataSourceProvider),
    local: ref.watch(pokemonLocalDataSourceProvider),
    syncDao: database.syncMetadataDao,
    connectivity: ref.watch(connectivityRepositoryProvider),
  );
  ref.onDispose(coordinator.dispose);
  return coordinator;
});

/// Repositorio del catalogo, armado con sus tres piezas.
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(
    local: ref.watch(pokemonLocalDataSourceProvider),
    syncDao: ref.watch(databaseProvider).syncMetadataDao,
    coordinator: ref.watch(catalogSyncCoordinatorProvider),
  );
});

/// Atajos de los casos de uso para la presentacion (este y los de abajo).
final watchCatalogProvider = Provider<WatchCatalog>((ref) {
  return WatchCatalog(ref.watch(pokemonRepositoryProvider));
});

final loadNextPageProvider = Provider<LoadNextPage>((ref) {
  return LoadNextPage(ref.watch(pokemonRepositoryProvider));
});

final refreshCatalogProvider = Provider<RefreshCatalog>((ref) {
  return RefreshCatalog(ref.watch(pokemonRepositoryProvider));
});

final watchCatalogSyncProvider = Provider<WatchCatalogSync>((ref) {
  return WatchCatalogSync(ref.watch(pokemonRepositoryProvider));
});

final watchPokemonProvider = Provider<WatchPokemon>((ref) {
  return WatchPokemon(ref.watch(pokemonRepositoryProvider));
});

/// Custodia local del detalle: lee y escribe el detalle en Drift.
final pokemonDetailLocalDataSourceProvider =
    Provider<PokemonDetailLocalDataSource>((ref) {
      return PokemonDetailLocalDataSource(
        ref.watch(databaseProvider),
        ref.watch(pokemonLocalDataSourceProvider),
      );
    });

/// Union del detalle: une el datasource remoto y el local.
final pokemonDetailRepositoryProvider = Provider<PokemonDetailRepository>((
  ref,
) {
  return PokemonDetailRepositoryImpl(
    remote: ref.watch(pokemonRemoteDataSourceProvider),
    local: ref.watch(pokemonDetailLocalDataSourceProvider),
  );
});

final watchPokemonDetailProvider = Provider<WatchPokemonDetail>((ref) {
  return WatchPokemonDetail(ref.watch(pokemonDetailRepositoryProvider));
});

final loadPokemonDetailProvider = Provider<LoadPokemonDetail>((ref) {
  return LoadPokemonDetail(ref.watch(pokemonDetailRepositoryProvider));
});

final watchTypeChartProvider = Provider<WatchTypeChart>((ref) {
  return WatchTypeChart(ref.watch(pokemonDetailRepositoryProvider));
});
