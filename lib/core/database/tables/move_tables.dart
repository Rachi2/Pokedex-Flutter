import 'package:drift/drift.dart';
import 'package:pokedex/core/database/tables/pokemon_table.dart';

@DataClassName('MoveRow')
class MovesTable extends Table {
  @override
  String get tableName => 'moves';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get nameEs => text().nullable()();
  TextColumn get nameEn => text().nullable()();
  IntColumn get typeId => integer().nullable()();
  IntColumn get power => integer().nullable()();
  IntColumn get accuracy => integer().nullable()();
  IntColumn get pp => integer().nullable()();
  TextColumn get damageClass => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokemonMoveRow')
class PokemonMovesTable extends Table {
  @override
  String get tableName => 'pokemon_moves';

  IntColumn get pokemonId =>
      integer().references(PokemonTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get moveId =>
      integer().references(MovesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get method => text()();
  // ignore: recursive_getters
  IntColumn get level => integer().check(level.isBetweenValues(0, 100))();

  @override
  Set<Column> get primaryKey => {pokemonId, method, level, moveId};
}
