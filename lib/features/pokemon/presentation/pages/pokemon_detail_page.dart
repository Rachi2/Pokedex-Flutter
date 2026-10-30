import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/connectivity/presentation/widgets/connectivity_indicator.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

import '../providers/catalog_provider.dart';
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
    final syncStatus = ref.watch(catalogSyncStatusProvider).value;

    return Scaffold(
      appBar: AppBar(
        // El indicador sigue visible fuera del catalogo (IND-01).
        actions: [
          ConnectivityIndicator(syncStatus: syncStatus, compact: true),
          const SizedBox(width: 16),
        ],
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final muted = theme.colorScheme.onSurfaceVariant;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        // Cuadro grande teñido con el color del tipo principal.
        Container(
          height: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: pokemon.imageTint(theme),
            borderRadius: BorderRadius.circular(28),
          ),
          child: PokemonImage(
            url: pokemon.imageUrl,
            size: 240,
            semanticLabel: 'Imagen oficial de ${pokemon.displayName}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 20, 4, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pokemon.dexLabel,
                style: textTheme.titleMedium?.copyWith(
                  color: muted,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                pokemon.displayName,
                style: textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final type in pokemon.types)
                    TypeChip(type: type, large: true),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _SavedDataCard(pokemon: pokemon),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
          child: Text(
            'Estadísticas, habilidades, evoluciones y movimientos llegan en '
            'la entrega final.',
            style: textTheme.bodySmall?.copyWith(color: muted),
          ),
        ),
      ],
    );
  }
}

/// Tarjeta "Datos guardados": deja claro que todo sale de la base local.
class _SavedDataCard extends StatelessWidget {
  const _SavedDataCard({required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final check = theme.brightness == Brightness.dark
        ? const Color(0xFF9BD497)
        : const Color(0xFF2E6B2C);

    return Semantics(
      container: true,
      label: 'Datos guardados',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _DataRow(
              label: 'Número nacional',
              value: Text('${pokemon.nationalDexNumber}'),
            ),
            Divider(height: 1, color: scheme.outlineVariant),
            const _DataRow(
              label: 'Origen de los datos',
              value: Text('Base local'),
            ),
            Divider(height: 1, color: scheme.outlineVariant),
            _DataRow(
              label: 'Disponible sin conexión',
              value: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_rounded, size: 18, color: check),
                  const SizedBox(width: 6),
                  const Text('Sí'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          DefaultTextStyle.merge(
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            child: value,
          ),
        ],
      ),
    );
  }
}
