import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/connectivity/presentation/widgets/connectivity_indicator.dart';
import 'package:pokedex/features/pokemon/presentation/pages/catalog_page.dart';
import 'package:pokedex/features/pokemon/presentation/providers/catalog_provider.dart';

/// Marco de las pantallas principales: el indicador de conectividad fijo
/// arriba (IND-01) y la barra de navegacion inferior.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final syncStatus = ref.watch(catalogSyncStatusProvider).value;

    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: Column(
        children: [
          ConnectivityIndicator(syncStatus: syncStatus),
          Expanded(
            // IndexedStack mantiene cada pestaña viva al cambiar de una a otra,
            // asi el catalogo no pierde la posicion del scroll.
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                CatalogPage(),
                _ComingSoon(title: 'Favoritos'),
                _ComingSoon(title: 'Ajustes'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.catching_pokemon_outlined),
            selectedIcon: Icon(Icons.catching_pokemon),
            label: 'Catálogo',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}

/// Pestaña que todavia no existe en el avance.
class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.construction_outlined, size: 48),
          const SizedBox(height: 12),
          Text(title, style: textTheme.titleMedium),
          const SizedBox(height: 4),
          Text('Próximamente', style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
