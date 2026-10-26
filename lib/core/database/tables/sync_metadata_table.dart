import 'package:drift/drift.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_sync_status.dart';

@DataClassName('SyncMetadataRow')
class SyncMetadataTable extends Table {
  @override
  String get tableName => 'sync_metadata';

  TextColumn get resourceKey => text()();
  DateTimeColumn get lastSuccessAt => dateTime().nullable()();
  TextColumn get status =>
      textEnum<SyncState>().withDefault(Constant(SyncState.idle.name))();
  IntColumn get nextOffset => integer().withDefault(const Constant(0))();
  IntColumn get totalRemote => integer().nullable()();

  @override
  Set<Column> get primaryKey => {resourceKey};
}
