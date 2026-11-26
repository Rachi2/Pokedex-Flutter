import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';

/// Ficha del jugador: los cuatro totales de todas las partidas guardadas,
/// juntos en un solo valor. Con ellos se arma la portada y se deciden los
/// logros.
class TriviaTotals {
  const TriviaTotals(this.games, this.corrects, this.bestScore, this.perfect);
  final int games;
  final int corrects;
  final int bestScore;
  final int perfect;
}

/// Cuaderno de partidas: lee los Pokémon que puede usar la trivia y guarda
/// las partidas, sus respuestas y los logros. Todo es local: funciona sin
/// conexión.
class TriviaLocalDataSource {
  TriviaLocalDataSource(this._db);
  final AppDatabase _db;

  /// Pase de silueta: la condición para preguntar por un Pokémon. Tiene que
  /// ser una forma normal (no mega ni gigamax) y tener artwork. Va aparte
  /// para que la lista y el contador usen la misma regla.
  Expression<bool> _playable($PokemonTableTable p) =>
      p.isDefault.equals(true) & p.artworkUrl.isNotNull();

  /// Baraja: los Pokémon que sirven para preguntar, en orden al azar. Es una
  /// lectura única (get), así la partida no cambia si el catálogo se
  /// actualiza mientras se juega.
  Future<List<PokemonRow>> shuffledCandidates() {
    final query = _db.select(_db.pokemonTable)
      ..where((p) => _playable(p))
      ..orderBy([(_) => OrderingTerm.random()]);
    return query.get();
  }

  /// Aforo de la trivia: cuántos Pokémon cumplen el pase de silueta, en vivo.
  /// Sube solo mientras se descarga el catálogo.
  Stream<int> watchCandidateCount() {
    final pokemon = _db.pokemonTable;
    final total = pokemon.id.count();
    final query = _db.selectOnly(pokemon)
      ..addColumns([total])
      ..where(_playable(pokemon));
    return query.map((row) => row.read(total)!).watchSingle();
  }

  /// Acta de partida: guarda el resultado y sus respuestas en una transacción
  /// (todo o nada) y devuelve el id que SQLite le dio a la partida.
  Future<int> saveResult(
    TriviaResultsTableCompanion result,
    List<({int pokemonId, bool correct})> answers,
  ) {
    return _db.transaction(() async {
      final resultId = await _db.into(_db.triviaResultsTable).insert(result);

      for (var i = 0; i < answers.length; i++) {
        await _db
            .into(_db.triviaAnswersTable)
            .insert(
              TriviaAnswersTableCompanion.insert(
                resultId: resultId,
                questionNumber: i + 1,
                pokemonId: answers[i].pokemonId,
                correct: answers[i].correct,
              ),
            );
      }

      return resultId;
    });
  }

  /// Tabla de honor: las mejores partidas, en vivo. Empate: más aciertos; si
  /// siguen iguales, la que se jugó primero, y por último el id, porque la
  /// fecha se guarda en segundos.
  Stream<List<TriviaResultRow>> watchRanking({int limit = 10}) {
    final query = _db.select(_db.triviaResultsTable)
      ..orderBy([
        (r) => OrderingTerm.desc(r.score),
        (r) => OrderingTerm.desc(r.correctAnswers),
        (r) => OrderingTerm.asc(r.playedAt),
        (r) => OrderingTerm.asc(r.id),
      ])
      ..limit(limit);
    return query.watch();
  }

  /// Balance de partidas: cuenta partidas, suma aciertos, busca el mejor
  /// puntaje y cuenta las perfectas, en una sola consulta. Sin partidas, sum
  /// y max devuelven null; por eso llevan ?? 0.
  Future<TriviaTotals> totals() async {
    final r = _db.triviaResultsTable;
    final games = r.id.count();
    final corrects = r.correctAnswers.sum();
    final bestScore = r.score.max();
    final perfect = r.id.count(
      filter: r.correctAnswers.equalsExp(r.totalQuestions),
    );

    final row = await (_db.selectOnly(
      r,
    )..addColumns([games, corrects, bestScore, perfect])).getSingle();

    return TriviaTotals(
      row.read(games)!,
      row.read(corrects) ?? 0,
      row.read(bestScore) ?? 0,
      row.read(perfect)!,
    );
  }

  /// Medallero: los logros ganados con su fecha, en vivo.
  Stream<List<AchievementRow>> watchAchievements() {
    return _db.select(_db.achievementsTable).watch();
  }

  /// Sello de logros: guarda los logros de [ids] que faltan y devuelve solo
  /// los nuevos. insertOrIgnore no toca los que ya existían, así conservan
  /// la fecha en que se ganaron.
  Future<Set<String>> unlock(Set<String> ids) {
    return _db.transaction(() async {
      final created = <String>{};
      for (final id in ids) {
        final row = await _db
            .into(_db.achievementsTable)
            .insertReturningOrNull(
              AchievementsTableCompanion.insert(id: id),
              mode: InsertMode.insertOrIgnore,
            );
        if (row != null) created.add(id);
      }
      return created;
    });
  }
}
