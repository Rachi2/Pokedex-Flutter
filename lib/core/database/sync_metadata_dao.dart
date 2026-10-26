import 'package:drift/drift.dart';

import 'app_database.dart';
import 'tables/sync_metadata_table.dart';

import 'package:pokedex/features/pokemon/domain/entities/catalog_sync_status.dart';

part 'sync_metadata_dao.g.dart';

@DriftAccessor(tables: [SyncMetadataTable])
class SyncMetadataDao extends DatabaseAccessor<AppDatabase>
    with _$SyncMetadataDaoMixin {
  SyncMetadataDao(super.attachedDatabase);

  static const catalogKey = 'catalog';

  SimpleSelectStatement<$SyncMetadataTableTable, SyncMetadataRow> _byKey(
    String key,
  ) => select(syncMetadataTable)..where((t) => t.resourceKey.equals(key));

  Stream<SyncMetadataRow?> watch(String key) {
    return _byKey(key).watchSingleOrNull();
  }

  Future<SyncMetadataRow?> get(String key) {
    return _byKey(key).getSingleOrNull();
  }

  Future<void> markSyncing(String key) async {
    await into(syncMetadataTable).insertOnConflictUpdate(
      SyncMetadataTableCompanion(
        resourceKey: Value(key),
        status: const Value(SyncState.syncing),
      ),
    );
  }

  Future<void> markSuccess(
    String key, {
    required int nextOffset,
    int? totalRemote,
  }) async {
    await into(syncMetadataTable).insertOnConflictUpdate(
      SyncMetadataTableCompanion(
        resourceKey: Value(key),
        status: const Value(SyncState.success),
        lastSuccessAt: Value(DateTime.now()),
        nextOffset: Value(nextOffset),
        totalRemote: Value.absentIfNull(
          totalRemote,
        ), // Si no llega un total nuevo, se conserva el guardado.
      ),
    );
  }

  Future<void> markFailed(String key) async {
    await into(syncMetadataTable).insertOnConflictUpdate(
      SyncMetadataTableCompanion(
        resourceKey: Value(key),
        status: const Value(SyncState.error),
      ),
    );
  }
}
