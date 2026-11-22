import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';

/// Criterio de orden de la lista de movimientos.
enum MoveSort { level, name }

/// Tamiz de movimientos: el metodo elegido y el orden de la lista en la
/// pagina de detalle.
class MoveFilter {
  const MoveFilter({
    this.method = MoveLearnMethod.levelUp,
    this.sort = MoveSort.level,
  });

  /// Metodo que se muestra; null muestra todos.
  final MoveLearnMethod? method;
  final MoveSort sort;

  MoveFilter withMethod(MoveLearnMethod? method) =>
      MoveFilter(method: method, sort: sort);

  MoveFilter withSort(MoveSort sort) => MoveFilter(method: method, sort: sort);

  /// Seleccion de movimientos: deja los del metodo elegido y los ordena.
  ///
  /// [nameOf] da el nombre que se ve en pantalla (en espanol o ingles), para
  /// ordenar por el mismo texto que lee el usuario.
  List<PokemonMove> apply(
    List<PokemonMove> moves, {
    required String Function(PokemonMove move) nameOf,
  }) {
    final selected = [
      for (final move in moves)
        if (method == null || move.method == method) move,
    ];
    int byName(PokemonMove a, PokemonMove b) =>
        nameOf(a).toLowerCase().compareTo(nameOf(b).toLowerCase());

    selected.sort(
      sort == MoveSort.level
          ? (a, b) {
              final byLevel = a.level.compareTo(b.level);
              return byLevel != 0 ? byLevel : byName(a, b);
            }
          : byName,
    );
    return selected;
  }

  /// Totales por metodo, para mostrar cuantos hay en cada opcion del filtro.
  static Map<MoveLearnMethod, int> countByMethod(List<PokemonMove> moves) {
    final counts = <MoveLearnMethod, int>{};
    for (final move in moves) {
      counts[move.method] = (counts[move.method] ?? 0) + 1;
    }
    return counts;
  }
}
