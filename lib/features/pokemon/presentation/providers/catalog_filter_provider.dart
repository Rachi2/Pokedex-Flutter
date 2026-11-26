import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_filter.dart';
import 'package:pokedex/features/pokemon/pokemon_providers.dart';

/// Filtro en pantalla: lo que muestra la barra del catalogo, al instante
/// (cada letra del buscador). La consulta no lo usa directo: usa
/// [appliedCatalogFilterProvider], que espera a que el usuario deje de
/// escribir.
///
/// Al crearse lee el filtro guardado en preferences, asi la busqueda, los
/// filtros y el orden siguen igual al volver a abrir la app.
final catalogFilterProvider =
    NotifierProvider<CatalogFilterNotifier, CatalogFilter>(
      CatalogFilterNotifier.new,
    );

/// Filtro aplicado: el que llega a la consulta de Drift. Cambia enseguida
/// con los filtros y el orden, y 400 ms despues de la ultima letra con la
/// busqueda.
final appliedCatalogFilterProvider =
    NotifierProvider<AppliedCatalogFilterNotifier, CatalogFilter>(
      AppliedCatalogFilterNotifier.new,
    );

/// Contador del aviso: cuantos Pokemon hay guardados en el telefono.
final catalogSavedCountProvider = StreamProvider<int>((ref) {
  return ref.watch(watchSavedCountProvider)();
});

/// Recibe los cambios de la barra, aplica el debounce y guarda el filtro.
class CatalogFilterNotifier extends Notifier<CatalogFilter> {
  /// Espera del buscador: cuanto se espera despues de la ultima letra antes
  /// de consultar (el rango pedido es de 300 a 500 ms). Asi escribir
  /// "pikachu" hace una consulta y no siete.
  static const searchDebounce = Duration(milliseconds: 400);

  Timer? _searchTimer;

  /// true cuando el usuario ya cambio algo: si el filtro guardado llega
  /// despues, no pisa lo que el usuario eligio.
  var _touched = false;

  @override
  CatalogFilter build() {
    ref.onDispose(() => _searchTimer?.cancel());
    _restore();
    return const CatalogFilter();
  }

  /// Recuperacion: lee el filtro guardado y lo aplica sin esperar.
  Future<void> _restore() async {
    final CatalogFilter saved;
    try {
      saved = await ref.read(rememberCatalogFilterProvider).load();
    } on Object {
      return; // Sin filtro guardado se queda el de por defecto.
    }
    if (!ref.mounted || _touched) return;
    state = saved;
    ref.read(appliedCatalogFilterProvider.notifier).apply(saved);
  }

  /// Cambio de la barra: se ve al momento; la consulta espera si solo
  /// cambio el texto del buscador.
  void update(CatalogFilter next) {
    if (next == state) return;
    _touched = true;

    final onlySearchChanged =
        next.query != state.query &&
        next.typeId == state.typeId &&
        next.generationId == state.generationId &&
        next.sort == state.sort &&
        next.descending == state.descending;
    state = next;

    _searchTimer?.cancel();
    if (onlySearchChanged && next.query.isNotEmpty) {
      _searchTimer = Timer(searchDebounce, () => _apply(next));
    } else {
      // Filtros, orden o buscador vaciado: sin espera.
      _apply(next);
    }
  }

  /// Quitar filtros: borra busqueda, tipo y generacion, pero deja el orden.
  void clear() {
    update(CatalogFilter(sort: state.sort, descending: state.descending));
  }

  /// Aplicar y recordar: pasa el filtro a la consulta y lo guarda. Si
  /// guardar falla, la busqueda sigue funcionando; solo no se recuerda.
  void _apply(CatalogFilter filter) {
    if (!ref.mounted) return;
    ref.read(appliedCatalogFilterProvider.notifier).apply(filter);
    ref.read(rememberCatalogFilterProvider).save(filter).ignore();
  }
}

/// Guarda el filtro que ya paso el debounce.
class AppliedCatalogFilterNotifier extends Notifier<CatalogFilter> {
  @override
  CatalogFilter build() => const CatalogFilter();

  void apply(CatalogFilter filter) => state = filter;
}
