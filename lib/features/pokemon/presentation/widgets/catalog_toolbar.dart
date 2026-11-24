import 'package:flutter/material.dart';

import '../../domain/entities/catalog_filter.dart';
import 'catalog_filter_sheet.dart';

/// Forma de mostrar el catalogo: filas o fichas en dos columnas.
enum CatalogLayout { list, grid }

/// Nombre en pantalla de cada orden.
extension CatalogSortLabel on CatalogSort {
  String get label => switch (this) {
    CatalogSort.number => 'Número',
    CatalogSort.name => 'Nombre',
    CatalogSort.type => 'Tipo',
    CatalogSort.baseStatTotal => 'Total base',
  };
}

/// Mando del catalogo: buscador, filtros, orden, vista lista/cuadricula,
/// los filtros activos y el aviso de catalogo incompleto.
///
/// No guarda nada: muestra [filter] y avisa cada cambio. El provider del
/// catalogo aplica el debounce de la busqueda y recuerda el filtro entre
/// sesiones.
class CatalogToolbar extends StatefulWidget {
  const CatalogToolbar({
    super.key,
    required this.filter,
    required this.onFilterChanged,
    required this.layout,
    required this.onLayoutChanged,
    this.savedCount,
    this.totalCount,
  });

  final CatalogFilter filter;

  /// Se llama con el filtro completo cada vez que cambia algo, incluida
  /// cada letra del buscador.
  final ValueChanged<CatalogFilter> onFilterChanged;

  final CatalogLayout layout;
  final ValueChanged<CatalogLayout> onLayoutChanged;

  /// Pokemon guardados y total en PokeAPI. Si faltan Pokemon por guardar,
  /// se muestra el aviso de catalogo incompleto.
  final int? savedCount;
  final int? totalCount;

  @override
  State<CatalogToolbar> createState() => _CatalogToolbarState();
}

class _CatalogToolbarState extends State<CatalogToolbar> {
  late final _searchController = TextEditingController(
    text: widget.filter.query,
  );

  @override
  void didUpdateWidget(CatalogToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si el filtro cambia desde fuera (al abrir la app con el filtro
    // guardado, o con «Quitar filtros»), el buscador lo refleja.
    if (widget.filter.query != _searchController.text) {
      _searchController.text = widget.filter.query;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Copia del filtro con lo que cambia. Se arma con el constructor para
  /// poder poner un campo en null (quitar el tipo o la generacion).
  CatalogFilter _copy({
    String? query,
    int? Function()? typeId,
    int? Function()? generationId,
    CatalogSort? sort,
    bool? descending,
  }) {
    final f = widget.filter;
    return CatalogFilter(
      query: query ?? f.query,
      typeId: typeId == null ? f.typeId : typeId(),
      generationId: generationId == null ? f.generationId : generationId(),
      sort: sort ?? f.sort,
      descending: descending ?? f.descending,
    );
  }

  Future<void> _openFilters() async {
    final result = await showCatalogFilterSheet(context, widget.filter);
    if (result != null) widget.onFilterChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final filter = widget.filter;
    final typeId = filter.typeId;
    final generationId = filter.generationId;
    final activeFilters =
        (typeId == null ? 0 : 1) + (generationId == null ? 0 : 1);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _searchController,
            onChanged: (text) => widget.onFilterChanged(_copy(query: text)),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Buscar por nombre',
              prefixIcon: const Icon(Icons.search_rounded),
              // El boton de borrar aparece solo si hay texto.
              suffixIcon: ValueListenableBuilder(
                valueListenable: _searchController,
                builder: (context, value, _) => value.text.isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        tooltip: 'Borrar búsqueda',
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          _searchController.clear();
                          widget.onFilterChanged(_copy(query: ''));
                        },
                      ),
              ),
              filled: true,
              fillColor: scheme.surfaceContainerHigh,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Badge(
                isLabelVisible: activeFilters > 0,
                label: Text('$activeFilters'),
                child: OutlinedButton.icon(
                  onPressed: _openFilters,
                  icon: const Icon(Icons.tune_rounded, size: 18),
                  label: const Text('Filtros'),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: _SortMenu(filter: filter, onChanged: _sortTo),
              ),
              const Spacer(),
              // Un solo boton que alterna: muestra la vista a la que cambia.
              if (widget.layout == CatalogLayout.grid)
                IconButton(
                  tooltip: 'Ver en lista',
                  icon: const Icon(Icons.view_list_rounded),
                  onPressed: () => widget.onLayoutChanged(CatalogLayout.list),
                )
              else
                IconButton(
                  tooltip: 'Ver en cuadrícula',
                  icon: const Icon(Icons.grid_view_rounded),
                  onPressed: () => widget.onLayoutChanged(CatalogLayout.grid),
                ),
            ],
          ),
          if (activeFilters > 0) ...[
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: [
                if (typeId != null)
                  InputChip(
                    label: Text(catalogTypeLabel(typeId) ?? 'Tipo $typeId'),
                    onDeleted: () =>
                        widget.onFilterChanged(_copy(typeId: () => null)),
                    deleteButtonTooltipMessage: 'Quitar filtro de tipo',
                  ),
                if (generationId != null)
                  InputChip(
                    label: Text(catalogGenerationLabel(generationId)),
                    onDeleted: () =>
                        widget.onFilterChanged(_copy(generationId: () => null)),
                    deleteButtonTooltipMessage: 'Quitar filtro de generación',
                  ),
              ],
            ),
          ],
          _PartialCatalogNote(
            saved: widget.savedCount,
            total: widget.totalCount,
          ),
        ],
      ),
    );
  }

  /// Elegir el mismo orden otra vez invierte el sentido.
  void _sortTo(CatalogSort sort) {
    final filter = widget.filter;
    widget.onFilterChanged(
      sort == filter.sort
          ? _copy(descending: !filter.descending)
          : _copy(sort: sort, descending: sort == CatalogSort.baseStatTotal),
    );
  }
}

/// Menu de orden: muestra el orden actual con una flecha del sentido.
class _SortMenu extends StatelessWidget {
  const _SortMenu({required this.filter, required this.onChanged});

  final CatalogFilter filter;
  final ValueChanged<CatalogSort> onChanged;

  @override
  Widget build(BuildContext context) {
    final arrow = filter.descending
        ? Icons.arrow_downward_rounded
        : Icons.arrow_upward_rounded;
    final direction = filter.descending ? 'descendente' : 'ascendente';

    return MenuAnchor(
      menuChildren: [
        for (final sort in CatalogSort.values)
          MenuItemButton(
            leadingIcon: sort == filter.sort
                ? Icon(arrow, size: 18)
                : const SizedBox(width: 18),
            onPressed: () => onChanged(sort),
            child: Text(sort.label),
          ),
      ],
      builder: (context, controller, _) => Semantics(
        label: 'Ordenar por ${filter.sort.label}, $direction',
        excludeSemantics: true,
        button: true,
        // Row propia en vez de TextButton.icon, para que el texto se
        // recorte si no cabe.
        child: TextButton(
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(arrow, size: 18),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  filter.sort.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Aviso de catalogo incompleto: las busquedas y filtros solo ven lo que
/// esta guardado en el telefono.
class _PartialCatalogNote extends StatelessWidget {
  const _PartialCatalogNote({required this.saved, required this.total});

  final int? saved;
  final int? total;

  @override
  Widget build(BuildContext context) {
    final saved = this.saved;
    final total = this.total;
    if (saved == null || total == null || saved >= total) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 16, color: muted),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              '$saved de $total guardados: la búsqueda y los filtros solo '
              'ven los guardados.',
              style: theme.textTheme.bodySmall?.copyWith(color: muted),
            ),
          ),
        ],
      ),
    );
  }
}

/// Sin resultados: hay Pokemon guardados, pero ninguno pasa el filtro.
class NoResultsView extends StatelessWidget {
  const NoResultsView({super.key, required this.onClear});

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'Ningún Pokémon coincide',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Prueba con otro nombre o quita algún filtro.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: onClear,
              child: const Text('Quitar filtros'),
            ),
          ],
        ),
      ),
    );
  }
}
