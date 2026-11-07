import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/di/core_providers.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/features/connectivity/domain/entities/service_status.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_sync_status.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/pokemon_providers.dart';

import 'catalog_state.dart';

/// Los Pokemon guardados en Drift; emite cada vez que cambian.
final catalogPokemonProvider = StreamProvider<List<Pokemon>>((ref) {
  return ref.watch(watchCatalogProvider)();
});

/// Estado y fecha de la ultima sincronizacion del catalogo.
final catalogSyncStatusProvider = StreamProvider<CatalogSyncStatus>((ref) {
  return ref.watch(watchCatalogSyncProvider)();
});

/// Estado de la pantalla del catalogo, con loadMore(), retry() y refresh().
final catalogProvider = NotifierProvider<CatalogNotifier, CatalogState>(
  CatalogNotifier.new,
);

class CatalogNotifier extends Notifier<CatalogState> {
  @override
  CatalogState build() {
    return buildCatalogState(
      pokemon: ref.watch(catalogPokemonProvider),
      sync: ref.watch(catalogSyncStatusProvider).value,
      service: ref.watch(serviceStatusProvider).value,
      actions: ref.watch(catalogActionsProvider),
    );
  }

  /// Pide la siguiente pagina (scroll infinito).
  Future<void> loadMore() {
    return ref.read(catalogActionsProvider.notifier).loadMore();
  }

  /// Vuelve a intentar despues de un error.
  Future<void> retry() => loadMore();

  /// Vuelve a pedir la primera pagina (deslizar hacia abajo).
  Future<void> refresh() {
    return ref.read(catalogActionsProvider.notifier).refresh();
  }
}

/// Combina la base local, la sincronizacion y la conectividad
/// en el estado que ve la pantalla.
CatalogState buildCatalogState({
  required AsyncValue<List<Pokemon>> pokemon,
  required CatalogSyncStatus? sync,
  required ServiceStatus? service,
  required CatalogActionsState actions,
}) {
  final list = pokemon.value;

  // Todavia no se leyo la base local.
  if (list == null) {
    return pokemon.hasError
        ? const CatalogError(UnknownFailure())
        : const CatalogLoading();
  }

  // Hay datos: se muestran aunque no haya red (offline-first).
  if (list.isNotEmpty) {
    return CatalogData(
      pokemon: list,
      isLoadingMore: actions.isLoading || sync?.state == SyncState.syncing,
      hasMore: sync?.hasMorePages ?? true,
      loadMoreFailure: actions.failure,
    );
  }

  // No hay datos y no hay red: no hay nada que descargar.
  if (service == ServiceStatus.offline) {
    return const CatalogEmpty(
      'Sin conexión. Conéctate a Internet para descargar el catálogo.',
    );
  }

  // No hay datos y la descarga fallo.
  if (sync?.state == SyncState.error) {
    final failure =
        actions.failure ??
        (service == ServiceStatus.unavailable
            ? const ServerFailure()
            : const UnknownFailure());
    return CatalogError(failure);
  }

  // La descarga termino bien pero no trajo nada.
  if (sync?.state == SyncState.success) {
    return const CatalogEmpty('No hay Pokémon para mostrar.');
  }

  // No hay datos y la API no responde: no se va a descargar nada solo.
  if (service == ServiceStatus.unavailable) {
    return const CatalogError(ServerFailure());
  }

  // Comprobando la red o descargando la primera pagina.
  return const CatalogLoading();
}

/// Lo que esta pasando con las acciones que pidio el usuario.
class CatalogActionsState {
  const CatalogActionsState({this.isLoading = false, this.failure});

  final bool isLoading;

  /// Error de la ultima accion, o null si salio bien.
  final Failure? failure;
}

/// Guarda el estado de loadMore y refresh en su propio provider:
/// CatalogNotifier se vuelve a crear cada vez que cambia la base local,
/// y asi este estado no se pierde.
final catalogActionsProvider =
    NotifierProvider<CatalogActionsNotifier, CatalogActionsState>(
      CatalogActionsNotifier.new,
    );

class CatalogActionsNotifier extends Notifier<CatalogActionsState> {
  @override
  CatalogActionsState build() => const CatalogActionsState();

  Future<void> loadMore() => _run(ref.read(loadNextPageProvider).call);

  Future<void> refresh() => _run(ref.read(refreshCatalogProvider).call);

  Future<void> _run(Future<void> Function() action) async {
    if (state.isLoading) return;

    state = const CatalogActionsState(isLoading: true);
    try {
      await action();
      state = const CatalogActionsState();
    } on Failure catch (failure) {
      state = CatalogActionsState(failure: failure);
    }
  }
}
