import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

import '../providers/pokemon_detail_provider.dart';
import '../widgets/pokemon_image.dart';
import '../widgets/pokemon_list_tile.dart';
import '../widgets/type_chip.dart';

/// Detalle basico de un Pokemon, leido solo de la base local.
///
/// Sirve para demostrar que se puede navegar mientras se sincroniza.
/// El detalle completo es de la entrega final.
class PokemonDetailPage extends ConsumerWidget {
  const PokemonDetailPage({super.key, required this.pokemonId});

  final int pokemonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDetailProvider(pokemonId));

    return Scaffold(
      appBar: AppBar(title: Text(pokemon.value?.displayName ?? 'Pokémon')),
      body: switch (pokemon) {
        AsyncData(value: final Pokemon found) => _DetailBody(pokemon: found),
        AsyncData() => const Center(
          child: Text('Este Pokémon no está guardado en el dispositivo.'),
        ),
        AsyncError() => const Center(
          child: Text('No se pudo leer el Pokémon.'),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: PokemonImage(
            url: pokemon.imageUrl,
            size: 240,
            semanticLabel: 'Imagen de ${pokemon.displayName}',
          ),
        ),
        const SizedBox(height: 16),
        Text(
          pokemon.dexLabel,
          style: textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          pokemon.displayName,
          style: textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: [for (final type in pokemon.types) TypeChip(type: type)],
        ),
      ],
    );
  }
}
