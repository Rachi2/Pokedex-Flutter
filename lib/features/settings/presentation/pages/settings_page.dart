import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/network/api_outage_simulator.dart';
import '../../../pokemon/presentation/pages/detail_preview_page.dart';
import '../../../trivia/presentation/pages/trivia_preview_page.dart';

/// Tablero de ajustes. Por ahora solo trae, en modo depuracion, el
/// interruptor del simulador de API caida; el tema y el idioma se agregan
/// despues.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        if (kDebugMode) ...[
          const _SectionTitle('Depuración'),
          SwitchListTile(
            secondary: const Icon(Icons.cloud_off_outlined),
            title: const Text('Simular API caída'),
            subtitle: const Text(
              'Las consultas a PokeAPI fallan aunque haya red. Sirve para '
              'probar los reintentos y el estado «Servicio no disponible».',
            ),
            value: ref.watch(apiOutageSimulatorProvider),
            onChanged: (enabled) {
              ref.read(apiOutageSimulatorProvider.notifier).setEnabled(enabled);
              // El indicador comprueba la API cada 30 s; asi lo hace ya.
              ref.invalidate(serviceStatusProvider);
            },
          ),
          ListTile(
            leading: const Icon(Icons.preview_outlined),
            title: const Text('Vista previa del detalle'),
            subtitle: const Text(
              'Las secciones del detalle con datos de prueba, mientras el '
              'repositorio del detalle no está conectado.',
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const DetailPreviewPage(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.quiz_outlined),
            title: const Text('Vista previa de la trivia'),
            subtitle: const Text(
              'Una partida con datos de prueba, en español e inglés, mientras '
              'sus providers no están conectados.',
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const TriviaPreviewPage(),
              ),
            ),
          ),
          const Divider(),
        ],
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'El tema y el idioma se podrán elegir aquí próximamente.',
            style: textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

/// Titular de cada grupo de ajustes, en el color principal del tema.
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Semantics(
        header: true,
        child: Text(
          text,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
