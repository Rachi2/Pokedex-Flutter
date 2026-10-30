import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

import '../providers/pokemon_detail_provider.dart';

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
      appBar: AppBar(
        title: Text(
          pokemon.value == null ? 'Pokémon' : _displayName(pokemon.value!),
        ),
      ),
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
    final imageUrl = pokemon.imageUrl;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Imagen grande; CachedNetworkImage la guarda en disco para offline.
        SizedBox(
          height: 240,
          child: imageUrl == null
              ? const _NoImage()
              : CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (_, _) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (_, _, _) => const _NoImage(),
                ),
        ),
        const SizedBox(height: 16),
        Text(
          _dexNumber(pokemon.nationalDexNumber),
          style: textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          _displayName(pokemon),
          style: textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: [
            for (final type in pokemon.types) Chip(label: Text(type.name)),
          ],
        ),
      ],
    );
  }
}

class _NoImage extends StatelessWidget {
  const _NoImage();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image_not_supported_outlined, size: 64),
        SizedBox(height: 8),
        Text('Imagen no disponible'),
      ],
    );
  }
}

/// 25 -> "#025".
String _dexNumber(int number) => '#${number.toString().padLeft(3, '0')}';

/// "bulbasaur" -> "Bulbasaur".
String _displayName(Pokemon pokemon) {
  final name = pokemon.name;
  if (name.isEmpty) return name;
  return name[0].toUpperCase() + name.substring(1);
}
