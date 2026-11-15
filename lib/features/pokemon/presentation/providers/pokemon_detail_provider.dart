import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/pokemon_providers.dart';

/// Seguimiento de un Pokemon guardado en Drift, por id. Emite si cambia.
final pokemonDetailProvider = StreamProvider.family<Pokemon?, int>((ref, id) {
  return ref.watch(watchPokemonProvider)(id);
});
