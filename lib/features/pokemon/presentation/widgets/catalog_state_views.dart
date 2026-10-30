import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import 'pokemon_list_tile.dart';

/// Esqueletos con la misma forma que [PokemonListTile] mientras llega la
/// primera página. Así la pantalla no "salta" cuando aparecen los datos.
class LoadingView extends StatefulWidget {
  const LoadingView({super.key, this.itemCount = 8});

  final int itemCount;

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with SingleTickerProviderStateMixin {
  // Hace "respirar" a los esqueletos entre 50 % y 100 % de opacidad.
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
    lowerBound: 0.5,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Si el usuario pidió reducir animaciones, se quedan quietos.
    if (MediaQuery.disableAnimationsOf(context)) {
      _pulse.value = 1;
    } else if (!_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Semantics(
      label: 'Cargando catálogo',
      liveRegion: true,
      child: ExcludeSemantics(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 6),
              child: Row(
                children: [
                  Text(
                    'Catálogo',
                    style: muted?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text('Descargando la primera página…', style: muted),
                ],
              ),
            ),
            Expanded(
              child: FadeTransition(
                opacity: _pulse,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: PokemonListTile.height,
                  itemCount: widget.itemCount,
                  itemBuilder: (_, index) => _SkeletonTile(index: index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonTile extends StatelessWidget {
  const _SkeletonTile({required this.index});

  final int index;

  // Largos distintos para el nombre, así no parecen todas iguales.
  static const _nameWidths = [128.0, 96.0, 144.0, 112.0, 88.0, 120.0];

  @override
  Widget build(BuildContext context) {
    final block = Theme.of(context).colorScheme.surfaceContainerHighest;

    Widget bar(double width, double height, double radius) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: block,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    // Misma forma que PokemonListTile: cuadro de 64, nombre y dos chips.
    return Card(
      margin: PokemonListTile.margin,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            bar(64, 64, 14),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bar(_nameWidths[index % _nameWidths.length], 14, 7),
                const SizedBox(height: 10),
                Row(
                  children: [
                    bar(56, 20, 8),
                    const SizedBox(width: 6),
                    bar(56, 20, 8),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// No hay nada guardado todavía, p. ej. primera ejecución sin conexión.
class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.title = 'Aún no hay Pokémon guardados',
    this.message =
        'Conéctate a Internet para descargar el catálogo. '
        'Después podrás verlo sin conexión.',
    this.onRetry,
  });

  final String title;
  final String message;

  /// Si es null no se muestra el botón.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return _MessageView(
      icon: Icons.catching_pokemon,
      title: title,
      message: message,
      onRetry: onRetry,
    );
  }
}

/// Falló la carga y no hay datos que mostrar. Siempre ofrece Reintentar
/// (RF-CAT-04).
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.failure, required this.onRetry});

  final Failure failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    // Como Failure es sealed, el switch obliga a cubrir todos los tipos.
    final (icon, title) = switch (failure) {
      NetworkFailure() => (Icons.wifi_off_rounded, 'Sin conexión'),
      TimeoutFailure() => (Icons.hourglass_empty_rounded, 'Tiempo agotado'),
      ServerFailure() => (Icons.cloud_off_rounded, 'Servicio no disponible'),
      UnknownFailure() => (Icons.error_outline_rounded, 'Algo salió mal'),
    };

    return _MessageView(
      icon: icon,
      title: title,
      message: failure.message,
      onRetry: onRetry,
    );
  }
}

/// Diseño común de [EmptyView] y [ErrorView]: ícono, título, mensaje y botón.
class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.icon,
    required this.title,
    required this.message,
    this.onRetry,
  });

  final IconData icon;
  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: scheme.onSecondaryContainer),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Reintentar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
