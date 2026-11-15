import 'package:drift/drift.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_sync_status.dart';

/// Tabla sync_metadata: el expediente de cada recurso sincronizado: estado,
/// siguiente offset, total de PokeAPI y hora del ultimo exito.
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
