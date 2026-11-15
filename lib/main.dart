import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

/// Punto de partida: envuelve la app en un ProviderScope, donde viven todos
/// los providers de Riverpod.
void main() {
  runApp(const ProviderScope(child: PokedexApp()));
}
