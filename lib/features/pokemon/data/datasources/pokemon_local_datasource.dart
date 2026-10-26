import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';

/// Un tipo de un Pokemon junto con su posicion (1 = principal, 2 = secundario).
class SlottedType {
  const SlottedType({required this.type, required this.slot});

  final TypeRow type;
  final int slot;
}

/// Un Pokemon con sus tipos, tal como esta guardado en Drift.
///
/// El mapper lo convierte en la entidad Pokemon (y un PokemonDto en esto).
class PokemonWithTypes {
  const PokemonWithTypes({required this.pokemon, required this.types});

  final PokemonRow pokemon;

  /// Ordenados por slot.
  final List<SlottedType> types;
}

/// Unico lugar de la app que lee y escribe el catalogo en Drift.
class PokemonLocalDataSource {
  PokemonLocalDataSource(this._db);

  final AppDatabase _db;

  /// Emite el catalogo guardado, ordenado por numero de Pokedex,
  /// cada vez que cambia alguna de las tablas del catalogo.
  Stream<List<PokemonWithTypes>> watchCatalog() {
    return _withTypes().watch().map(_group);
  }

  /// Emite un Pokemon, o null si no esta guardado.
  Stream<PokemonWithTypes?> watchById(int id) {
    final query = _withTypes()..where(_db.pokemonTable.id.equals(id));
    return query.watch().map((rows) {
      final grouped = _group(rows);
      return grouped.isEmpty ? null : grouped.first;
    });
  }

  /// Guarda una pagina completa en una transaccion: si el Pokemon ya existe
  /// lo actualiza y si no lo crea, sin duplicarlo nunca (PS-06, RNF-RES-04).
  Future<void> upsertPage(List<PokemonWithTypes> page) {
    return _db.transaction(() async {
      // Se borran los tipos viejos para que, si un Pokemon cambio de tipos,
      // no se quede un slot que ya no existe.
      final ids = page.map((entry) => entry.pokemon.id).toList();
      await (_db.delete(
        _db.pokemonTypesTable,
      )..where((t) => t.pokemonId.isIn(ids))).go();

      // Orden: pokemon y types antes que pokemon_types, por las claves foraneas.
      for (final entry in page) {
        await _db.into(_db.pokemonTable).insertOnConflictUpdate(entry.pokemon);

        for (final slotted in entry.types) {
          await _db.into(_db.typesTable).insertOnConflictUpdate(slotted.type);
          await _db
              .into(_db.pokemonTypesTable)
              .insert(
                PokemonTypesTableCompanion.insert(
                  pokemonId: entry.pokemon.id,
                  typeId: slotted.type.id,
                  slot: slotted.slot,
                ),
              );
        }
      }
    });
  }

  /// Cuantos Pokemon hay guardados.
  Future<int> count() => _db.pokemonTable.count().getSingle();

  /// Pokemon + sus tipos en una sola consulta.
  ///
  /// Con leftOuterJoin un Pokemon sin tipos tambien aparece.
  JoinedSelectStatement<HasResultSet, dynamic> _withTypes() {
    final pokemon = _db.pokemonTable;
    final links = _db.pokemonTypesTable;
    final types = _db.typesTable;

    return _db.select(pokemon).join([
      leftOuterJoin(links, links.pokemonId.equalsExp(pokemon.id)),
      leftOuterJoin(types, types.id.equalsExp(links.typeId)),
    ])..orderBy([
      OrderingTerm.asc(pokemon.dexNumber),
      OrderingTerm.asc(pokemon.id),
      OrderingTerm.asc(links.slot),
    ]);
  }

  /// El join repite el Pokemon una vez por cada tipo; esto los junta.
  List<PokemonWithTypes> _group(List<TypedResult> rows) {
    final byId = <int, PokemonWithTypes>{};

    for (final row in rows) {
      final pokemon = row.readTable(_db.pokemonTable);
      final entry = byId.putIfAbsent(
        pokemon.id,
        () => PokemonWithTypes(pokemon: pokemon, types: []),
      );

      final link = row.readTableOrNull(_db.pokemonTypesTable);
      final type = row.readTableOrNull(_db.typesTable);
      if (link != null && type != null) {
        entry.types.add(SlottedType(type: type, slot: link.slot));
      }
    }

    return byId.values.toList();
  }
}
