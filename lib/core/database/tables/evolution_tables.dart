import 'package:drift/drift.dart';

@DataClassName('EvolutionSpeciesRow')
@TableIndex(name: 'evolution_species_chain_idx', columns: {#chainId})
class EvolutionSpeciesTable extends Table {
  @override
  String get tableName => 'evolution_species';

  IntColumn get speciesId => integer()();
  IntColumn get chainId => integer()();
  IntColumn get evolvesFromId => integer().nullable()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {speciesId};
}

@DataClassName('EvolutionMethodRow')
class EvolutionMethodsTable extends Table {
  @override
  String get tableName => 'evolution_methods';

  IntColumn get id => integer()();
  IntColumn get speciesId => integer().references(
    EvolutionSpeciesTable,
    #speciesId,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get trigger => text()();
  IntColumn get minLevel => integer().nullable()();
  TextColumn get item => text().nullable()();
  TextColumn get heldItem => text().nullable()();
  IntColumn get minHappiness => integer().nullable()();
  TextColumn get timeOfDay => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
