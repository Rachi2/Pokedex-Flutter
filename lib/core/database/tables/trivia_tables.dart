import 'package:drift/drift.dart';

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

@DataClassName('AchievementRow')
class AchievementsTable extends Table {
  @override
  String get tableName => 'achievements';

  TextColumn get id => text()();
  DateTimeColumn get unlockedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
