import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';
import 'package:pokedex/features/pokemon/domain/entities/type_chart.dart';

import '../type_chip.dart';
import 'detail_section.dart';

/// Cuadro de debilidades: los tipos atacantes agrupados por cuanto
/// dano le hacen a este Pokemon (x4, x2, x1/2, x1/4, x0).
class MatchupsSection extends StatelessWidget {
  const MatchupsSection({
    super.key,
    required this.types,
    required this.typeChart,
  });

  /// Los tipos del Pokemon (los defensores).
  final List<PokemonType> types;

  /// null mientras la tabla de efectividad no se ha descargado.
  final TypeChart? typeChart;

  @override
  Widget build(BuildContext context) {
    final chart = typeChart;
    if (chart == null) {
      return const DetailSection(
        title: 'Debilidades y resistencias',
        child: DetailEmptyNote(
          'La tabla de tipos todavía no se ha descargado.',
        ),
      );
    }

    final matchups = TypeMatchups.of(chart, [for (final t in types) t.id]);
    final groups = [
      ('×4', 'Muy débil', matchups.superWeak),
      ('×2', 'Débil', matchups.weak),
      ('×½', 'Resiste', matchups.resistant),
      ('×¼', 'Resiste mucho', matchups.superResistant),
      ('×0', 'Inmune', matchups.immune),
    ];

    return DetailSection(
      title: 'Debilidades y resistencias',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (factor, label, ids) in groups)
            if (ids.isNotEmpty)
              _MatchupRow(
                factor: factor,
                label: label,
                types: [
                  for (final id in ids)
                    PokemonType(
                      id: id,
                      name: chart.typeNames[id] ?? '$id',
                      slot: 1,
                    ),
                ],
              ),
        ],
      ),
    );
  }
}

/// Fila de multiplicador: el factor, su nombre y los chips de los tipos.
class _MatchupRow extends StatelessWidget {
  const _MatchupRow({
    required this.factor,
    required this.label,
    required this.types,
  });

  final String factor;
  final String label;
  final List<PokemonType> types;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  factor,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [for (final type in types) TypeChip(type: type)],
            ),
          ),
        ],
      ),
    );
  }
}
