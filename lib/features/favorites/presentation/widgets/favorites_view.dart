import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list_tile.dart';

import 'favorite_button.dart';

/// Coleccion personal: la lista de favoritos, del mas reciente al mas viejo,
/// o el estado vacio si no hay ninguno.
///
/// Recibe la lista ya leida de la base; al quitar uno muestra «Deshacer»,
/// que lo vuelve a marcar.
class FavoritesView extends StatelessWidget {
  const FavoritesView({
    super.key,
    required this.pokemon,
    required this.onOpen,
    required this.onToggle,
  });

  final List<Pokemon> pokemon;
  final ValueChanged<Pokemon> onOpen;

  /// Marca o desmarca un favorito.
  final ValueChanged<Pokemon> onToggle;

  void _remove(BuildContext context, Pokemon item) {
    onToggle(item);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${item.displayName} ya no está en favoritos'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () => onToggle(item),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    if (pokemon.isEmpty) return const _EmptyFavorites();

    final theme = Theme.of(context);
    final count = pokemon.length;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: Text(
              '$count ${count == 1 ? 'favorito' : 'favoritos'} · disponibles '
              'sin conexión',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 12),
          sliver: SliverFixedExtentList.builder(
            itemExtent: PokemonListTile.height,
            itemCount: count,
            itemBuilder: (context, index) {
              final item = pokemon[index];
              return PokemonListTile(
                key: ValueKey(item.id),
                pokemon: item,
                onTap: () => onOpen(item),
                trailing: FavoriteButton(
                  isFavorite: true,
                  pokemonName: item.displayName,
                  onPressed: () => _remove(context, item),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Estado vacio de favoritos: explica como agregar el primero.
class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border_rounded, size: 56, color: muted),
            const SizedBox(height: 16),
            Text(
              'Aún no tienes favoritos',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Toca el corazón de un Pokémon en el catálogo o en su detalle. '
              'Tus favoritos se guardan en el teléfono y funcionan sin '
              'conexión.',
              style: theme.textTheme.bodyMedium?.copyWith(color: muted),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
