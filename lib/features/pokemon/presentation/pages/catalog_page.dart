import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/favorites/presentation/widgets/favorite_heart.dart';

import '../../domain/entities/pokemon.dart';
import '../providers/catalog_filter_provider.dart';
import '../providers/catalog_provider.dart';
import '../providers/catalog_state.dart';
import '../widgets/catalog_state_views.dart';
import '../widgets/catalog_toolbar.dart';
import '../widgets/pokemon_grid_card.dart';
import '../widgets/pokemon_list_tile.dart';
import 'pokemon_detail_page.dart';

/// Portada: la pestaña del catálogo. Escucha [catalogProvider] y el filtro,
/// y muestra la barra de búsqueda y la vista de cada estado; nunca habla con
/// PokeAPI ni con Drift directamente.
///
/// No tiene Scaffold propio: va dentro del AppShell, que ya pone la barra
/// superior, el indicador de conectividad y la navegación inferior.
class CatalogPage extends ConsumerStatefulWidget {
  const CatalogPage({super.key});

  @override
  ConsumerState<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends ConsumerState<CatalogPage> {
  var _layout = CatalogLayout.list;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(catalogProvider);
    final notifier = ref.read(catalogProvider.notifier);
    final filterNotifier = ref.read(catalogFilterProvider.notifier);

    // CatalogState es sellada: si se agrega un estado, esto no compila
    // hasta que se decida cómo mostrarlo.
    final body = switch (state) {
      CatalogLoading() => const LoadingView(),
      CatalogEmpty(:final message) => EmptyView(
        message: message,
        onRetry: notifier.retry,
      ),
      CatalogError(:final failure) => ErrorView(
        failure: failure,
        onRetry: notifier.retry,
      ),
      CatalogNoResults() => NoResultsView(onClear: filterNotifier.clear),
      CatalogData data => _CatalogList(
        data: data,
        layout: _layout,
        onLoadMore: notifier.loadMore,
        onRefresh: notifier.refresh,
      ),
    };

    // La barra solo tiene sentido cuando ya hay algo guardado que filtrar.
    final showToolbar = state is CatalogData || state is CatalogNoResults;

    return Column(
      children: [
        if (showToolbar)
          CatalogToolbar(
            filter: ref.watch(catalogFilterProvider),
            onFilterChanged: filterNotifier.update,
            layout: _layout,
            onLayoutChanged: (layout) => setState(() => _layout = layout),
            savedCount: ref.watch(catalogSavedCountProvider).value,
            totalCount: ref.watch(catalogSyncStatusProvider).value?.totalRemote,
          ),
        Expanded(child: body),
      ],
    );
  }
}

/// Listado desplazable: filas o fichas de alto fijo, pull-to-refresh y
/// volver arriba.
class _CatalogList extends StatefulWidget {
  const _CatalogList({
    required this.data,
    required this.layout,
    required this.onLoadMore,
    required this.onRefresh,
  });

  final CatalogData data;
  final CatalogLayout layout;
  final Future<void> Function() onLoadMore;
  final Future<void> Function() onRefresh;

  @override
  State<_CatalogList> createState() => _CatalogListState();
}

class _CatalogListState extends State<_CatalogList> {
  /// Umbral de carga: cuantos pixeles antes del final se pide la siguiente
  /// pagina (unas tres filas), para que llegue antes de que el usuario la vea.
  static const double _loadMoreThreshold = PokemonListTile.height * 3;

  /// Umbral del boton: desde cuantos pixeles aparece (unas seis filas).
  static const double _backToTopThreshold = PokemonListTile.height * 6;

  final _scrollController = ScrollController();
  var _showBackToTop = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Freno del scroll.
  ///
  /// Solo se pide mas si quedan paginas, no hay una descarga en curso y la
  /// ultima no fallo (si fallo, el usuario decide con el boton Reintentar).
  bool get _canAutoLoad =>
      widget.data.hasMore &&
      !widget.data.isLoadingMore &&
      widget.data.loadMoreFailure == null;

  /// Sensor de scroll: pide la siguiente pagina cerca del final y muestra u
  /// oculta el boton de volver arriba.
  bool _onScroll(ScrollNotification notification) {
    if (_canAutoLoad && notification.metrics.extentAfter < _loadMoreThreshold) {
      widget.onLoadMore();
    }

    // setState solo cuando cruza el limite, no en cada pixel de scroll.
    final showBackToTop = notification.metrics.pixels > _backToTopThreshold;
    if (showBackToTop != _showBackToTop) {
      setState(() => _showBackToTop = showBackToTop);
    }

    // false: la notificacion sigue subiendo (la usa el RefreshIndicator).
    return false;
  }

  /// Lleva la lista al inicio; sin animacion si el sistema las reduce.
  void _backToTop() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _scrollController.jumpTo(0);
      return;
    }
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  /// Navega al detalle del Pokémon tocado.
  void _openDetail(BuildContext context, Pokemon pokemon) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PokemonDetailPage(pokemonId: pokemon.id),
      ),
    );
  }

  /// Corazon de cada Pokemon, conectado a favoritos.
  Widget _heart(Pokemon pokemon) =>
      FavoriteHeart(pokemonId: pokemon.id, pokemonName: pokemon.displayName);

  /// Elementos de la lista: filas o fichas en columnas. Todos miden lo
  /// mismo, asi la lista calcula posiciones sin medir cada uno y solo
  /// construye los visibles.
  Widget _buildItems(BuildContext context, List<Pokemon> pokemon) {
    return switch (widget.layout) {
      CatalogLayout.list => SliverPadding(
        padding: const EdgeInsets.only(top: 4),
        sliver: SliverFixedExtentList(
          itemExtent: PokemonListTile.height,
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = pokemon[index];
            return PokemonListTile(
              key: ValueKey(item.id),
              pokemon: item,
              onTap: () => _openDetail(context, item),
              trailing: _heart(item),
            );
          }, childCount: pokemon.length),
        ),
      ),
      CatalogLayout.grid => SliverPadding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            mainAxisExtent: PokemonGridCard.height,
          ),
          itemCount: pokemon.length,
          itemBuilder: (context, index) {
            final item = pokemon[index];
            return PokemonGridCard(
              key: ValueKey(item.id),
              pokemon: item,
              onTap: () => _openDetail(context, item),
              trailing: _heart(item),
            );
          },
        ),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.data.pokemon;

    return Stack(
      children: [
        RefreshIndicator(
          // Deslizar hacia abajo vuelve a pedir la primera pagina.
          onRefresh: widget.onRefresh,
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: CustomScrollView(
              controller: _scrollController,
              // Siempre deslizable, para que el pull-to-refresh funcione aunque
              // la lista sea corta.
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildItems(context, pokemon),
                // El pie (cargando, error o fin) va despues de los Pokemon.
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: PokemonListTile.height,
                    child: _ListFooter(
                      data: widget.data,
                      onLoadMore: widget.onLoadMore,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _showBackToTop
                ? FloatingActionButton.small(
                    key: const ValueKey('back-to-top'),
                    heroTag: null,
                    tooltip: 'Volver arriba',
                    onPressed: _backToTop,
                    child: const Icon(Icons.keyboard_arrow_up_rounded),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}

/// Pie de la lista: dice qué pasa con la siguiente página.
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
