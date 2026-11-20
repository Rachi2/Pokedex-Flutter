import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:pokedex/features/pokemon/domain/entities/catalog_sync_status.dart';

import 'tables/favorites_table.dart';
import 'tables/pokemon_table.dart';
import 'tables/sync_metadata_table.dart';
import 'tables/type_tables.dart';
import 'tables/stat_tables.dart';

import 'sync_metadata_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    SyncMetadataTable,
    FavoritesTable,
    PokemonTable,
    TypesTable,
    PokemonTypesTable,
    StatsTable,
    PokemonStatsTable,
  ],
  daos: [SyncMetadataDao],
)
/// Almacen local de la app: registra las cinco tablas y el DAO, y activa
/// las claves foraneas al abrir.
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(statsTable);
        await m.createTable(pokemonStatsTable);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

/// Abre pokedex.sqlite en un isolate aparte, para que leer y escribir no
/// frene la interfaz.
QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'pokedex.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
