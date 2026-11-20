import 'package:drift/drift.dart';
import 'package:pokedex/core/database/tables/pokemon_table.dart';

@DataClassName('AbilityRow')
class AbilitiesTable extends Table {
  @override
  String get tableName => 'abilities';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get nameEs => text().nullable()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get effectEs => text().nullable()();
  TextColumn get effectEn => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PokemonAbilityRow')
class PokemonAbilitiesTable extends Table {
  @override
  String get tableName => 'pokemon_abilities';

  IntColumn get pokemonId =>
      integer().references(PokemonTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get abilityId =>
      integer().references(AbilitiesTable, #id, onDelete: KeyAction.cascade)();
  // ignore: recursive_getters
  IntColumn get slot => integer().check(slot.isBetweenValues(1, 3))();
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {pokemonId, slot};

  @override
  List<Set<Column>> get uniqueKeys => [
    {pokemonId, abilityId},
  ];
}
