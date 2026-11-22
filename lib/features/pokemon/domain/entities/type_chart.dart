/// Duelo de tipos: la tabla de efectividad de PokeAPI (18 x 18).
///
/// Guarda el factor de cada tipo atacante contra cada tipo defensor:
/// 0, 50, 100 o 200 (x0, x0.5, x1, x2).
class TypeChart {
  const TypeChart({required this.typeNames, required this.factors});

  /// Nombre de PokeAPI de cada tipo, por id ("fire", "water"...).
  final Map<int, String> typeNames;

  /// factors[atacante][defensor] = 0, 50, 100 o 200.
  final Map<int, Map<int, int>> factors;

  /// Producto de factores: multiplicador de un ataque de [attackingTypeId]
  /// contra un Pokemon con [defendingTypeIds]. Con dos tipos se multiplican
  /// los dos factores, asi salen el x4 y el x0.25, que la API no trae.
  double multiplier(int attackingTypeId, List<int> defendingTypeIds) {
    var result = 1.0;
    for (final defending in defendingTypeIds) {
      final factor = factors[attackingTypeId]?[defending] ?? 100;
      result *= factor / 100;
    }
    return result;
  }
}

/// Escudo del Pokemon: sus debilidades, resistencias e inmunidades,
/// agrupadas por multiplicador. Cada lista tiene ids de tipos atacantes.
class TypeMatchups {
  const TypeMatchups({
    required this.superWeak,
    required this.weak,
    required this.resistant,
    required this.superResistant,
    required this.immune,
  });

  /// x4
  final List<int> superWeak;

  /// x2
  final List<int> weak;

  /// x0.5
  final List<int> resistant;

  /// x0.25
  final List<int> superResistant;

  /// x0
  final List<int> immune;

  /// Calculo de las debilidades: prueba cada tipo atacante de [chart]
  /// contra los tipos del Pokemon. Los de x1 no se listan.
  factory TypeMatchups.of(TypeChart chart, List<int> defendingTypeIds) {
    final superWeak = <int>[];
    final weak = <int>[];
    final resistant = <int>[];
    final superResistant = <int>[];
    final immune = <int>[];
    for (final attacking in chart.typeNames.keys) {
      final value = chart.multiplier(attacking, defendingTypeIds);
      if (value == 0) {
        immune.add(attacking);
      } else if (value >= 4) {
        superWeak.add(attacking);
      } else if (value >= 2) {
        weak.add(attacking);
      } else if (value <= 0.25) {
        superResistant.add(attacking);
      } else if (value <= 0.5) {
        resistant.add(attacking);
      }
    }
    return TypeMatchups(
      superWeak: superWeak,
      weak: weak,
      resistant: resistant,
      superResistant: superResistant,
      immune: immune,
    );
  }
}
