import '../entities/catalog_sync_status.dart';
import '../repositories/pokemon_repository.dart';

/// Caso de uso: observar el estado y la fecha de la ultima sincronizacion.
class WatchCatalogSync {
  const WatchCatalogSync(this._repository);

  final PokemonRepository _repository;

  Stream<CatalogSyncStatus> call() => _repository.watchCatalogSync();
}
