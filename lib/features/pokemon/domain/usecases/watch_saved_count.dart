import '../repositories/pokemon_repository.dart';

/// Caso de uso contador: observar cuantos Pokemon hay guardados, para el
/// aviso de catalogo incompleto.
class WatchSavedCount {
  const WatchSavedCount(this._repository);

  final PokemonRepository _repository;

  Stream<int> call() => _repository.watchSavedCount();
}
