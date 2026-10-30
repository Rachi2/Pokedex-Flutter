import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

/// Lo que la pantalla del catalogo tiene que mostrar.
///
/// Es sellada: la pantalla usa un switch y Dart obliga a cubrir
/// los cuatro casos.
sealed class CatalogState {
  const CatalogState();
}

/// No hay datos guardados y se esta descargando la primera pagina.
final class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

/// Hay Pokemon guardados para mostrar.
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

/// No hay datos guardados y no se pueden descargar ahora.
final class CatalogEmpty extends CatalogState {
  const CatalogEmpty(this.message);

  final String message;
}

/// No hay datos guardados y la descarga fallo.
final class CatalogError extends CatalogState {
  const CatalogError(this.failure);

  final Failure failure;
}
