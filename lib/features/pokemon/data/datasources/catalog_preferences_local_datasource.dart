import 'dart:convert';

import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_filter.dart';

/// Memoria del buscador: guarda y lee el filtro del catalogo en la tabla
/// preferences (clave-valor), para que la busqueda, los filtros y el orden
/// sigan igual al volver a abrir la app. No necesita migracion: es una fila
/// mas con la clave [filterKey].
class CatalogPreferencesLocalDataSource {
  CatalogPreferencesLocalDataSource(this._db);

  final AppDatabase _db;

  /// Clave de la fila en preferences.
  static const filterKey = 'catalog_filter';

  /// Lee el filtro guardado; si no hay o esta danado, el de por defecto.
  Future<CatalogFilter> loadFilter() async {
    final table = _db.preferencesTable;
    final row = await (_db.select(
      table,
    )..where((t) => t.key.equals(filterKey))).getSingleOrNull();
    if (row == null) return const CatalogFilter();

    try {
      final json = jsonDecode(row.value) as Map<String, dynamic>;
      return _fromJson(json);
    } on Object {
      // Un valor viejo o roto no debe impedir abrir el catalogo.
      return const CatalogFilter();
    }
  }

  /// Escribe el filtro encima del anterior (una sola fila por clave).
  Future<void> saveFilter(CatalogFilter filter) {
    return _db
        .into(_db.preferencesTable)
        .insertOnConflictUpdate(
          PreferencesTableCompanion.insert(
            key: filterKey,
            value: jsonEncode(_toJson(filter)),
          ),
        );
  }

  /// Traductor a JSON: el orden se guarda por nombre ('name', 'number'...)
  /// para que no dependa de la posicion en el enum.
  static Map<String, Object?> _toJson(CatalogFilter filter) => {
    'query': filter.query,
    'typeId': filter.typeId,
    'generationId': filter.generationId,
    'sort': filter.sort.name,
    'descending': filter.descending,
  };

  /// Traductor desde JSON: lo que falte o no se reconozca queda por defecto.
  static CatalogFilter _fromJson(Map<String, dynamic> json) {
    final sortName = json['sort'] as String?;
    return CatalogFilter(
      query: json['query'] as String? ?? '',
      typeId: json['typeId'] as int?,
      generationId: json['generationId'] as int?,
      sort: CatalogSort.values.firstWhere(
        (sort) => sort.name == sortName,
        orElse: () => CatalogSort.number,
      ),
      descending: json['descending'] as bool? ?? false,
    );
  }
}
