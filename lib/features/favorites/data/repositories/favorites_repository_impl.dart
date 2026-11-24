import 'package:pokedex/features/pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

import '../../../pokemon/data/datasources/pokemon_local_datasource.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_datasource.dart';

/// Encargado de favoritos: cumple el contrato con los dos datasources
/// locales y convierte las filas en entidades. Todo es local, funciona sin
/// conexión.
class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl({required this._favorites, required this._pokemon});

  final FavoritesLocalDataSource _favorites;
  final PokemonLocalDataSource _pokemon;

  @override
  Stream<Set<int>> watchFavoriteIds() => _favorites.watchIds();

  @override
  Stream<List<Pokemon>> watchFavorites() {
    return _pokemon.watchFavorites().map(
      (rows) => rows.map(PokemonMapper.toEntity).toList(),
    );
  }

  @override
  Future<bool> toggleFavorite(int pokemonId) {
    return _favorites.toggle(pokemonId);
  }
}
