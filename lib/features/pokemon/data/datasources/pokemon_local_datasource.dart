import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';

/// Casilla de tipo: un tipo guardado junto con su slot (1 = principal,
/// 2 = secundario).
class SlottedType {
  const SlottedType({required this.type, required this.slot});

  final TypeRow type;
  final int slot;
}

/// Paquete de filas: un Pokemon con sus tipos, tal como esta en Drift.
///
/// El mapper lo convierte en la entidad Pokemon (y un PokemonDto en esto).
class PokemonWithTypes {
  const PokemonWithTypes({required this.pokemon, required this.types});

  final PokemonRow pokemon;

  /// Ordenados por slot.
  final List<SlottedType> types;
}

/// Guardian del catalogo en Drift: unico lugar que lo lee y lo escribe.
class PokemonLocalDataSource {
  PokemonLocalDataSource(this._db);

  final AppDatabase _db;

  /// Flujo del catalogo: emite lo guardado, ordenado por numero de Pokedex,
  /// cada vez que cambia alguna de las tablas del catalogo.
  Stream<List<PokemonWithTypes>> watchCatalog() {
    // Solo formas normales: las megas y gigamax que guarda el detalle no
    // se muestran en la lista.
    final query = _withTypes()..where(_db.pokemonTable.isDefault.equals(true));
    return query.watch().map(_group);
  }

  /// Flujo individual: emite un Pokemon, o null si no esta guardado.
  Stream<PokemonWithTypes?> watchById(int id) {
    final query = _withTypes()..where(_db.pokemonTable.id.equals(id));
    return query.watch().map((rows) {
      final grouped = _group(rows);
      return grouped.isEmpty ? null : grouped.first;
    });
  }

  /// Upsert por pagina: guarda una pagina completa en una transaccion. Si el
  /// Pokemon ya existe lo actualiza y si no lo crea, sin duplicarlo nunca.
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

  /// Conteo: cuantos Pokemon hay guardados.
  Future<int> count() => _db.pokemonTable.count().getSingle();

  /// Consulta unida: Pokemon + sus tipos en una sola consulta.
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

  /// Reagrupa: el join repite el Pokemon una vez por cada tipo; esto los junta.
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

  /// Mostrador de favoritos: los Pokémon marcados con sus tipos, del último
  /// que se marcó al primero. Incluye formas no principales (megas).
  Stream<List<PokemonWithTypes>> watchFavorites() {
    final pokemon = _db.pokemonTable;
    final link = _db.pokemonTypesTable;
    final favorites = _db.favoritesTable;

    final query = _withTypes()
      ..join([innerJoin(favorites, favorites.pokemonId.equalsExp(pokemon.id))])
      ..orderBy([
        OrderingTerm.desc(favorites.createdAt),
        OrderingTerm.desc(pokemon.id),
        OrderingTerm.asc(link.slot),
      ]);

    return query.watch().map(_group);
  }
}
