import '../entities/catalog_sync_status.dart';
import '../entities/pokemon.dart';
import '../entities/catalog_filter.dart';

/// Contrato del catalogo: lo que la presentacion puede pedir, sin saber de
/// donde salen los datos.
abstract class PokemonRepository {
  /// Emite la lista guardada que pasa el [filter] (busqueda, tipo,
  /// generacion y orden) cada vez que cambia la base local.
  Stream<List<Pokemon>> watchCatalog([
    CatalogFilter filter = const CatalogFilter(),
  ]);

  /// Emite cuantos Pokemon del catalogo hay guardados en el telefono.
  Stream<int> watchSavedCount();

  /// Emite un Pokemon, o null si no esta guardado.
  Stream<Pokemon?> watchPokemon(int id);

  /// Descarga la siguiente página de PokeAPI y la guarda localmente.
  Future<void> loadNextPage();

  /// Vuelve a pedir la primera pagina.
  Future<void> refresh();

  /// Emite el estado y la fecha de la ultima sincronizacion.
  Stream<CatalogSyncStatus> watchCatalogSync();
}
