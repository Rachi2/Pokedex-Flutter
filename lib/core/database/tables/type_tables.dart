import 'package:drift/drift.dart';
import 'package:pokedex/core/database/tables/pokemon_table.dart';

@DataClassName('TypeRow')
class TypesTable extends Table {
  @override
  String get tableName => 'types';

  IntColumn get id => integer()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokemonTypeRow')
class PokemonTypesTable extends Table {
  @override
  String get tableName => 'pokemon_types';

  IntColumn get pokemonId =>
      integer().references(PokemonTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get typeId =>
      integer().references(TypesTable, #id, onDelete: KeyAction.cascade)();
  // Drift solo lee este getter para generar el CHECK; no se llama a sí mismo.
  // ignore: recursive_getters
  IntColumn get slot => integer().check(slot.isIn([1, 2]))();

  @override
  Set<Column> get primaryKey => {pokemonId, slot};

  @override
  List<Set<Column>> get uniqueKeys => [
    {pokemonId, typeId},
  ];
}
