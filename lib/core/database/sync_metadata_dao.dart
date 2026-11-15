import 'package:drift/drift.dart';

import 'app_database.dart';
import 'tables/sync_metadata_table.dart';

import 'package:pokedex/features/pokemon/domain/entities/catalog_sync_status.dart';

part 'sync_metadata_dao.g.dart';

/// Bitacora de sincronizacion: lee y escribe sync_metadata, una fila por
/// recurso con su estado, su avance y la hora de la ultima descarga.
@DriftAccessor(tables: [SyncMetadataTable])
class SyncMetadataDao extends DatabaseAccessor<AppDatabase>
    with _$SyncMetadataDaoMixin {
  SyncMetadataDao(super.attachedDatabase);

  /// Identificador de la fila del catalogo en sync_metadata.
  static const catalogKey = 'catalog';

  SimpleSelectStatement<$SyncMetadataTableTable, SyncMetadataRow> _byKey(
    String key,
  ) => select(syncMetadataTable)..where((t) => t.resourceKey.equals(key));

  /// Centinela de [key]: emite la fila cada vez que cambia.
  Stream<SyncMetadataRow?> watch(String key) {
    return _byKey(key).watchSingleOrNull();
  }

  /// Lectura puntual de la fila de [key], o null si no existe.
  Future<SyncMetadataRow?> get(String key) {
    return _byKey(key).getSingleOrNull();
  }

  /// Banderazo de salida: marca que empezo una descarga (syncing).
  Future<void> markSyncing(String key) async {
    await into(syncMetadataTable).insertOnConflictUpdate(
      SyncMetadataTableCompanion(
        resourceKey: Value(key),
        status: const Value(SyncState.syncing),
      ),
    );
  }

  /// Marcador de progreso: guarda el siguiente offset, el total y la hora.
  /// Con [keepSyncing] el estado sigue en syncing, para evitar el parpadeo
  /// del indicador entre paginas.
  Future<void> markSuccess(
    String key, {
    required int nextOffset,
    int? totalRemote,
    bool keepSyncing = false,
  }) async {
    await into(syncMetadataTable).insertOnConflictUpdate(
      SyncMetadataTableCompanion(
        resourceKey: Value(key),
        status: Value(keepSyncing ? SyncState.syncing : SyncState.success),
        lastSuccessAt: Value(DateTime.now()),
        nextOffset: Value(nextOffset),
        totalRemote: Value.absentIfNull(
          totalRemote,
        ), // Si no llega un total nuevo, se conserva el guardado.
      ),
    );
  }

  /// Tropiezo: marca la descarga como fallida sin tocar los datos.
  Future<void> markFailed(String key) async {
    await into(syncMetadataTable).insertOnConflictUpdate(
      SyncMetadataTableCompanion(
        resourceKey: Value(key),
        status: const Value(SyncState.error),
      ),
    );
  }
}
