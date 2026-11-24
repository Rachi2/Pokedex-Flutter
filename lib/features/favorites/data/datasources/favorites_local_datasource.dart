import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';

/// Libreta de favoritos: lee y escribe la tabla favorites.
class FavoritesLocalDataSource {
  FavoritesLocalDataSource(this._db);
  final AppDatabase _db;

  /// Coleccion viva: emite los IDs de todos los favoritos cada vez que cambian.
  Stream<Set<int>> watchIds() {
    return _db
        .select(_db.favoritesTable)
        .watch()
        .map((rows) => rows.map((row) => row.pokemonId).toSet());
  }

  /// Interruptor: agrega o quita un favorito; devuelve true si quedó marcado.
  Future<bool> toggle(int pokemonId) {
    return _db.transaction(() async {
      final deletedRows = await (_db.delete(
        _db.favoritesTable,
      )..where((t) => t.pokemonId.equals(pokemonId))).go();

      if (deletedRows > 0) {
        return false;
      }

      await _db
          .into(_db.favoritesTable)
          .insert(FavoritesTableCompanion.insert(pokemonId: Value(pokemonId)));

      return true;
    });
  }
}
