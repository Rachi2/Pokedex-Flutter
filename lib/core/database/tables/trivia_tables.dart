import 'package:drift/drift.dart';

/// Tabla trivia_results: una fila por partida con puntaje y aciertos; el
/// indice de score arma el podio de mejores partidas.
@DataClassName('TriviaResultRow')
@TableIndex(name: 'trivia_results_score_idx', columns: {#score})
class TriviaResultsTable extends Table {
  @override
  String get tableName => 'trivia_results';

  IntColumn get id => integer().autoIncrement()();
  // ignore: recursive_getters
  IntColumn get score => integer().check(score.isBiggerOrEqualValue(0))();
  IntColumn get correctAnswers => integer()();
  IntColumn get totalQuestions => integer()();
  DateTimeColumn get playedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'CHECK (correct_answers BETWEEN 0 AND total_questions)',
  ];
}

/// Tabla trivia_answers: el desglose de cada partida, pregunta por
/// pregunta. Sin clave foranea a pokemon: son datos del usuario.
@DataClassName('TriviaAnswerRow')
class TriviaAnswersTable extends Table {
  @override
  String get tableName => 'trivia_answers';

  IntColumn get resultId => integer().references(
    TriviaResultsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get questionNumber => integer()();
  IntColumn get pokemonId => integer()();
  BoolColumn get correct => boolean()();

  @override
  Set<Column> get primaryKey => {resultId, questionNumber};
}

/// Tabla achievements: las medallas que gano el usuario y cuando. Cuales
/// existen y sus umbrales se definen en el codigo.
@DataClassName('AchievementRow')
class AchievementsTable extends Table {
  @override
  String get tableName => 'achievements';

  TextColumn get id => text()();
  DateTimeColumn get unlockedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
