import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';

import '../pokemon_image.dart';
import 'detail_labels.dart';
import 'detail_section.dart';

/// Arbol evolutivo: la cadena desde su raiz, con cada evolucion sangrada
/// bajo la especie de la que sale y el requisito para llegar a ella.
class EvolutionSection extends StatelessWidget {
  const EvolutionSection({
    super.key,
    required this.chain,
    required this.currentSpeciesId,
    this.onOpenSpecies,
  });

  final EvolutionChain? chain;

  /// La especie que se esta viendo; se resalta en el arbol.
  final int currentSpeciesId;

  /// Al tocar una especie distinta de la actual. null = no se puede tocar.
  final ValueChanged<int>? onOpenSpecies;

  @override
  Widget build(BuildContext context) {
    final chain = this.chain;

    return DetailSection(
      title: 'Evoluciones',
      child: chain == null || !chain.evolves
          ? const DetailEmptyNote('No evoluciona.')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final root in chain.roots)
                  _StageBranch(
                    chain: chain,
                    stage: root,
                    currentSpeciesId: currentSpeciesId,
                    onOpenSpecies: onOpenSpecies,
                    depth: 0,
                  ),
              ],
            ),
    );
  }
}

/// Rama del arbol: una especie y, debajo y sangradas, las que salen de ella.
/// Se llama a si misma para cada hija, asi sirve para cualquier profundidad.
class _StageBranch extends StatelessWidget {
  const _StageBranch({
    required this.chain,
    required this.stage,
    required this.currentSpeciesId,
    required this.onOpenSpecies,
    required this.depth,
  });

  final EvolutionChain chain;
  final EvolutionStage stage;
  final int currentSpeciesId;
  final ValueChanged<int>? onOpenSpecies;
  final int depth;

  @override
  Widget build(BuildContext context) {
    final children = chain.childrenOf(stage.speciesId);
    final outline = Theme.of(context).colorScheme.outlineVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StageTile(
          stage: stage,
          isCurrent: stage.speciesId == currentSpeciesId,
          showMethod: depth > 0,
          onTap: onOpenSpecies == null || stage.speciesId == currentSpeciesId
              ? null
              : () => onOpenSpecies!(stage.speciesId),
        ),
        if (children.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(left: 27),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: outline, width: 2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final child in children)
                  _StageBranch(
                    chain: chain,
                    stage: child,
                    currentSpeciesId: currentSpeciesId,
                    onOpenSpecies: onOpenSpecies,
                    depth: depth + 1,
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Eslabon visible: sprite, nombre y requisito de una especie de la cadena.
class _StageTile extends StatelessWidget {
  const _StageTile({
    required this.stage,
    required this.isCurrent,
    required this.showMethod,
    required this.onTap,
  });

  final EvolutionStage stage;
  final bool isCurrent;
  final bool showMethod;
  final VoidCallback? onTap;

  /// PokeAPI guarda el sprite de cada especie con su numero como nombre.
  static String _spriteUrl(int speciesId) =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/'
      'pokemon/$speciesId.png';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final name = DetailLabels.pretty(stage.name);
    final method = showMethod && stage.methods.isNotEmpty
        ? DetailLabels.evolutionMethod(stage.methods.first)
        : null;

    return Semantics(
      button: onTap != null,
      selected: isCurrent,
      label: [name, ?method, if (isCurrent) 'actual'].join(', '),
      child: ExcludeSemantics(
        child: Material(
          color: isCurrent ? scheme.secondaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                children: [
                  PokemonImage(
                    url: _spriteUrl(stage.speciesId),
                    size: 48,
                    semanticLabel: 'Imagen de $name',
                    pixelated: true,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (method != null)
                          Text(
                            method,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (onTap != null)
                    Icon(
                      Icons.chevron_right_rounded,
                      color: scheme.onSurfaceVariant,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
