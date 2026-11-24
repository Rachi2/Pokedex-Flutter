/// Formas de ordenar el catalogo. baseStatTotal es el Puntaje base: la suma
/// de las seis estadisticas base de cada Pokemon.
enum CatalogSort { number, name, type, baseStatTotal }

/// Embudo del catalogo: lo que el usuario eligio en la barra (busqueda,
/// tipo, generacion y orden). Va en el dominio porque lo usan la pantalla,
/// el provider y la consulta de Drift. Sin nada elegido: todo, por numero.
class CatalogFilter {
  const CatalogFilter({
    this.query = '',
    this.typeId,
    this.generationId,
    this.sort = CatalogSort.number,
    this.descending = false,
  });

  final String query;
  final int? typeId;
  final int? generationId;
  final CatalogSort sort;
  final bool descending;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatalogFilter &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          typeId == other.typeId &&
          generationId == other.generationId &&
          sort == other.sort &&
          descending == other.descending;

  @override
  int get hashCode =>
      Object.hash(query, typeId, generationId, sort, descending);
}
