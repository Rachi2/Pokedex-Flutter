import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

import '../trivia_texts.dart';
import '../widgets/trivia_home_view.dart';
import '../widgets/trivia_question_view.dart';
import '../widgets/trivia_result_views.dart';

enum _Screen { home, question, result, ranking, achievements, notEnough }

/// Partida de ensayo: las pantallas de la trivia con datos de prueba y un
/// botón para cambiar de idioma, mientras los providers no están listos.
/// Nada se guarda. Solo se abre desde Ajustes en modo depuracion; se borra
/// al conectar.
class TriviaPreviewPage extends StatefulWidget {
  const TriviaPreviewPage({super.key});

  @override
  State<TriviaPreviewPage> createState() => _TriviaPreviewPageState();
}

class _TriviaPreviewPageState extends State<TriviaPreviewPage> {
  static const _seconds = 15;
  static const _total = 10;
  static const _achievementIds = [
    'first_game',
    'ten_games',
    'fifty_correct',
    'high_score',
    'perfect_game',
  ];

  static final _pokemon = [
    for (final (id, name) in const [
      (1, 'bulbasaur'),
      (4, 'charmander'),
      (6, 'charizard'),
      (7, 'squirtle'),
      (25, 'pikachu'),
      (39, 'jigglypuff'),
      (94, 'gengar'),
      (131, 'lapras'),
      (133, 'eevee'),
      (143, 'snorlax'),
      (150, 'mewtwo'),
      (448, 'lucario'),
    ])
      Pokemon(
        id: id,
        name: name,
        nationalDexNumber: id,
        artworkUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/'
            'sprites/pokemon/other/official-artwork/$id.png',
        spriteUrl: null,
        types: const [],
      ),
  ];

  var _texts = TriviaTexts.es;
  var _screen = _Screen.home;
  Timer? _timer;

  var _order = <Pokemon>[];
  var _options = <Pokemon>[];
  var _index = 0;
  var _left = _seconds;
  var _score = 0;
  var _hits = 0;
  var _earned = 0;
  var _answered = false;
  int? _selectedId;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _go(_Screen screen) {
    _timer?.cancel();
    setState(() => _screen = screen);
  }

  void _start() {
    _order = [..._pokemon]..shuffle();
    _index = 0;
    _score = 0;
    _hits = 0;
    _go(_Screen.question);
    _prepare();
  }

  void _prepare() {
    final answer = _order[_index];
    final others = _pokemon.where((p) => p.id != answer.id).toList()..shuffle();
    setState(() {
      _options = [answer, ...others.take(3)]..shuffle();
      _left = _seconds;
      _answered = false;
      _selectedId = null;
      _earned = 0;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _left--);
      if (_left == 0) _finish(null);
    });
  }

  void _finish(Pokemon? choice) {
    _timer?.cancel();
    setState(() {
      _answered = true;
      _selectedId = choice?.id;
      if (choice?.id == _order[_index].id) {
        _earned = 100 + 5 * _left;
        _score += _earned;
        _hits++;
      }
    });
  }

  void _next() {
    if (_index == _total - 1) return _go(_Screen.result);
    _index++;
    _prepare();
  }

  @override
  Widget build(BuildContext context) {
    final isHome = _screen == _Screen.home;

    return PopScope(
      // Atrás vuelve primero a la portada y después sale.
      canPop: isHome,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _go(_Screen.home);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(switch (_screen) {
            _Screen.ranking => _texts.ranking,
            _Screen.achievements => _texts.achievements,
            _ => 'Trivia',
          }),
          actions: [
            IconButton(
              tooltip: 'Estado sin datos / Not enough data',
              onPressed: () => _go(_Screen.notEnough),
              icon: const Icon(Icons.image_not_supported_outlined),
            ),
            TextButton(
              onPressed: () => setState(() {
                _texts = identical(_texts, TriviaTexts.es)
                    ? TriviaTexts.en
                    : TriviaTexts.es;
              }),
              child: Text(identical(_texts, TriviaTexts.es) ? 'EN' : 'ES'),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: SafeArea(child: _body()),
      ),
    );
  }

  Widget _body() => switch (_screen) {
    _Screen.home => TriviaHomeView(
      texts: _texts,
      questions: _total,
      options: 4,
      seconds: _seconds,
      bestScore: 1325,
      games: 12,
      correct: 87,
      onPlay: _start,
      onRanking: () => _go(_Screen.ranking),
      onAchievements: () => _go(_Screen.achievements),
    ),
    _Screen.question => TriviaQuestionView(
      texts: _texts,
      pokemon: _order[_index],
      options: _options,
      number: _index + 1,
      total: _total,
      score: _score,
      secondsLeft: _left,
      secondsTotal: _seconds,
      answered: _answered,
      selectedId: _selectedId,
      earnedPoints: _earned,
      onAnswer: _finish,
      onNext: _next,
    ),
    _Screen.result => TriviaResultView(
      texts: _texts,
      score: _score,
      correct: _hits,
      total: _total,
      isRecord: _score > 1325,
      newAchievementIds: const ['first_game'],
      onPlayAgain: _start,
      onHome: () => _go(_Screen.home),
    ),
    _Screen.ranking => TriviaRankingView(
      texts: _texts,
      items: [
        for (final (score, hits, day) in const [
          (1325, 9, 24),
          (1190, 8, 22),
          (960, 7, 23),
          (640, 5, 20),
        ])
          TriviaRankingItem(
            score: score,
            correct: hits,
            total: _total,
            playedAt: DateTime(2026, 11, day),
          ),
      ],
    ),
    _Screen.achievements => TriviaAchievementsView(
      texts: _texts,
      ids: _achievementIds,
      unlocked: {
        'first_game': DateTime(2026, 11, 20),
        'ten_games': DateTime(2026, 11, 23),
        'high_score': DateTime(2026, 11, 24),
      },
    ),
    _Screen.notEnough => TriviaNotEnoughView(
      texts: _texts,
      available: 6,
      needed: 20,
      onOpenCatalog: () => _go(_Screen.home),
    ),
  };
}
