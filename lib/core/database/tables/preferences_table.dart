import 'package:drift/drift.dart';

@DataClassName('PreferenceRow')
class PreferencesTable extends Table {
  @override
  String get tableName => 'preferences';

  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
