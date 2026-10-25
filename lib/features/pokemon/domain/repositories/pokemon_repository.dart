import '../entities/catalog_sync_status.dart';
import '../entities/pokemon.dart';

abstract class PokemonRepository {
  /// Emite la lista guardada en la base local cada vez que cambia.
  Stream<List<Pokemon>> watchCatalog();

  /// Emite un Pokemon, o null si no esta guardado.
  Stream<Pokemon?> watchPokemon(int id);

  /// Descarga la siguiente página de PokeAPI y la guarda localmente.
  Future<void> loadNextPage();

  /// Vuelve a pedir la primera pagina.
  Future<void> refresh();

  /// Emite el estado y la fecha de la ultima sincronizacion.
  Stream<CatalogSyncStatus> watchCatalogSync();
}
