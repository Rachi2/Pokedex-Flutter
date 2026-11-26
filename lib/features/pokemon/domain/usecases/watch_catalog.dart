import '../entities/catalog_filter.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

/// Caso de uso vitrina: observar el catalogo guardado en la base local,
/// con la busqueda, los filtros y el orden elegidos.
class WatchCatalog {
  const WatchCatalog(this._repository);

  final PokemonRepository _repository;

  Stream<List<Pokemon>> call([CatalogFilter filter = const CatalogFilter()]) =>
      _repository.watchCatalog(filter);
}
