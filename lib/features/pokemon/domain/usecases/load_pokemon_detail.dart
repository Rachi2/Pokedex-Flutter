import '../repositories/pokemon_detail_repository.dart';

/// Encargo del detalle: descarga y guarda el detalle de un Pokemon. Se usa
/// al abrir la pagina, y de paso comprueba si sus datos fueron alterados.
class LoadPokemonDetail {
  const LoadPokemonDetail(this._repository);

  final PokemonDetailRepository _repository;

  Future<void> call(int pokemonId) => _repository.loadDetail(pokemonId);
}
