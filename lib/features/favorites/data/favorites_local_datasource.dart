import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';

/// Gestiona las operaciones de base de datos para los Pokémon favoritos.
class FavoritesLocalDataSource {
  FavoritesLocalDataSource(this._db);
  final AppDatabase _db;

  /// Emite en tiempo real un conjunto con los IDs de todos los favoritos.
  Stream<Set<int>> watchIds() {
    return _db
        .select(_db.favoritesTable)
        .watch()
        .map((rows) => rows.map((row) => row.pokemonId).toSet());
  }

  /// Agrega o quita un favorito. Devuelve true si quedó como favorito.
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
