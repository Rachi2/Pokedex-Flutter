import '../entities/pokemon_detail.dart';
import '../entities/type_chart.dart';

/// Ventanilla del detalle: lo que se puede pedir sobre el detalle completo
/// de un Pokemon, sin decir de donde sale.
abstract class PokemonDetailRepository {
  /// Emite el detalle guardado en la base local, o null si todavia no esta,
  /// y vuelve a emitir cada vez que cambia.
  Stream<PokemonDetail?> watchDetail(int pokemonId);

  /// Descarga el detalle de PokeAPI y lo guarda. Al hacerlo sobrescribe lo
  /// guardado, asi que tambien restaura los datos alterados de ese Pokemon.
  ///
  /// Lanza un Failure si no se pudo descargar; lo guardado no se toca.
  Future<void> loadDetail(int pokemonId);

  /// Emite la tabla de efectividad guardada, o null si todavia no esta.
  Stream<TypeChart?> watchTypeChart();
}
