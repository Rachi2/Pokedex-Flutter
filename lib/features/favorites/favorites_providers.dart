import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/di/core_providers.dart';
import 'package:pokedex/features/pokemon/pokemon_providers.dart';

import 'data/datasources/favorites_local_datasource.dart';
import 'data/repositories/favorites_repository_impl.dart';
import 'domain/repositories/favorites_repository.dart';

// Ensamblaje de la feature favorites: datasources -> repositorio.
// Todo es local: funciona sin conexion.

/// Libreta en Drift: el datasource de la tabla favorites.
final favoritesLocalDataSourceProvider = Provider<FavoritesLocalDataSource>((
    ref,
    ) {
  return FavoritesLocalDataSource(ref.watch(databaseProvider));
});

/// Repositorio de favoritos, armado con la libreta y el datasource del
/// catalogo (para leer los Pokemon marcados con sus tipos).
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl(
    favorites: ref.watch(favoritesLocalDataSourceProvider),
    pokemon: ref.watch(pokemonLocalDataSourceProvider),
  );
});