import 'dart:math';

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
      appBar: AppBar(
        title: const _BrandTitle(),
        actions: [
          IconButton(
            tooltip: 'Actualizar catálogo',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.read(catalogProvider.notifier).refresh(),
          ),
          const SizedBox(width: 4),
        ],
      ),
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

/// Logo de la Pokéball + "Pokédex", como en el diseño aprobado.
class _BrandTitle extends StatelessWidget {
  const _BrandTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: 32,
          child: CustomPaint(
            painter: _PokeballPainter(outline: theme.colorScheme.onSurface),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Pokédex',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

/// Pokéball a color: mitad de arriba roja, de abajo blanca, franja y botón.
class _PokeballPainter extends CustomPainter {
  _PokeballPainter({required this.outline});

  final Color outline;

  static const _red = Color(0xFFC62839);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final stroke = size.width * 0.067;
    final radius = size.width / 2 - stroke / 2;
    final circle = Rect.fromCircle(center: center, radius: radius);

    final fill = Paint()..style = PaintingStyle.fill;
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = outline;

    // Mitades: arcos de 180° (pi). El de arriba empieza a la izquierda.
    canvas.drawArc(circle, pi, pi, true, fill..color = _red);
    canvas.drawArc(circle, 0, pi, true, fill..color = Colors.white);
    canvas.drawCircle(center, radius, line);

    // Franja del medio, cortada por el botón.
    final button = radius * 0.32;
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx - button, center.dy),
      line,
    );
    canvas.drawLine(
      Offset(center.dx + button, center.dy),
      Offset(center.dx + radius, center.dy),
      line,
    );
    canvas.drawCircle(center, button, fill..color = Colors.white);
    canvas.drawCircle(center, button, line);
  }

  @override
  bool shouldRepaint(_PokeballPainter oldDelegate) =>
      oldDelegate.outline != outline;
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
