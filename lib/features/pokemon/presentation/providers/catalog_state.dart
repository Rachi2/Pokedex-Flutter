import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

/// Estados de pantalla del catalogo: lo que tiene que mostrar.
///
/// Es sellada: la pantalla usa un switch y Dart obliga a cubrir
/// los cuatro casos.
sealed class CatalogState {
  const CatalogState();
}

/// Espera inicial: no hay datos guardados y se descarga la primera pagina.
final class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

/// Lista disponible: hay Pokemon guardados para mostrar.
final class CatalogData extends CatalogState {
  const CatalogData({
    required this.pokemon,
    required this.isLoadingMore,
    required this.hasMore,
    this.loadMoreFailure,
  });

  final List<Pokemon> pokemon;

  /// Se esta descargando la siguiente pagina.
  final bool isLoadingMore;

  /// Quedan paginas por descargar en PokeAPI.
  final bool hasMore;

  /// Error de la ultima pagina que se intento cargar, si fallo.
  final Failure? loadMoreFailure;
}

/// Sin datos ni descarga: no hay nada guardado y no se puede descargar ahora.
final class CatalogEmpty extends CatalogState {
  const CatalogEmpty(this.message);

  final String message;
}

/// Fracaso: no hay datos guardados y la descarga fallo.
final class CatalogError extends CatalogState {
  const CatalogError(this.failure);

  final Failure failure;
}
