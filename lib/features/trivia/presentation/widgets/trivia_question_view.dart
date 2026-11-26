import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_image.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list_tile.dart';

import '../trivia_texts.dart';

/// Ronda en curso: una pregunta con su silueta, el tiempo y las opciones.
///
/// Solo dibuja: el tiempo, los puntos y qué se respondió los decide el
/// provider de la partida.
class TriviaQuestionView extends StatelessWidget {
  const TriviaQuestionView({
    super.key,
    required this.texts,
    required this.pokemon,
    required this.options,
    required this.number,
    required this.total,
    required this.score,
    required this.secondsLeft,
    required this.secondsTotal,
    required this.onAnswer,
    required this.onNext,
    this.answered = false,
    this.selectedId,
    this.earnedPoints = 0,
  });

  final TriviaTexts texts;

  /// El Pokémon correcto.
  final Pokemon pokemon;
  final List<Pokemon> options;
  final int number;
  final int total;
  final int score;
  final int secondsLeft;
  final int secondsTotal;

  /// true cuando ya se respondió o se acabó el tiempo.
  final bool answered;

  /// Opción elegida; null si se acabó el tiempo.
  final int? selectedId;
  final int earnedPoints;
  final ValueChanged<Pokemon> onAnswer;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    final top = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 12,
          children: [
            Text(
              texts.question(number, total),
              style: theme.textTheme.titleSmall,
            ),
            Text(
              texts.points(score),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TriviaTimerBar(
          texts: texts,
          secondsLeft: secondsLeft,
          secondsTotal: secondsTotal,
        ),
      ],
    );

    final image = TriviaSilhouette(
      texts: texts,
      pokemon: pokemon,
      revealed: answered,
      size: isLandscape ? 170 : 220,
    );

    final answers = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final option in options)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TriviaOptionButton(
              texts: texts,
              label: option.displayName,
              state: _stateOf(option),
              onPressed: answered ? null : () => onAnswer(option),
            ),
          ),
        if (answered) ...[
          const SizedBox(height: 4),
          Semantics(
            liveRegion: true,
            child: Text(
              _feedback,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: onNext,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            child: Text(number == total ? texts.seeResult : texts.next),
          ),
        ],
      ],
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: isLandscape
          ? Column(
              children: [
                top,
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: image),
                    const SizedBox(width: 20),
                    Expanded(child: answers),
                  ],
                ),
              ],
            )
          : Column(
              children: [
                top,
                const SizedBox(height: 16),
                image,
                const SizedBox(height: 16),
                answers,
              ],
            ),
    );
  }

  String get _feedback {
    if (selectedId == null) return texts.timeUp(pokemon.displayName);
    return selectedId == pokemon.id
        ? texts.correct(earnedPoints)
        : texts.wrong(pokemon.displayName);
  }

  TriviaOptionState _stateOf(Pokemon option) {
    if (!answered) return TriviaOptionState.idle;
    if (option.id == pokemon.id) return TriviaOptionState.correct;
    if (option.id == selectedId) return TriviaOptionState.wrong;
    return TriviaOptionState.dimmed;
  }
}

/// Sombra chinesca: el artwork pintado de un solo color; al revelarse
/// recupera sus colores.
class TriviaSilhouette extends StatelessWidget {
  const TriviaSilhouette({
    super.key,
    required this.texts,
    required this.pokemon,
    required this.revealed,
    required this.size,
  });

  final TriviaTexts texts;
  final Pokemon pokemon;
  final bool revealed;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final image = PokemonImage(
      url: pokemon.imageUrl,
      size: size,
      // El lector de pantalla no puede decir el nombre antes de tiempo.
      semanticLabel: revealed
          ? texts.imageOf(pokemon.displayName)
          : texts.hiddenImage,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // Sin revelar no se usa el tinte del tipo: seria una pista.
        color: revealed
            ? pokemon.imageTint(theme)
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ColorFiltered(
        // srcIn conserva la forma (el alfa) y cambia todos los colores por
        // uno; dst deja la imagen tal cual.
        colorFilter: revealed
            ? const ColorFilter.mode(Colors.transparent, BlendMode.dst)
            : ColorFilter.mode(scheme.onSurface, BlendMode.srcIn),
        child: image,
      ),
    );
  }
}

/// Reloj de arena: barra con el tiempo que queda; los últimos 5 segundos
/// cambia de color y siempre muestra el número.
class TriviaTimerBar extends StatelessWidget {
  const TriviaTimerBar({
    super.key,
    required this.texts,
    required this.secondsLeft,
    required this.secondsTotal,
  });

  final TriviaTexts texts;
  final int secondsLeft;
  final int secondsTotal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = secondsLeft <= 5
        ? theme.colorScheme.error
        : theme.colorScheme.primary;

    return Semantics(
      label: texts.secondsLeft(secondsLeft),
      child: ExcludeSemantics(
        child: Row(
          children: [
            Icon(Icons.timer_outlined, size: 20, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: secondsLeft / secondsTotal),
                duration: MediaQuery.disableAnimationsOf(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 300),
                builder: (_, value, _) => LinearProgressIndicator(
                  value: value,
                  minHeight: 10,
                  color: color,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$secondsLeft s',
              style: theme.textTheme.titleSmall?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

enum TriviaOptionState { idle, correct, wrong, dimmed }

/// Boton de respuesta: además del color usa un icono, para que no dependa
/// solo de distinguir verde y rojo.
class TriviaOptionButton extends StatelessWidget {
  const TriviaOptionButton({
    super.key,
    required this.texts,
    required this.label,
    required this.state,
    required this.onPressed,
  });

  final TriviaTexts texts;
  final String label;
  final TriviaOptionState state;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    final (background, foreground) = switch (state) {
      TriviaOptionState.correct =>
        isDark
            ? (const Color(0xFF1B4D1D), const Color(0xFFDCEFD9))
            : (const Color(0xFFDCEFD9), const Color(0xFF1B4D1D)),
      TriviaOptionState.wrong => (
        scheme.errorContainer,
        scheme.onErrorContainer,
      ),
      _ => (scheme.surfaceContainerLow, scheme.onSurface),
    };
    final icon = switch (state) {
      TriviaOptionState.correct => Icons.check_circle_rounded,
      TriviaOptionState.wrong => Icons.cancel_rounded,
      _ => null,
    };
    final hint = switch (state) {
      TriviaOptionState.correct => ', ${texts.correctOption}',
      TriviaOptionState.wrong => ', ${texts.wrongOption}',
      _ => '',
    };

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: background,
        disabledBackgroundColor: background,
        foregroundColor: foreground,
        disabledForegroundColor: foreground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              semanticsLabel: '$label$hint',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          if (icon != null) Icon(icon, size: 22),
        ],
      ),
    );
  }
}
