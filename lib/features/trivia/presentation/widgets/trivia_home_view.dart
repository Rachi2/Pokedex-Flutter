import 'package:flutter/material.dart';

import '../trivia_texts.dart';

/// Antesala: la portada de la trivia, con las reglas, los totales del
/// usuario y los botones de jugar, ranking y logros.
class TriviaHomeView extends StatelessWidget {
  const TriviaHomeView({
    super.key,
    required this.texts,
    required this.questions,
    required this.options,
    required this.seconds,
    required this.bestScore,
    required this.games,
    required this.correct,
    required this.onPlay,
    required this.onRanking,
    required this.onAchievements,
    this.isPreparing = false,
  });

  final TriviaTexts texts;
  final int questions;
  final int options;
  final int seconds;
  final int bestScore;
  final int games;
  final int correct;
  final VoidCallback onPlay;
  final VoidCallback onRanking;
  final VoidCallback onAchievements;

  /// true mientras se eligen las preguntas: el botón muestra el progreso.
  final bool isPreparing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          margin: EdgeInsets.zero,
          color: scheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ExcludeSemantics(
                  child: Icon(
                    Icons.catching_pokemon,
                    size: 88,
                    color: scheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 12),
                Semantics(
                  header: true,
                  child: Text(
                    texts.title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  texts.rules(questions, options, seconds),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: isPreparing ? null : onPlay,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                  icon: isPreparing
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.play_arrow_rounded),
                  label: Text(texts.play),
                ),
                const SizedBox(height: 8),
                Text(
                  texts.offlineReady,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Wrap: con el texto muy grande las cifras pasan a otra línea.
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 16,
          runSpacing: 12,
          children: [
            _Figure(value: bestScore, label: texts.best),
            _Figure(value: games, label: texts.games),
            _Figure(value: correct, label: texts.totalHits),
          ],
        ),
        const SizedBox(height: 16),
        _Link(
          icon: Icons.leaderboard_outlined,
          label: texts.ranking,
          onTap: onRanking,
        ),
        _Link(
          icon: Icons.emoji_events_outlined,
          label: texts.achievements,
          onTap: onAchievements,
        ),
      ],
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MergeSemantics(
      child: Column(
        children: [
          Text(
            '$value',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.primary,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _Link extends StatelessWidget {
  const _Link({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}

/// Sala vacia: explica que faltan Pokémon con imagen guardada y lleva al
/// catálogo.
class TriviaNotEnoughView extends StatelessWidget {
  const TriviaNotEnoughView({
    super.key,
    required this.texts,
    required this.available,
    required this.needed,
    required this.onOpenCatalog,
  });

  final TriviaTexts texts;
  final int available;
  final int needed;
  final VoidCallback onOpenCatalog;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.catching_pokemon_outlined, size: 56, color: muted),
            const SizedBox(height: 16),
            Text(
              texts.notEnoughTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              texts.notEnoughBody(available, needed),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: muted),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onOpenCatalog,
              child: Text(texts.openCatalog),
            ),
          ],
        ),
      ),
    );
  }
}
