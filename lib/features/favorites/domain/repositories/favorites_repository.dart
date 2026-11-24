import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

/// Contrato de favoritos: lo que la app puede pedir sobre los favoritos,
/// sin saber que por debajo hay una base de datos.
abstract class FavoritesRepository {
  Stream<Set<int>> watchFavoriteIds();
  Stream<List<Pokemon>> watchFavorites();
  Future<bool> toggleFavorite(int pokemonId);
}
