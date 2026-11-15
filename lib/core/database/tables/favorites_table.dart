import 'package:drift/drift.dart';

/// Tabla favorites: los Pokémon predilectos del usuario, con la fecha.
/// Sin clave foranea, para que la sincronizacion nunca los borre.
@DataClassName('FavoriteRow')
class FavoritesTable extends Table {
  @override
  String get tableName => 'favorites';

  IntColumn get pokemonId => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {pokemonId};
}
