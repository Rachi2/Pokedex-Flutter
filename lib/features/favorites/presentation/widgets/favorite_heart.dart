import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorites_provider.dart';
import 'favorite_button.dart';

/// Corazon conectado: el FavoriteButton leyendo y cambiando el favorito en
/// la base. Se usa en la fila, la ficha y el detalle; como todos escuchan el
/// mismo stream, marcar en uno se ve en los demas.
class FavoriteHeart extends ConsumerWidget {
  const FavoriteHeart({
    super.key,
    required this.pokemonId,
    this.pokemonName,
    this.size = 24,
  });

  final int pokemonId;
  final String? pokemonName;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FavoriteButton(
      isFavorite: ref.watch(isFavoriteProvider(pokemonId)),
      pokemonName: pokemonName,
      size: size,
      onPressed: () => ref.read(favoriteToggleProvider)(pokemonId),
    );
  }
}
