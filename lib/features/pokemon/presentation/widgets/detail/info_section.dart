import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';

import 'detail_labels.dart';
import 'detail_section.dart';

/// Ficha de datos: altura, peso, generacion, grupos huevo y formas.
class InfoSection extends StatelessWidget {
  const InfoSection({super.key, required this.detail, this.onOpenForm});

  final PokemonDetail detail;

  /// Al tocar una forma distinta de la actual. null = no se puede tocar.
  final ValueChanged<int>? onOpenForm;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final height = detail.heightMeters;
    final weight = detail.weightKilograms;
    final generation = detail.generationId;
    final eggGroups = detail.eggGroups.map(DetailLabels.eggGroup).join(', ');

    final rows = [
      ('Altura', height == null ? '—' : '${_decimal(height)} m'),
      ('Peso', weight == null ? '—' : '${_decimal(weight)} kg'),
      (
        'Generación',
        generation == null ? '—' : DetailLabels.generation(generation),
      ),
      ('Grupos huevo', eggGroups.isEmpty ? '—' : eggGroups),
    ];

    return DetailSection(
      title: 'Datos',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) Divider(height: 1, color: scheme.outlineVariant),
            _InfoRow(label: rows[i].$1, value: rows[i].$2),
          ],
          if (detail.forms.length > 1) ...[
            Divider(height: 1, color: scheme.outlineVariant),
            const SizedBox(height: 12),
            Text(
              'Formas',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final form in detail.forms)
                  ChoiceChip(
                    label: Text(_formLabel(form)),
                    selected: form.id == detail.pokemon.id,
                    onSelected:
                        onOpenForm == null || form.id == detail.pokemon.id
                        ? null
                        : (_) => onOpenForm!(form.id),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// "1.7" -> "1,7": coma decimal como se escribe en espanol.
  static String _decimal(double value) =>
      value.toStringAsFixed(1).replaceAll('.', ',');

  /// Nombre corto de la forma: sin el nombre de la especie delante
  /// ("charizard-mega-x" -> "Mega X"); la normal se llama «Normal».
  String _formLabel(PokemonForm form) {
    if (form.isDefault) return 'Normal';
    final species = detail.forms
        .where((f) => f.isDefault)
        .map((f) => f.name)
        .firstOrNull;
    final name = species != null && form.name.startsWith('$species-')
        ? form.name.substring(species.length + 1)
        : form.name;
    return DetailLabels.pretty(name.replaceAll('gmax', 'gigamax'));
  }
}

/// Renglon de dato: etiqueta a la izquierda y valor a la derecha.
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
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
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
