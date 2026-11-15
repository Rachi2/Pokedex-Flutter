import '../repositories/pokemon_repository.dart';

/// Caso de uso de paginado: descargar la siguiente pagina del catalogo.
class LoadNextPage {
  const LoadNextPage(this._repository);

  final PokemonRepository _repository;

  Future<void> call() => _repository.loadNextPage();
}
