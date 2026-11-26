import '../entities/catalog_filter.dart';
import '../repositories/pokemon_repository.dart';

/// Caso de uso recuerdo: leer y guardar el filtro del catalogo entre
/// sesiones.
class RememberCatalogFilter {
  const RememberCatalogFilter(this._repository);

  final PokemonRepository _repository;

  Future<CatalogFilter> load() => _repository.loadSavedFilter();

  Future<void> save(CatalogFilter filter) => _repository.saveFilter(filter);
}
