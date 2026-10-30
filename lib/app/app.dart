import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/pokemon_providers.dart';

import 'theme.dart';

class PokedexApp extends ConsumerStatefulWidget {
  const PokedexApp({super.key});

  @override
  ConsumerState<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends ConsumerState<PokedexApp> {
  @override
  void initState() {
    super.initState();
    // Arranca la sincronizacion sin await: la app abre de inmediato
    // y el catalogo se descarga en segundo plano (OF-03).
    ref.read(catalogSyncCoordinatorProvider).start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(title: const Text('Pokedex')),
        body: const Center(child: Text('Proyecto en construccion')),
      ),
    );
  }
}
