import 'package:drift/drift.dart';
import 'package:pokedex/core/database/tables/pokemon_table.dart';

/// Tabla stats: los seis atributos de combate (ps, ataque, defensa,
/// ataque especial, defensa especial y velocidad).
@DataClassName('StatRow')
class StatsTable extends Table {
  @override
  String get tableName => 'stats';

  IntColumn get id => integer()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla pokemon_stats: el valor base de cada Pokémon en cada estadistica
/// (1 a 255) y los puntos de esfuerzo que da al vencerlo (0 a 3).
@DataClassName('PokemonStatRow')
class PokemonStatsTable extends Table {
  @override
  String get tableName => 'pokemon_stats';

  IntColumn get pokemonId =>
      integer().references(PokemonTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get statId =>
      integer().references(StatsTable, #id, onDelete: KeyAction.cascade)();
  // ignore: recursive_getters
  IntColumn get baseStat => integer().check(baseStat.isBetweenValues(1, 255))();
  // ignore: recursive_getters
  IntColumn get effort => integer().check(effort.isBetweenValues(0, 3))();

  @override
  Set<Column> get primaryKey => {pokemonId, statId};
}
