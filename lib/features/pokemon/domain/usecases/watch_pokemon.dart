import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

/// Caso de uso: observar un Pokemon guardado en la base local.
class WatchPokemon {
  const WatchPokemon(this._repository);

  final PokemonRepository _repository;

  Stream<Pokemon?> call(int id) => _repository.watchPokemon(id);
}
