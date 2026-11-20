import 'package:drift/drift.dart';

/// Tabla evolution_species: la genealogia de cada cadena evolutiva.
/// evolvesFromId apunta a la especie anterior y asi se forman las ramas.
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

/// Tabla evolution_methods: el detonante de cada evolucion (nivel, objeto,
/// intercambio, amistad, hora...); una especie puede tener varios.
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
