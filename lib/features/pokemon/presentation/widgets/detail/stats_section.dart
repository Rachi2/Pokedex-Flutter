import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';

import '../type_chip.dart';
import 'detail_labels.dart';
import 'detail_section.dart';

/// Barras de estadisticas: una fila por atributo con su valor y una barra
/// proporcional al maximo (255), mas el total arriba a la derecha. Todo va
/// del color del tipo principal del Pokemon.
class StatsSection extends StatelessWidget {
  const StatsSection({super.key, required this.detail});

  final PokemonDetail detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (bar, track) = _typeColors(theme);

    return DetailSection(
      title: 'Estadísticas base',
      trailing: detail.stats.isEmpty
          ? null
          : Text(
              'Total ${detail.totalBaseStats}',
              style: theme.textTheme.labelLarge?.copyWith(
                color: bar,
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
      child: detail.stats.isEmpty
          ? const DetailEmptyNote('Sin estadísticas registradas.')
          : Column(
              children: [
                for (final stat in detail.stats)
                  _StatRow(stat: stat, barColor: bar, trackColor: track),
              ],
            ),
    );
  }

  /// Tinte del tipo: color de la barra y de su fondo segun el tipo principal
  /// (slot 1). Son los mismos colores del chip del tipo, asi que en oscuro
  /// tambien se invierten. Sin tipos se usan los colores del tema.
  (Color, Color) _typeColors(ThemeData theme) {
    final types = detail.pokemon.types;
    final main =
        types.where((type) => type.slot == 1).firstOrNull ?? types.firstOrNull;
    if (main == null) {
      return (
        theme.colorScheme.primary,
        theme.colorScheme.surfaceContainerHighest,
      );
    }
    final style = TypeStyle.of(main.name);
    return (
      style.foregroundFor(theme.brightness),
      style.backgroundFor(theme.brightness),
    );
  }
}

/// Fila de atributo: nombre corto, valor y barra.
class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.stat,
    required this.barColor,
    required this.trackColor,
  });

  final PokemonStat stat;
  final Color barColor;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final animate = !MediaQuery.disableAnimationsOf(context);

    return Semantics(
      label: '${DetailLabels.stat(stat.name)}: ${stat.baseStat} de 255',
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              SizedBox(
                width: 76,
                child: Text(
                  DetailLabels.statShort(stat.name),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(
                width: 36,
                child: Text(
                  '${stat.baseStat}',
                  textAlign: TextAlign.end,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: stat.ratio.clamp(0, 1)),
                    duration: animate
                        ? const Duration(milliseconds: 500)
                        : Duration.zero,
                    curve: Curves.easeOutCubic,
                    builder: (_, value, _) => LinearProgressIndicator(
                      value: value,
                      minHeight: 8,
                      color: barColor,
                      backgroundColor: trackColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
