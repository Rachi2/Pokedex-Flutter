import 'package:drift/drift.dart';

import 'package:pokedex/core/database/app_database.dart';

import 'pokemon_local_datasource.dart';

/// Par de atributo: el atributo del catalogo (hp, attack...) junto con la
/// fila puente que guarda su valor base y su esfuerzo para este Pokemon.
class StatEntry {
  const StatEntry({required this.stat, required this.link});

  final StatRow stat;
  final PokemonStatRow link;
}

/// Par de habilidad: la habilidad del catalogo junto con la fila puente que
/// dice en que slot la tiene este Pokemon y si es oculta.
class AbilityEntry {
  const AbilityEntry({required this.ability, required this.link});

  final AbilityRow ability;
  final PokemonAbilityRow link;
}

/// Par de movimiento: el movimiento del catalogo junto con la fila puente
/// que dice por que metodo y a que nivel lo aprende este Pokemon.
class MoveEntry {
  const MoveEntry({required this.move, required this.link});

  final MoveRow move;
  final PokemonMoveRow link;
}

/// Legajo en filas: todo el detalle de un Pokemon tal como esta en Drift.
///
/// El mapper lo arma desde el DTO para guardarlo y lo convierte en la
/// entidad PokemonDetail al leerlo.
class PokemonDetailRows {
  const PokemonDetailRows({
    required this.main,
    required this.stats,
    required this.abilities,
    required this.moves,
    required this.eggGroups,
    required this.forms,
    required this.chainSpecies,
    required this.chainMethods,
  });

  /// El Pokemon con sus tipos, igual que en el catalogo.
  final PokemonWithTypes main;
  final List<StatEntry> stats;
  final List<AbilityEntry> abilities;
  final List<MoveEntry> moves;
  final List<EggGroupRow> eggGroups;

  /// Las formas son filas de pokemon con el mismo dexNumber.
  final List<PokemonRow> forms;
  final List<EvolutionSpeciesRow> chainSpecies;
  final List<EvolutionMethodRow> chainMethods;
}

/// Cuadro de afinidades en filas: los tipos y su tabla de efectividad.
class TypeChartRows {
  const TypeChartRows({required this.types, required this.efficacies});

  final List<TypeRow> types;
  final List<TypeEfficacyRow> efficacies;
}

/// Archivista del detalle: unico lugar que lee y escribe en Drift el
/// detalle de un Pokemon y la tabla de efectividad.
class PokemonDetailLocalDataSource {
  PokemonDetailLocalDataSource(this._db, this._catalog);

  final AppDatabase _db;

  /// Se reutiliza para guardar y leer el Pokemon con sus tipos.
  final PokemonLocalDataSource _catalog;

  /// Guardado del legajo: escribe todo el detalle en una transaccion. Si algo
  /// falla, no se guarda nada y queda lo que habia antes.
  Future<void> saveDetail(PokemonDetailRows rows) async {
    await _db.transaction(() async {
      final pokemonId = rows.main.pokemon.id;

      await _catalog.upsertPage([rows.main]);

      // toCompanion(true) omite los campos null: una forma sin imagenes no
      // borra las que ya estaban guardadas.
      for (final form in rows.forms) {
        await _db
            .into(_db.pokemonTable)
            .insertOnConflictUpdate(form.toCompanion(true));
      }

      // Se borran las puentes viejas para que no quede nada que PokeAPI ya
      // no trae.
      await (_db.delete(
        _db.pokemonStatsTable,
      )..where((t) => t.pokemonId.equals(pokemonId))).go();
      await (_db.delete(
        _db.pokemonAbilitiesTable,
      )..where((t) => t.pokemonId.equals(pokemonId))).go();
      await (_db.delete(
        _db.pokemonMovesTable,
      )..where((t) => t.pokemonId.equals(pokemonId))).go();
      await (_db.delete(
        _db.pokemonEggGroupsTable,
      )..where((t) => t.pokemonId.equals(pokemonId))).go();

      // Primero el catalogo y despues la puente, por las claves foraneas.
      for (final entry in rows.stats) {
        await _db.into(_db.statsTable).insertOnConflictUpdate(entry.stat);
        await _db.into(_db.pokemonStatsTable).insert(entry.link);
      }

      for (final entry in rows.abilities) {
        await _db
            .into(_db.abilitiesTable)
            .insertOnConflictUpdate(entry.ability);
        await _db.into(_db.pokemonAbilitiesTable).insert(entry.link);
      }

      for (final entry in rows.moves) {
        await _db.into(_db.movesTable).insertOnConflictUpdate(entry.move);
        await _db.into(_db.pokemonMovesTable).insert(entry.link);
      }

      for (final eggGroup in rows.eggGroups) {
        await _db.into(_db.eggGroupsTable).insertOnConflictUpdate(eggGroup);
        await _db
            .into(_db.pokemonEggGroupsTable)
            .insert(
              PokemonEggGroupsTableCompanion.insert(
                pokemonId: pokemonId,
                eggGroupId: eggGroup.id,
              ),
            );
      }

      // Se borra la cadena guardada y se vuelve a escribir; el cascade borra
      // los metodos de las especies borradas.
      if (rows.chainSpecies.isNotEmpty) {
        final chainId = rows.chainSpecies.first.chainId;

        await (_db.delete(
          _db.evolutionSpeciesTable,
        )..where((t) => t.chainId.equals(chainId))).go();

        // Las especies antes que los metodos, por la clave foranea.
        for (final species in rows.chainSpecies) {
          await _db.into(_db.evolutionSpeciesTable).insert(species);
        }

        for (final method in rows.chainMethods) {
          await _db.into(_db.evolutionMethodsTable).insert(method);
        }
      }
    });
  }

  /// Lectura del legajo: arma el detalle guardado, o null si el Pokemon
  /// no esta en la base.
  Future<PokemonDetailRows?> _load(int id) async {
    final main = await _catalog.watchById(id).first;
    if (main == null) return null;

    final statQuery =
        _db.select(_db.pokemonStatsTable).join([
            innerJoin(
              _db.statsTable,
              _db.statsTable.id.equalsExp(_db.pokemonStatsTable.statId),
            ),
          ])
          ..where(_db.pokemonStatsTable.pokemonId.equals(id))
          ..orderBy([OrderingTerm.asc(_db.statsTable.id)]);

    final stats = (await statQuery.get()).map((row) {
      return StatEntry(
        stat: row.readTable(_db.statsTable),
        link: row.readTable(_db.pokemonStatsTable),
      );
    }).toList();

    final abilityQuery =
        _db.select(_db.pokemonAbilitiesTable).join([
            innerJoin(
              _db.abilitiesTable,
              _db.abilitiesTable.id.equalsExp(
                _db.pokemonAbilitiesTable.abilityId,
              ),
            ),
          ])
          ..where(_db.pokemonAbilitiesTable.pokemonId.equals(id))
          ..orderBy([OrderingTerm.asc(_db.pokemonAbilitiesTable.slot)]);

    final abilities = (await abilityQuery.get()).map((row) {
      return AbilityEntry(
        ability: row.readTable(_db.abilitiesTable),
        link: row.readTable(_db.pokemonAbilitiesTable),
      );
    }).toList();

    final moveQuery = _db.select(_db.pokemonMovesTable).join([
      innerJoin(
        _db.movesTable,
        _db.movesTable.id.equalsExp(_db.pokemonMovesTable.moveId),
      ),
    ])..where(_db.pokemonMovesTable.pokemonId.equals(id));

    final moves = (await moveQuery.get()).map((row) {
      return MoveEntry(
        move: row.readTable(_db.movesTable),
        link: row.readTable(_db.pokemonMovesTable),
      );
    }).toList();

    final eggGroupQuery = _db.select(_db.pokemonEggGroupsTable).join([
      innerJoin(
        _db.eggGroupsTable,
        _db.eggGroupsTable.id.equalsExp(_db.pokemonEggGroupsTable.eggGroupId),
      ),
    ])..where(_db.pokemonEggGroupsTable.pokemonId.equals(id));

    final eggGroups = (await eggGroupQuery.get())
        .map((row) => row.readTable(_db.eggGroupsTable))
        .toList();

    // Ordenadas por id para que la forma normal salga primero.
    final dexNumber = main.pokemon.dexNumber;
    final forms =
        await (_db.select(_db.pokemonTable)
              ..where((t) => t.dexNumber.equals(dexNumber))
              ..orderBy([(t) => OrderingTerm.asc(t.id)]))
            .get();

    // Se busca por dexNumber (el id de la especie) para que una mega o una
    // gigamax tambien encuentre su cadena.
    final currentSpecies = await (_db.select(
      _db.evolutionSpeciesTable,
    )..where((t) => t.speciesId.equals(dexNumber))).getSingleOrNull();

    var chainSpecies = <EvolutionSpeciesRow>[];
    var chainMethods = <EvolutionMethodRow>[];

    if (currentSpecies != null) {
      chainSpecies = await (_db.select(
        _db.evolutionSpeciesTable,
      )..where((t) => t.chainId.equals(currentSpecies.chainId))).get();

      final speciesIds = chainSpecies.map((s) => s.speciesId).toList();
      if (speciesIds.isNotEmpty) {
        chainMethods = await (_db.select(
          _db.evolutionMethodsTable,
        )..where((t) => t.speciesId.isIn(speciesIds))).get();
      }
    }

    return PokemonDetailRows(
      main: main,
      stats: stats,
      abilities: abilities,
      moves: moves,
      eggGroups: eggGroups,
      forms: forms,
      chainSpecies: chainSpecies,
      chainMethods: chainMethods,
    );
  }

  /// Atalaya del detalle: emite el detalle guardado (o null) y lo vuelve a
  /// leer cada vez que cambia alguna de sus tablas.
  Stream<PokemonDetailRows?> watchDetail(int id) async* {
    yield await _load(id);

    // Una transaccion avisa una sola vez al terminar, asi que cada guardado
    // produce una sola emision.
    yield* _db
        .tableUpdates(
          TableUpdateQuery.onAllTables([
            _db.pokemonTable,
            _db.pokemonTypesTable,
            _db.typesTable,
            _db.pokemonStatsTable,
            _db.statsTable,
            _db.pokemonAbilitiesTable,
            _db.abilitiesTable,
            _db.pokemonMovesTable,
            _db.movesTable,
            _db.pokemonEggGroupsTable,
            _db.eggGroupsTable,
            _db.evolutionSpeciesTable,
            _db.evolutionMethodsTable,
          ]),
        )
        .asyncMap((_) => _load(id));
  }

  /// Registro de afinidades: guarda los tipos y la tabla de efectividad en
  /// una transaccion. Los tipos van primero por las claves foraneas.
  Future<void> saveTypeChart(TypeChartRows chart) async {
    await _db.transaction(() async {
      for (final type in chart.types) {
        await _db.into(_db.typesTable).insertOnConflictUpdate(type);
      }
      for (final efficacy in chart.efficacies) {
        await _db
            .into(_db.typeEfficaciesTable)
            .insertOnConflictUpdate(efficacy);
      }
    });
  }

  /// Atalaya de afinidades: emite la tabla de efectividad guardada, o null
  /// si todavia no se ha descargado.
  Stream<TypeChartRows?> watchTypeChart() {
    return _db.select(_db.typeEfficaciesTable).watch().asyncMap((
      efficacies,
    ) async {
      if (efficacies.isEmpty) return null;

      final types = await _db.select(_db.typesTable).get();
      return TypeChartRows(types: types, efficacies: efficacies);
    });
  }
}
