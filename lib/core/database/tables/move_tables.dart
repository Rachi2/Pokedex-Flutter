import 'package:drift/drift.dart';
import 'package:pokedex/core/database/tables/pokemon_table.dart';

/// Tabla moves: el arsenal de movimientos, con tipo, potencia, precision,
/// pp y clase de dano. Sin clave foranea al tipo: puede no estar guardado.
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

/// Tabla pokemon_moves: el repertorio de cada Pokémon, por metodo y nivel.
/// El orden de la clave sirve de indice para filtrar por metodo y ordenar
/// por nivel.
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
