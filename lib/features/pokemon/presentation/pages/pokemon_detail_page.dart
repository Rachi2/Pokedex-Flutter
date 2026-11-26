import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/features/connectivity/presentation/widgets/connectivity_indicator.dart';
import 'package:pokedex/features/favorites/presentation/widgets/favorite_heart.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';

import '../providers/catalog_provider.dart';
import '../providers/pokemon_detail_provider.dart';
import '../providers/pokemon_full_detail_provider.dart';
import '../widgets/catalog_state_views.dart';
import '../widgets/detail/pokemon_detail_view.dart';
import '../widgets/pokemon_art_carousel.dart';
import '../widgets/pokemon_list_tile.dart';
import '../widgets/type_chip.dart';

/// Ventana del detalle: muestra el detalle completo guardado en la base y,
/// al abrirla, lo vuelve a descargar de PokeAPI.
///
/// Si el detalle completo todavia no esta guardado (por ejemplo, sin
/// conexion), muestra lo basico que hay del catalogo.
class PokemonDetailPage extends ConsumerWidget {
  const PokemonDetailPage({super.key, required this.pokemonId});

  final int pokemonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(fullDetailProvider(pokemonId));
    final download = ref.watch(detailDownloadProvider(pokemonId));
    final basic = ref.watch(pokemonDetailProvider(pokemonId)).value;
    final typeChart = ref.watch(typeChartProvider).value;
    final syncStatus = ref.watch(catalogSyncStatusProvider).value;
    void retry() => ref.read(detailDownloadProvider(pokemonId).notifier).load();

    return Scaffold(
      appBar: AppBar(
        // El indicador sigue visible fuera del catalogo.
        actions: [
          ConnectivityIndicator(syncStatus: syncStatus, compact: true),
          const SizedBox(width: 4),
          // El mismo corazon de la lista: marcar aqui se ve alla al volver.
          FavoriteHeart(pokemonId: pokemonId, pokemonName: basic?.displayName),
          const SizedBox(width: 8),
        ],
      ),
      body: switch (detail) {
        AsyncData(value: final PokemonDetail full) => PokemonDetailView(
          detail: full,
          typeChart: typeChart,
          onOpenPokemon: (id) => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => PokemonDetailPage(pokemonId: id),
            ),
          ),
        ),
        // Todavia no hay detalle completo: lo basico del catalogo, si esta.
        AsyncData() when basic != null => _DetailBody(
          pokemon: basic,
          footer: _DownloadNote(download: download, onRetry: retry),
        ),
        AsyncData() when download.failure != null => ErrorView(
          failure: download.failure!,
          onRetry: retry,
        ),
        AsyncError() => ErrorView(
          failure: const UnknownFailure(),
          onRetry: retry,
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

/// Leyenda de la descarga: debajo del detalle basico, dice si el completo
/// esta bajando o si fallo, con Reintentar.
class _DownloadNote extends StatelessWidget {
  const _DownloadNote({required this.download, required this.onRetry});

  final DetailDownloadState download;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    if (download.isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LinearProgressIndicator(),
          const SizedBox(height: 8),
          Text('Descargando el detalle completo…', style: muted),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: Text(
            'El detalle completo se descarga cuando hay conexión.',
            style: muted,
          ),
        ),
        TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Reintentar'),
        ),
      ],
    );
  }
}

/// Cuerpo del detalle: carrusel, numero, nombre, tipos y datos guardados.
class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.pokemon, required this.footer});

  final Pokemon pokemon;

  /// Lo que va al final: el estado de la descarga del detalle completo.
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final muted = theme.colorScheme.onSurfaceVariant;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        PokemonArtCarousel(pokemon: pokemon),
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
        Padding(padding: const EdgeInsets.fromLTRB(4, 16, 4, 0), child: footer),
      ],
    );
  }
}

/// Tarjeta de origen local: deja claro que todo sale de la base del telefono.
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
          color: theme.brightness == Brightness.dark
              ? scheme.surfaceContainerLow
              : pokemon.imageTint(theme),
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

/// Renglon de la tarjeta: etiqueta a la izquierda y valor a la derecha.
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
