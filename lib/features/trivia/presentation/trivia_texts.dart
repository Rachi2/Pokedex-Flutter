/// Diccionario de la trivia: todos los textos de sus pantallas, en español e
/// inglés. Las pantallas lo reciben ya elegido y no saben de idiomas.
class TriviaTexts {
  const TriviaTexts._(this._es);

  static const es = TriviaTexts._(true);
  static const en = TriviaTexts._(false);

  /// Español solo si el idioma es español; en cualquier otro, inglés.
  static TriviaTexts forLanguage(String languageCode) =>
      languageCode == 'es' ? es : en;

  final bool _es;

  String _t(String spanish, String english) => _es ? spanish : english;

  // Comunes
  String get title => _t('¿Quién es este Pokémon?', "Who's that Pokémon?");
  String get ranking => _t('Ranking', 'Ranking');
  String get achievements => _t('Logros', 'Achievements');
  String points(int value) => _t(
    value == 1 ? '1 punto' : '$value puntos',
    value == 1 ? '1 point' : '$value points',
  );
  String hits(int correct, int total) =>
      _t('$correct de $total aciertos', '$correct of $total correct');

  // Inicio
  String rules(int questions, int options, int seconds) => _t(
    '$questions preguntas, $options opciones y $seconds segundos por '
        'pregunta. Mientras más rápido aciertes, más puntos ganas.',
    '$questions questions, $options options and $seconds seconds per '
        'question. The faster you answer, the more points you get.',
  );
  String get play => _t('Jugar', 'Play');
  String get best => _t('Mejor puntaje', 'Best score');
  String get games => _t('Partidas', 'Games');
  String get totalHits => _t('Aciertos', 'Correct');
  String get offlineReady => _t('Funciona sin conexión', 'Works offline');

  // Sin datos suficientes
  String get notEnoughTitle =>
      _t('Aún no se puede jugar', "You can't play yet");
  String notEnoughBody(int available, int needed) => _t(
    'La trivia necesita $needed Pokémon con su imagen guardada y tienes '
        '$available. Conéctate a Internet y recorre el catálogo para '
        'guardar más.',
    'Trivia needs $needed Pokémon with their image saved and you have '
        '$available. Connect to the Internet and browse the catalog to '
        'save more.',
  );
  String get openCatalog => _t('Ir al catálogo', 'Go to catalog');

  // Partida
  String question(int number, int total) =>
      _t('Pregunta $number de $total', 'Question $number of $total');
  String secondsLeft(int seconds) => _t(
    seconds == 1 ? 'Queda 1 segundo' : 'Quedan $seconds segundos',
    seconds == 1 ? '1 second left' : '$seconds seconds left',
  );
  String get hiddenImage =>
      _t('Silueta de un Pokémon', 'Silhouette of a Pokémon');
  String imageOf(String name) => _t('Imagen de $name', 'Image of $name');
  String correct(int points) =>
      _t('¡Correcto! +$points puntos', 'Correct! +$points points');
  String wrong(String name) => _t('No. Es $name', "No. It's $name");
  String timeUp(String name) =>
      _t('Se acabó el tiempo. Es $name', "Time's up. It's $name");
  String get next => _t('Siguiente', 'Next');
  String get seeResult => _t('Ver resultado', 'See result');
  String get correctOption => _t('respuesta correcta', 'correct answer');
  String get wrongOption =>
      _t('tu respuesta, incorrecta', 'your answer, wrong');

  // Resultado
  String get gameOver => _t('Partida terminada', 'Game over');
  String get newRecord => _t('¡Nuevo récord!', 'New record!');
  String get newAchievements =>
      _t('Logros desbloqueados', 'Achievements unlocked');
  String get playAgain => _t('Jugar otra vez', 'Play again');
  String get backHome => _t('Volver al inicio', 'Back to start');

  // Ranking
  String get emptyRankingTitle => _t('Todavía no hay partidas', 'No games yet');
  String get emptyRankingBody => _t(
    'Termina una partida y tu puntaje aparecerá aquí.',
    'Finish a game and your score will appear here.',
  );
  String position(int place) => _t('Puesto $place', 'Place $place');
  String date(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return _t('$day/$month/${value.year}', '$month/$day/${value.year}');
  }

  // Logros
  String get unlocked => _t('Desbloqueado', 'Unlocked');
  String get locked => _t('Bloqueado', 'Locked');
  String unlockedOn(DateTime value) =>
      _t('Desbloqueado el ${date(value)}', 'Unlocked on ${date(value)}');
  String unlockedCount(int count, int total) =>
      _t('$count de $total desbloqueados', '$count of $total unlocked');

  /// Nombre de un logro por el id que se guarda en la base.
  String achievementName(String id) => switch (id) {
    'first_game' => _t('Primer encuentro', 'First encounter'),
    'ten_games' => _t('Visitante frecuente', 'Regular visitor'),
    'fifty_correct' => _t('Buen ojo', 'Sharp eye'),
    'high_score' => _t('Reflejos de campeón', 'Champion reflexes'),
    'perfect_game' => _t('Partida perfecta', 'Perfect game'),
    _ => id,
  };

  String achievementGoal(String id) => switch (id) {
    'first_game' => _t('Termina 1 partida', 'Finish 1 game'),
    'ten_games' => _t('Termina 10 partidas', 'Finish 10 games'),
    'fifty_correct' => _t('Acierta 50 en total', 'Get 50 correct in total'),
    'high_score' => _t(
      'Consigue 1200 puntos en una partida',
      'Score 1200 points in one game',
    ),
    'perfect_game' => _t(
      'Acierta todas en una partida',
      'Get every question right in one game',
    ),
    _ => '',
  };
}
