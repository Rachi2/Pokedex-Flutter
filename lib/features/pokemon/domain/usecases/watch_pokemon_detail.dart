import '../entities/pokemon_detail.dart';
import '../repositories/pokemon_detail_repository.dart';

/// Catalejo del detalle: observa el detalle guardado de un Pokemon.
class WatchPokemonDetail {
  const WatchPokemonDetail(this._repository);

  final PokemonDetailRepository _repository;

  Stream<PokemonDetail?> call(int pokemonId) =>
      _repository.watchDetail(pokemonId);
}
