import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';

import '../pokemon_image.dart';
import 'detail_labels.dart';
import 'detail_section.dart';

/// PokeAPI guarda el sprite de cada Pokemon (especie o forma) con su id como
/// nombre de archivo.
String _spriteUrl(int pokemonId) =>
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/'
    'pokemon/$pokemonId.png';

/// Arbol evolutivo: la cadena de arriba hacia abajo y, al lado de cada
/// especie, sus formas (megas, gigamax...). Si la cadena se divide, las
/// ramas van sangradas bajo la especie de la que salen.
class EvolutionSection extends StatelessWidget {
  const EvolutionSection({
    super.key,
    required this.chain,
    required this.currentPokemonId,
    this.formsBySpecies = const {},
    this.onOpenPokemon,
  });

  final EvolutionChain? chain;

  /// El Pokemon que se esta viendo (especie o forma); se resalta.
  final int currentPokemonId;

  /// Formas de cada especie de la cadena, por id de especie. Las que no
  /// aparecen aqui se pintan sin formas al lado.
  final Map<int, List<PokemonForm>> formsBySpecies;

  /// Al tocar una especie o forma distinta de la actual. null = no se puede
  /// tocar.
  final ValueChanged<int>? onOpenPokemon;

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
                  _StageBranch(chain: chain, stage: root, section: this),
              ],
            ),
    );
  }
}

/// Rama del arbol: una especie y lo que sale de ella. Si sale una sola
/// especie va justo debajo, unida por una linea; si salen varias, van
/// sangradas. Se llama a si misma, asi sirve para cualquier profundidad.
class _StageBranch extends StatelessWidget {
  const _StageBranch({
    required this.chain,
    required this.stage,
    required this.section,
  });

  final EvolutionChain chain;
  final EvolutionStage stage;
  final EvolutionSection section;

  @override
  Widget build(BuildContext context) {
    final outline = Theme.of(context).colorScheme.outlineVariant;
    final branches = [
      for (final child in chain.childrenOf(stage.speciesId))
        _StageBranch(chain: chain, stage: child, section: section),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StageRow(stage: stage, section: section),
        if (branches.length == 1) ...[
          Container(
            margin: const EdgeInsets.only(left: 27),
            width: 2,
            height: 12,
            color: outline,
          ),
          branches.single,
        ] else if (branches.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(left: 27),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: outline, width: 2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: branches,
            ),
          ),
      ],
    );
  }
}

/// Renglon de etapa: la especie a la izquierda y sus formas a la derecha.
/// Las formas ocupan como mucho el 60 % del ancho; si no caben, se
/// desplazan de lado.
class _StageRow extends StatelessWidget {
  const _StageRow({required this.stage, required this.section});

  final EvolutionStage stage;
  final EvolutionSection section;

  @override
  Widget build(BuildContext context) {
    final open = section.onOpenPokemon;
    final current = section.currentPokemonId;
    // La forma normal de una especie tiene el mismo id que la especie.
    final isCurrent = stage.speciesId == current;
    final forms = [
      for (final form in section.formsBySpecies[stage.speciesId] ?? const [])
        if (!form.isDefault) form,
    ];

    final tile = _StageTile(
      stage: stage,
      isCurrent: isCurrent,
      onTap: open == null || isCurrent ? null : () => open(stage.speciesId),
    );
    if (forms.isEmpty) return tile;

    final outline = Theme.of(context).colorScheme.outlineVariant;
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          Expanded(child: tile),
          const SizedBox(width: 8),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.6),
            child: Container(
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: outline)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 6,
                  children: [
                    for (final form in forms)
                      _FormTile(
                        label: DetailLabels.form(form, stage.name),
                        speciesName: DetailLabels.pretty(stage.name),
                        formId: form.id,
                        isCurrent: form.id == current,
                        onTap: open == null || form.id == current
                            ? null
                            : () => open(form.id),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Eslabon visible: sprite, nombre y requisito de una especie de la cadena.
class _StageTile extends StatelessWidget {
  const _StageTile({
    required this.stage,
    required this.isCurrent,
    required this.onTap,
  });

  final EvolutionStage stage;
  final bool isCurrent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final name = DetailLabels.pretty(stage.name);
    // La primera etapa no tiene requisito: su lista viene vacia.
    final method = stage.methods.isNotEmpty
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
              padding: const EdgeInsets.all(4),
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Miniatura de forma: sprite pequeno con el nombre corto debajo
/// ("Mega X", "Gigamax"). Tocarla abre el detalle de esa forma.
class _FormTile extends StatelessWidget {
  const _FormTile({
    required this.label,
    required this.speciesName,
    required this.formId,
    required this.isCurrent,
    required this.onTap,
  });

  final String label;
  final String speciesName;
  final int formId;
  final bool isCurrent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      button: onTap != null,
      selected: isCurrent,
      label: [
        'Forma $label de $speciesName',
        if (isCurrent) 'actual',
      ].join(', '),
      child: ExcludeSemantics(
        child: Material(
          color: isCurrent ? scheme.secondaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Column(
                  children: [
                    PokemonImage(
                      url: _spriteUrl(formId),
                      size: 36,
                      semanticLabel: 'Imagen de $label',
                      pixelated: true,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
