import 'package:drift/drift.dart';

@DataClassName('PokemonRow')
@TableIndex(name: 'pokemon_name_idx', columns: {#name})
@TableIndex(name: 'pokemon_dex_number_idx', columns: {#dexNumber})
class PokemonTable extends Table {
  @override
  String get tableName => 'pokemon';

  IntColumn get id => integer()();
  IntColumn get dexNumber => integer()();
  TextColumn get name => text()();
  TextColumn get spriteUrl => text().nullable()();
  TextColumn get artworkUrl => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
