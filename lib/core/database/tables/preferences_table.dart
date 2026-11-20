import 'package:drift/drift.dart';

/// Tabla preferences: el casillero de ajustes del usuario, en pares
/// clave-valor (theme, locale...), para agregar ajustes sin migrar.
@DataClassName('PreferenceRow')
class PreferencesTable extends Table {
  @override
  String get tableName => 'preferences';

  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
