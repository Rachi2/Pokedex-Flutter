import '../repositories/pokemon_repository.dart';

/// Caso de uso: volver a pedir la primera pagina del catalogo.
class RefreshCatalog {
  const RefreshCatalog(this._repository);

  final PokemonRepository _repository;

  Future<void> call() => _repository.refresh();
}
