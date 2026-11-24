import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_filter.dart';

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

  /// Flujo del catalogo: emite lo guardado que pasa el [filter] (busqueda,
  /// tipo y generacion), en el orden que pide, cada vez que cambia alguna
  /// de las tablas del catalogo. Sin filtro: todo, por numero de Pokedex.
  Stream<List<PokemonWithTypes>> watchCatalog([
    CatalogFilter filter = const CatalogFilter(),
  ]) {
    final pokemon = _db.pokemonTable;
    final links = _db.pokemonTypesTable;

    // Solo formas normales: las megas y gigamax que guarda el detalle no
    // se muestran en la lista.
    final query = _withTypes()..where(pokemon.isDefault.equals(true));

    // Busqueda por nombre: PokeAPI guarda los nombres en minusculas, asi que
    // basta con pasar lo escrito a minusculas. '%' = cualquier texto antes o
    // despues ("char" encuentra charmander y charizard).
    final search = filter.query.trim().toLowerCase();
    if (search.isNotEmpty) {
      query.where(pokemon.name.like('%$search%'));
    }

    final generationId = filter.generationId;
    if (generationId != null) {
      query.where(pokemon.generationId.equals(generationId));
    }

    // Filtro de tipo con subconsulta: «los Pokemon cuyo id esta entre los que
    // tienen este tipo». Si se filtrara la fila unida (links.typeId), solo
    // quedaria la fila de ese tipo y Charizard perderia Volador al filtrar
    // por Fuego.
    final typeId = filter.typeId;
    if (typeId != null) {
      final withType = _db.selectOnly(links)
        ..addColumns([links.pokemonId])
        ..where(links.typeId.equals(typeId));
      query.where(pokemon.id.isInQuery(withType));
    }

    final mode = filter.descending ? OrderingMode.desc : OrderingMode.asc;
    final first = switch (filter.sort) {
      CatalogSort.number => OrderingTerm(
        expression: pokemon.dexNumber,
        mode: mode,
      ),
      CatalogSort.name => OrderingTerm(expression: pokemon.name, mode: mode),
      CatalogSort.type => OrderingTerm(
        expression: _primaryTypeId(),
        mode: mode,
      ),
      // Los que todavia no tienen total base van al final en los dos sentidos.
      CatalogSort.baseStatTotal => OrderingTerm(
        expression: pokemon.baseStatTotal,
        mode: mode,
        nulls: NullsOrder.last,
      ),
    };

    // Despues del orden elegido: desempate por numero e id, y el slot para
    // que _group reciba el tipo principal antes que el secundario.
    query.orderBy([
      first,
      OrderingTerm.asc(pokemon.dexNumber),
      OrderingTerm.asc(pokemon.id),
      OrderingTerm.asc(links.slot),
    ]);
    return query.watch().map(_group);
  }

  /// Tipo principal: subconsulta con el id del tipo en el slot 1 de cada
  /// Pokemon. Ordenar por links.typeId no sirve porque Charizard sale en dos
  /// filas (Fuego y Volador) y cada una se ordenaria por separado.
  Expression<int> _primaryTypeId() {
    final pokemon = _db.pokemonTable;
    // Alias: una segunda copia de pokemon_types con otro nombre, para no
    // confundirla con la que ya esta unida en _withTypes().
    final primary = _db.alias(_db.pokemonTypesTable, 'primary_type');
    return subqueryExpression<int>(
      _db.selectOnly(primary)
        ..addColumns([primary.typeId])
        ..where(
          primary.pokemonId.equalsExp(pokemon.id) & primary.slot.equals(1),
        ),
    );
  }

  /// Contador de guardados: cuantos Pokemon del catalogo hay en el telefono
  /// (sin megas ni gigamax), y avisa cada vez que cambia. La barra lo compara
  /// con el total de PokeAPI para el aviso de catalogo incompleto.
  Stream<int> watchSavedCount() {
    final pokemon = _db.pokemonTable;
    final total = pokemon.id.count();
    final query = _db.selectOnly(pokemon)
      ..addColumns([total])
      ..where(pokemon.isDefault.equals(true));
    return query.map((row) => row.read(total)!).watchSingle();
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
