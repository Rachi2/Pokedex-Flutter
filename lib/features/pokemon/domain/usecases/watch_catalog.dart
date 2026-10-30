import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

/// Caso de uso: observar el catalogo guardado en la base local.
class WatchCatalog {
  const WatchCatalog(this._repository);

  final PokemonRepository _repository;

  Stream<List<Pokemon>> call() => _repository.watchCatalog();
}
