import 'package:flutter/material.dart';

import '../../domain/entities/catalog_filter.dart';
import 'type_chip.dart';

/// Tipos para filtrar: id de PokeAPI y nombre en ingles (el que entiende
/// [TypeStyle]), en el orden de los juegos.
const catalogFilterTypes = <(int, String)>[
  (1, 'normal'),
  (10, 'fire'),
  (11, 'water'),
  (12, 'grass'),
  (13, 'electric'),
  (15, 'ice'),
  (2, 'fighting'),
  (4, 'poison'),
  (5, 'ground'),
  (3, 'flying'),
  (14, 'psychic'),
  (7, 'bug'),
  (6, 'rock'),
  (8, 'ghost'),
  (16, 'dragon'),
  (17, 'dark'),
  (9, 'steel'),
  (18, 'fairy'),
];

/// Generaciones: id de PokeAPI, numero romano y region.
const catalogFilterGenerations = <(int, String, String)>[
  (1, 'I', 'Kanto'),
  (2, 'II', 'Johto'),
  (3, 'III', 'Hoenn'),
  (4, 'IV', 'Sinnoh'),
  (5, 'V', 'Teselia'),
  (6, 'VI', 'Kalos'),
  (7, 'VII', 'Alola'),
  (8, 'VIII', 'Galar'),
  (9, 'IX', 'Paldea'),
];

/// Nombre en espanol de un tipo por su id, o null si no se conoce.
String? catalogTypeLabel(int typeId) {
  for (final (id, apiName) in catalogFilterTypes) {
    if (id == typeId) return TypeStyle.of(apiName).label;
  }
  return null;
}

/// Etiqueta corta de una generacion por su id («Gen. I · Kanto»).
String catalogGenerationLabel(int generationId) {
  for (final (id, roman, region) in catalogFilterGenerations) {
    if (id == generationId) return 'Gen. $roman · $region';
  }
  return 'Gen. $generationId';
}

/// Abre la hoja de filtros y devuelve el filtro elegido, o null si se
/// cerro sin aplicar. La busqueda y el orden se conservan tal cual.
Future<CatalogFilter?> showCatalogFilterSheet(
  BuildContext context,
  CatalogFilter filter,
) {
  return showModalBottomSheet<CatalogFilter>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => _FilterSheet(initial: filter),
  );
}

/// Hoja de filtros: un tipo y una generacion como maximo. Tocar el elegido
/// otra vez lo quita.
class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.initial});

  final CatalogFilter initial;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late int? _typeId = widget.initial.typeId;
  late int? _generationId = widget.initial.generationId;

  CatalogFilter get _result => CatalogFilter(
    query: widget.initial.query,
    typeId: _typeId,
    generationId: _generationId,
    sort: widget.initial.sort,
    descending: widget.initial.descending,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final titleStyle = theme.textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w700,
    );

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              children: [
                Text(
                  'Filtros',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Text('Tipo', style: titleStyle),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final (id, apiName) in catalogFilterTypes)
                      _typeChip(id, TypeStyle.of(apiName), brightness),
                  ],
                ),
                const SizedBox(height: 24),
                Text('Generación', style: titleStyle),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final (id, roman, region) in catalogFilterGenerations)
                      ChoiceChip(
                        label: Text('$roman · $region'),
                        selected: _generationId == id,
                        onSelected: (selected) => setState(
                          () => _generationId = selected ? id : null,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              children: [
                TextButton(
                  onPressed: _typeId == null && _generationId == null
                      ? null
                      : () => setState(() {
                          _typeId = null;
                          _generationId = null;
                        }),
                  child: const Text('Limpiar'),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(_result),
                  child: const Text('Aplicar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Chip de tipo con sus colores; seleccionado lleva borde y palomita.
  Widget _typeChip(int id, TypeStyle style, Brightness brightness) {
    final selected = _typeId == id;
    final foreground = style.foregroundFor(brightness);

    return FilterChip(
      label: Text(style.label),
      selected: selected,
      onSelected: (value) => setState(() => _typeId = value ? id : null),
      labelStyle: TextStyle(color: foreground, fontWeight: FontWeight.w600),
      checkmarkColor: foreground,
      backgroundColor: style.backgroundFor(brightness),
      selectedColor: style.backgroundFor(brightness),
      side: BorderSide(
        color: selected ? foreground : Colors.transparent,
        width: selected ? 2 : 1,
      ),
    );
  }
}
