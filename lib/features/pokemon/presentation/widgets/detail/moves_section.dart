import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';

import '../../providers/move_filter.dart';
import '../type_chip.dart';
import 'detail_labels.dart';
import 'detail_section.dart';

/// Tabla de movimientos: chips para elegir el metodo (con cuantos hay en
/// cada uno), selector de orden y la lista filtrada.
class MovesSection extends StatefulWidget {
  const MovesSection({super.key, required this.moves, this.typeNames});

  final List<PokemonMove> moves;

  /// id de tipo -> nombre de PokeAPI, para pintar el chip de tipo de cada
  /// movimiento. Sale de la tabla de efectividad; si no esta, no hay chip.
  final Map<int, String>? typeNames;

  @override
  State<MovesSection> createState() => _MovesSectionState();
}

class _MovesSectionState extends State<MovesSection> {
  var _filter = const MoveFilter();

  @override
  Widget build(BuildContext context) {
    final moves = widget.moves;
    if (moves.isEmpty) {
      return const DetailSection(
        title: 'Movimientos',
        child: DetailEmptyNote('Sin movimientos registrados para esta forma.'),
      );
    }

    final counts = MoveFilter.countByMethod(moves);
    // Si el metodo elegido no tiene movimientos (p. ej. ninguno por nivel),
    // se muestran todos para no dejar la lista vacia.
    final filter = _filter.method != null && counts[_filter.method] == null
        ? _filter.withMethod(null)
        : _filter;
    final visible = filter.apply(moves, nameOf: DetailLabels.move);

    return DetailSection(
      title: 'Movimientos',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final method in MoveLearnMethod.values)
                if (counts[method] != null)
                  ChoiceChip(
                    label: Text(
                      '${DetailLabels.method(method)} (${counts[method]})',
                    ),
                    selected: filter.method == method,
                    onSelected: (_) =>
                        setState(() => _filter = filter.withMethod(method)),
                  ),
              ChoiceChip(
                label: Text('Todos (${moves.length})'),
                selected: filter.method == null,
                onSelected: (_) =>
                    setState(() => _filter = filter.withMethod(null)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SegmentedButton<MoveSort>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(
                value: MoveSort.level,
                label: Text('Por nivel'),
                icon: Icon(Icons.trending_up_rounded),
              ),
              ButtonSegment(
                value: MoveSort.name,
                label: Text('Por nombre'),
                icon: Icon(Icons.sort_by_alpha_rounded),
              ),
            ],
            selected: {filter.sort},
            onSelectionChanged: (selection) =>
                setState(() => _filter = filter.withSort(selection.first)),
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < visible.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            _MoveTile(move: visible[i], typeNames: widget.typeNames),
          ],
        ],
      ),
    );
  }
}

/// Renglon de movimiento: cuando se aprende, nombre, datos de combate y tipo.
class _MoveTile extends StatelessWidget {
  const _MoveTile({required this.move, required this.typeNames});

  final PokemonMove move;
  final Map<int, String>? typeNames;

  /// Cuando se aprende: el nivel, «Evo.» (nivel 0 al evolucionar) o el
  /// metodo.
  String get _when => switch (move.method) {
    MoveLearnMethod.levelUp => move.level == 0 ? 'Evo.' : 'Nv. ${move.level}',
    final method => DetailLabels.method(method),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final typeName = move.typeId == null ? null : typeNames?[move.typeId];
    final details = [
      if (move.damageClass != null) DetailLabels.damageClass(move.damageClass),
      if (move.power != null) 'Pot. ${move.power}',
      if (move.accuracy != null) 'Prec. ${move.accuracy}',
      if (move.pp != null) 'PP ${move.pp}',
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Text(
              _when,
              style: theme.textTheme.labelLarge?.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DetailLabels.move(move),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (details.isNotEmpty)
                  Text(
                    details,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          if (typeName != null) ...[
            const SizedBox(width: 8),
            TypeChip(
              type: PokemonType(id: move.typeId!, name: typeName, slot: 1),
            ),
          ],
        ],
      ),
    );
  }
}
