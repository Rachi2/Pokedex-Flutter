import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';

import 'detail_labels.dart';
import 'detail_section.dart';

/// Lista de habilidades: nombre, marca «Oculta» y efecto corto de cada una,
/// en el orden de sus slots.
class AbilitiesSection extends StatelessWidget {
  const AbilitiesSection({super.key, required this.detail});

  final PokemonDetail detail;

  @override
  Widget build(BuildContext context) {
    final abilities = detail.abilities;

    return DetailSection(
      title: 'Habilidades',
      child: abilities.isEmpty
          ? const DetailEmptyNote('Sin habilidades registradas.')
          : Column(
              children: [
                for (var i = 0; i < abilities.length; i++) ...[
                  if (i > 0) const Divider(height: 20),
                  _AbilityTile(ability: abilities[i]),
                ],
              ],
            ),
    );
  }
}

/// Renglon de habilidad: nombre con su marca y el efecto debajo.
class _AbilityTile extends StatelessWidget {
  const _AbilityTile({required this.ability});

  final PokemonAbility ability;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final effect = DetailLabels.abilityEffect(ability);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              DetailLabels.ability(ability),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (ability.isHidden)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: scheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Oculta',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onTertiaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          effect ?? 'Sin descripción disponible.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
