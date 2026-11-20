import 'package:drift/drift.dart';

/// Tabla pokemon: la ficha de cada Pokémon (id, numero, nombre e imagenes).
/// Los indices aceleran las busquedas por nombre y por numero.
@DataClassName('PokemonRow')
@TableIndex(name: 'pokemon_name_idx', columns: {#name})
@TableIndex(name: 'pokemon_dex_number_idx', columns: {#dexNumber})
@TableIndex(name: 'pokemon_gen_idx', columns: {#generationId})
class PokemonTable extends Table {
  @override
  String get tableName => 'pokemon';

  IntColumn get id => integer()();
  IntColumn get dexNumber => integer()();
  TextColumn get name => text()();
  TextColumn get spriteUrl => text().nullable()();
  TextColumn get artworkUrl => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get height => integer().nullable()();
  IntColumn get weight => integer().nullable()();
  IntColumn get generationId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
