import 'package:drift/drift.dart';
import 'package:pokedex/core/database/tables/pokemon_table.dart';

@DataClassName('EggGroupRow')
class EggGroupsTable extends Table {
  @override
  String get tableName => 'egg_groups';

  IntColumn get id => integer()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokemonEggGroupRow')
class PokemonEggGroupsTable extends Table {
  @override
  String get tableName => 'pokemon_egg_groups';

  IntColumn get pokemonId =>
      integer().references(PokemonTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get eggGroupId =>
      integer().references(EggGroupsTable, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {pokemonId, eggGroupId};
}
