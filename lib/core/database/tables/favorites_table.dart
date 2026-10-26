import 'package:drift/drift.dart';

@DataClassName('FavoriteRow')
class FavoritesTable extends Table {
  @override
  String get tableName => 'favorites';

  IntColumn get pokemonId => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {pokemonId};
}
