import 'package:drift/drift.dart';

/// Tabla pokemon: la ficha de cada Pokémon (id, numero, nombre, imagenes,
/// altura, peso y generacion). isDefault separa la forma normal de las megas
/// y gigamax. Los indices aceleran las busquedas por nombre, numero y
/// generacion.
@DataClassName('PokemonRow')
@TableIndex(name: 'pokemon_name_idx', columns: {#name})
@TableIndex(name: 'pokemon_dex_number_idx', columns: {#dexNumber})
@TableIndex(name: 'pokemon_gen_idx', columns: {#generationId})
@TableIndex(name: 'pokemon_bst_idx', columns: {#baseStatTotal})
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
  BoolColumn get isDefault => boolean().withDefault(const Constant(true))();
  IntColumn get baseStatTotal => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
