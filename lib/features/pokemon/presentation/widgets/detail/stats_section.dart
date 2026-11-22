import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';

import 'detail_labels.dart';
import 'detail_section.dart';

/// Barras de estadisticas: una fila por atributo con su valor y una barra
/// proporcional al maximo (255), mas el total arriba a la derecha.
class StatsSection extends StatelessWidget {
  const StatsSection({super.key, required this.detail});

  final PokemonDetail detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DetailSection(
      title: 'Estadísticas base',
      trailing: detail.stats.isEmpty
          ? null
          : Text(
              'Total ${detail.totalBaseStats}',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
      child: detail.stats.isEmpty
          ? const DetailEmptyNote('Sin estadísticas registradas.')
          : Column(
              children: [for (final stat in detail.stats) _StatRow(stat: stat)],
            ),
    );
  }
}

/// Fila de atributo: nombre corto, valor y barra.
class _StatRow extends StatelessWidget {
  const _StatRow({required this.stat});

  final PokemonStat stat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
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
                    color: scheme.onSurfaceVariant,
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
                      color: _barColor(stat.baseStat, theme.brightness),
                      backgroundColor: scheme.surfaceContainerHighest,
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

  /// Color por tramo: bajo, medio, alto y muy alto. El numero sigue escrito,
  /// asi que el color no es la unica pista.
  static Color _barColor(int value, Brightness brightness) {
    final dark = brightness == Brightness.dark;
    return switch (value) {
      < 60 => dark ? const Color(0xFFFFB3A6) : const Color(0xFFC4472F),
      < 90 => dark ? const Color(0xFFF5C979) : const Color(0xFFB07A0E),
      < 120 => dark ? const Color(0xFF9BD497) : const Color(0xFF2E7D32),
      _ => dark ? const Color(0xFF8ED3E8) : const Color(0xFF00708A),
    };
  }
}
