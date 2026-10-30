import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/pokemon.dart';
import '../providers/catalog_provider.dart';
import '../providers/catalog_state.dart';
import '../widgets/catalog_state_views.dart';
import '../widgets/pokemon_list_tile.dart';
import 'pokemon_detail_page.dart';

/// Pestaña del catálogo. Escucha [catalogProvider] y muestra la vista de
/// cada estado; nunca habla con PokeAPI ni con Drift directamente.
///
/// No tiene Scaffold propio: va dentro del AppShell, que ya pone la barra
/// superior, el indicador de conectividad y la navegación inferior.
class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(catalogProvider);
    final notifier = ref.read(catalogProvider.notifier);

    // CatalogState es sellada: si se agrega un estado, esto no compila
    // hasta que se decida cómo mostrarlo.
    return switch (state) {
      CatalogLoading() => const LoadingView(),
      CatalogEmpty(:final message) => EmptyView(
        message: message,
        onRetry: notifier.retry,
      ),
      CatalogError(:final failure) => ErrorView(
        failure: failure,
        onRetry: notifier.retry,
      ),
      CatalogData data => _CatalogList(
        data: data,
        onLoadMore: notifier.loadMore,
        onRefresh: notifier.refresh,
      ),
    };
  }
}

class _CatalogList extends StatelessWidget {
  const _CatalogList({
    required this.data,
    required this.onLoadMore,
    required this.onRefresh,
  });

  final CatalogData data;
  final Future<void> Function() onLoadMore;
  final Future<void> Function() onRefresh;

  /// Cuántos píxeles antes del final se pide la siguiente página
  /// (unas tres filas), para que llegue antes de que el usuario la vea.
  static const double _loadMoreThreshold = PokemonListTile.height * 3;

  /// Solo se pide más si quedan páginas, no hay una descarga en curso y la
  /// última no falló (si falló, el usuario decide con el botón Reintentar).
  bool get _canAutoLoad =>
      data.hasMore && !data.isLoadingMore && data.loadMoreFailure == null;

  bool _onScroll(ScrollNotification notification) {
    if (_canAutoLoad && notification.metrics.extentAfter < _loadMoreThreshold) {
      onLoadMore();
    }
    // false: la notificación sigue subiendo (la usa el RefreshIndicator).
    return false;
  }

  void _openDetail(BuildContext context, Pokemon pokemon) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PokemonDetailPage(pokemonId: pokemon.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = data.pokemon;

    return RefreshIndicator(
      // Deslizar hacia abajo vuelve a pedir la primera página.
      onRefresh: onRefresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: ListView.builder(
          // Siempre deslizable, para que el pull-to-refresh funcione aunque
          // la lista sea corta.
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 4),
          // Todas las filas miden lo mismo: la lista calcula posiciones sin
          // medir cada una y solo construye las visibles (RNF-REN-01).
          itemExtent: PokemonListTile.height,
          // Un elemento extra al final para el pie (cargando, error o fin).
          itemCount: pokemon.length + 1,
          itemBuilder: (context, index) {
            if (index == pokemon.length) {
              return _ListFooter(data: data, onLoadMore: onLoadMore);
            }
            final item = pokemon[index];
            return PokemonListTile(
              key: ValueKey(item.id),
              pokemon: item,
              onTap: () => _openDetail(context, item),
            );
          },
        ),
      ),
    );
  }
}

/// Último elemento de la lista: dice qué pasa con la siguiente página.
class _ListFooter extends StatelessWidget {
  const _ListFooter({required this.data, required this.onLoadMore});

  final CatalogData data;
  final Future<void> Function() onLoadMore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final failure = data.loadMoreFailure;

    final Widget child;
    if (failure != null) {
      // Falló la página siguiente: lo ya cargado se sigue viendo.
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              failure.message,
              style: muted,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: onLoadMore,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Reintentar'),
          ),
        ],
      );
    } else if (data.isLoadingMore) {
      child = Semantics(
        label: 'Cargando más Pokémon',
        child: const SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      );
    } else if (data.hasMore) {
      // Normalmente el scroll pide la página solo; el botón sirve si no
      // hubo scroll (lista corta) o para quien usa lector de pantalla.
      child = TextButton(
        onPressed: onLoadMore,
        child: const Text('Cargar más'),
      );
    } else {
      child = Text(
        'Has visto los ${data.pokemon.length} Pokémon',
        style: muted,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(child: child),
    );
  }
}
