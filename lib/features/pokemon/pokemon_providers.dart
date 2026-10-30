import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/di/core_providers.dart';

import 'data/datasources/pokemon_local_datasource.dart';
import 'data/datasources/pokemon_remote_datasource.dart';
import 'data/repositories/pokemon_repository_impl.dart';
import 'data/sync/catalog_sync_coordinator.dart';
import 'domain/repositories/pokemon_repository.dart';
import 'domain/usecases/load_next_page.dart';
import 'domain/usecases/refresh_catalog.dart';
import 'domain/usecases/watch_catalog.dart';
import 'domain/usecases/watch_catalog_sync.dart';
import 'domain/usecases/watch_pokemon.dart';

// Arma la feature pokemon:
// datasources -> coordinador -> repositorio -> casos de uso.
// Para una prueba se puede reemplazar cualquier pieza con overrides
// del ProviderScope (RNF-MAN-03).

final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((
  ref,
) {
  return PokemonRemoteDataSource(ref.watch(graphqlClientProvider));
});

final pokemonLocalDataSourceProvider = Provider<PokemonLocalDataSource>((ref) {
  return PokemonLocalDataSource(ref.watch(databaseProvider));
});

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

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(
    local: ref.watch(pokemonLocalDataSourceProvider),
    syncDao: ref.watch(databaseProvider).syncMetadataDao,
    coordinator: ref.watch(catalogSyncCoordinatorProvider),
  );
});

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
