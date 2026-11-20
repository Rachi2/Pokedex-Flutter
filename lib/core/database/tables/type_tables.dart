import 'package:drift/drift.dart';
import 'package:pokedex/core/database/tables/pokemon_table.dart';

/// Tabla types: los tipos elementales (planta, fuego...) con su id.
@DataClassName('TypeRow')
class TypesTable extends Table {
  @override
  String get tableName => 'types';

  IntColumn get id => integer()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla pokemon_types: el puente entre cada Pokémon y sus tipos, con el
/// slot (1 principal, 2 secundario).
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

@DataClassName('TypeEfficacyRow')
class TypeEfficaciesTable extends Table {
  @override
  String get tableName => 'type_efficacies';

  @ReferenceName('defendingEfficacies')
  IntColumn get defendingTypeId =>
      integer().references(TypesTable, #id, onDelete: KeyAction.cascade)();

  @ReferenceName('attackingEfficacies')
  IntColumn get attackingTypeId =>
      integer().references(TypesTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get damageFactor =>
      // ignore: recursive_getters
      integer().check(damageFactor.isIn([0, 50, 100, 200]))();

  @override
  Set<Column> get primaryKey => {defendingTypeId, attackingTypeId};
}
