import 'package:flutter/material.dart';

import '../trivia_texts.dart';

/// Marcador final: puntos, aciertos, récord y logros recién ganados.
class TriviaResultView extends StatelessWidget {
  const TriviaResultView({
    super.key,
    required this.texts,
    required this.score,
    required this.correct,
    required this.total,
    required this.isRecord,
    required this.newAchievementIds,
    required this.onPlayAgain,
    required this.onHome,
  });

  final TriviaTexts texts;
  final int score;
  final int correct;
  final int total;
  final bool isRecord;
  final List<String> newAchievementIds;
  final VoidCallback onPlayAgain;
  final VoidCallback onHome;

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
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  texts.gameOver,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: scheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  texts.points(score),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: scheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  texts.hits(correct, total),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: scheme.onSecondaryContainer,
                  ),
                ),
                if (isRecord) ...[
                  const SizedBox(height: 12),
                  Text(
                    texts.newRecord,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (newAchievementIds.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(texts.newAchievements, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final id in newAchievementIds)
            TriviaAchievementTile(texts: texts, id: id, isUnlocked: true),
        ],
        const SizedBox(height: 20),
        FilledButton(
          onPressed: onPlayAgain,
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          child: Text(texts.playAgain),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: onHome,
          style: TextButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          child: Text(texts.backHome),
        ),
      ],
    );
  }
}

/// Una partida del ranking, ya ordenada por la base.
class TriviaRankingItem {
  const TriviaRankingItem({
    required this.score,
    required this.correct,
    required this.total,
    required this.playedAt,
  });

  final int score;
  final int correct;
  final int total;
  final DateTime playedAt;
}

/// Escalafon: las mejores partidas, o el estado vacío si no hay ninguna.
class TriviaRankingView extends StatelessWidget {
  const TriviaRankingView({
    super.key,
    required this.texts,
    required this.items,
  });

  final TriviaTexts texts;
  final List<TriviaRankingItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    if (items.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(
                Icons.leaderboard_outlined,
                size: 56,
                color: scheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                texts.emptyRankingTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                texts.emptyRankingBody,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isTop = index < 3;

        return Card(
          child: MergeSemantics(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isTop
                    ? scheme.primary
                    : scheme.surfaceContainerHighest,
                foregroundColor: isTop ? scheme.onPrimary : scheme.onSurface,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${index + 1}',
                      semanticsLabel: texts.position(index + 1),
                    ),
                  ),
                ),
              ),
              title: Text(
                texts.points(item.score),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                '${texts.hits(item.correct, item.total)} · '
                '${texts.date(item.playedAt)}',
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Pared de medallas: todos los logros, ganados y por ganar. [unlocked] va
/// del id del logro a la fecha en que se ganó.
class TriviaAchievementsView extends StatelessWidget {
  const TriviaAchievementsView({
    super.key,
    required this.texts,
    required this.ids,
    required this.unlocked,
  });

  final TriviaTexts texts;
  final List<String> ids;
  final Map<String, DateTime> unlocked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = ids.where(unlocked.containsKey).length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          texts.unlockedCount(count, ids.length),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        for (final id in ids)
          TriviaAchievementTile(
            texts: texts,
            id: id,
            isUnlocked: unlocked.containsKey(id),
            unlockedAt: unlocked[id],
          ),
      ],
    );
  }
}

/// Medalla individual: el bloqueado lleva candado y lo dice con texto, no
/// solo con el color.
class TriviaAchievementTile extends StatelessWidget {
  const TriviaAchievementTile({
    super.key,
    required this.texts,
    required this.id,
    required this.isUnlocked,
    this.unlockedAt,
  });

  final TriviaTexts texts;
  final String id;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  static IconData _iconOf(String id) => switch (id) {
    'first_game' => Icons.flag_rounded,
    'ten_games' => Icons.repeat_rounded,
    'fifty_correct' => Icons.visibility_rounded,
    'high_score' => Icons.bolt_rounded,
    'perfect_game' => Icons.star_rounded,
    _ => Icons.emoji_events_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final date = unlockedAt;
    final status = !isUnlocked
        ? texts.locked
        : date == null
        ? texts.unlocked
        : texts.unlockedOn(date);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isUnlocked ? scheme.secondaryContainer : null,
      child: MergeSemantics(
        child: ListTile(
          leading: Icon(
            isUnlocked ? _iconOf(id) : Icons.lock_outline_rounded,
            size: 32,
            color: isUnlocked ? scheme.primary : scheme.onSurfaceVariant,
          ),
          title: Text(
            texts.achievementName(id),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text('${texts.achievementGoal(id)}\n$status'),
          isThreeLine: true,
        ),
      ),
    );
  }
}
