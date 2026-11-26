import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/presentation/pages/pokemon_detail_page.dart';

import '../providers/favorites_provider.dart';
import '../widgets/favorites_view.dart';

/// Pestana Favoritos: escucha [favoritesListProvider] y se la pasa a
/// FavoritesView. Va dentro del AppShell, sin Scaffold propio.
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesListProvider);
    final list = favorites.value;

    if (list == null) {
      return favorites.hasError
          ? const Center(child: Text('No se pudieron leer los favoritos.'))
          : const Center(child: CircularProgressIndicator());
    }

    return FavoritesView(
      pokemon: list,
      onOpen: (pokemon) => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => PokemonDetailPage(pokemonId: pokemon.id),
        ),
      ),
      onToggle: (pokemon) => ref.read(favoriteToggleProvider)(pokemon.id),
    );
  }
}
