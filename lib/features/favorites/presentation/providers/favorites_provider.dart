import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

import '../../favorites_providers.dart';

/// Marcador vivo: los ids de todos los favoritos. El catalogo y el detalle
/// lo escuchan para pintar el corazon; como sale de un stream de Drift, al
/// marcar en una pantalla se ve en las otras sin recargar.
final favoriteIdsProvider = StreamProvider<Set<int>>((ref) {
  return ref.watch(favoritesRepositoryProvider).watchFavoriteIds();
});

/// Pregunta puntual: si un Pokemon es favorito. Con select, solo se vuelve a
/// construir el corazon de ese Pokemon cuando su respuesta cambia.
final isFavoriteProvider = Provider.family<bool, int>((ref, pokemonId) {
  return ref.watch(
    favoriteIdsProvider.select(
      (ids) => ids.value?.contains(pokemonId) ?? false,
    ),
  );
});

/// Vitrina de favoritos: los Pokemon marcados con sus tipos, del ultimo que
/// se marco al primero. La usa la pestana Favoritos.
final favoritesListProvider = StreamProvider<List<Pokemon>>((ref) {
  return ref.watch(favoritesRepositoryProvider).watchFavorites();
});

/// Interruptor de favoritos: marca o desmarca un Pokemon. No hace falta
/// tocar el estado a mano: Drift avisa a los streams de arriba.
final favoriteToggleProvider = Provider<Future<bool> Function(int pokemonId)>((
  ref,
) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return repository.toggleFavorite;
});
