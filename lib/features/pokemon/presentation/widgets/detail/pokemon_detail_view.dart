import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/entities/type_chart.dart';

import '../pokemon_art_carousel.dart';
import '../pokemon_list_tile.dart';
import '../type_chip.dart';
import 'abilities_section.dart';
import 'detail_labels.dart';
import 'evolution_section.dart';
import 'info_section.dart';
import 'matchups_section.dart';
import 'moves_section.dart';
import 'stats_section.dart';

/// Vista completa del detalle: cabecera con imagenes y tipos, y debajo todas
/// las secciones. Solo recibe entidades, asi sirve igual con los datos de la
/// base que con los de prueba.
class PokemonDetailView extends StatefulWidget {
  const PokemonDetailView({
    super.key,
    required this.detail,
    required this.typeChart,
    this.onOpenPokemon,
  });

  final PokemonDetail detail;
  final TypeChart? typeChart;

  /// Abre otro Pokemon (una forma o una evolucion) por su id.
  final ValueChanged<int>? onOpenPokemon;

  @override
  State<PokemonDetailView> createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {
  var _shiny = false;

  @override
  Widget build(BuildContext context) {
    final detail = widget.detail;
    final pokemon = detail.pokemon;
    final textTheme = Theme.of(context).textTheme;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        PokemonArtCarousel(pokemon: _shiny ? pokemon.shiny : pokemon),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 20, 4, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
                  ],
                ),
              ),
              FilterChip(
                avatar: const Icon(Icons.auto_awesome_rounded, size: 18),
                label: const Text('Variocolor'),
                tooltip: 'Ver la versión shiny',
                selected: _shiny,
                showCheckmark: false,
                onSelected: (value) => setState(() => _shiny = value),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final type in pokemon.types)
                TypeChip(type: type, large: true),
            ],
          ),
        ),
        const SizedBox(height: 24),
        StatsSection(detail: detail),
        const SizedBox(height: 12),
        MatchupsSection(types: pokemon.types, typeChart: widget.typeChart),
        const SizedBox(height: 12),
        AbilitiesSection(detail: detail),
        const SizedBox(height: 12),
        EvolutionSection(
          chain: detail.evolutionChain,
          currentSpeciesId: pokemon.nationalDexNumber,
          onOpenSpecies: widget.onOpenPokemon,
        ),
        const SizedBox(height: 12),
        InfoSection(detail: detail, onOpenForm: widget.onOpenPokemon),
        const SizedBox(height: 12),
        MovesSection(
          // La clave reinicia el filtro al cambiar de Pokemon.
          key: ValueKey(pokemon.id),
          moves: detail.moves,
          typeNames: widget.typeChart?.typeNames,
        ),
      ],
    );
  }
}
