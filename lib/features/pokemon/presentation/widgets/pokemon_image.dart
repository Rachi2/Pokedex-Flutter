import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Imagen de un Pokémon guardada en la caché de disco, para que se vea
/// también sin conexión.
///
/// - [size] es el lado del cuadrado donde se dibuja; con él se calcula
///   `memCacheWidth` para no decodificar un artwork de 475 px en un espacio
///   de 72 (RNF-REN-04).
/// - Si no hay URL, o no está en caché y no hay red, muestra el respaldo
///   "Imagen no disponible" (OF-08).
class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.url,
    required this.size,
    required this.semanticLabel,
  });

  final String? url;
  final double size;

  /// Lo que lee el lector de pantalla, p. ej. "Imagen de Bulbasaur".
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    if (url == null || url.isEmpty) {
      return _ImageFallback(size: size);
    }

    // Píxeles reales que ocupa la imagen en esta pantalla.
    final cacheWidth = (size * MediaQuery.devicePixelRatioOf(context)).round();

    return Semantics(
      label: semanticLabel,
      image: true,
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.contain,
        memCacheWidth: cacheWidth,
        fadeInDuration: const Duration(milliseconds: 150),
        placeholder: (_, _) => SizedBox.square(dimension: size),
        errorWidget: (_, _, _) => _ImageFallback(size: size),
      ),
    );
  }
}

/// Recuadro punteado con ícono. El texto solo aparece si hay espacio; en
/// tamaños pequeños el mensaje queda en la etiqueta de accesibilidad.
class _ImageFallback extends StatelessWidget {
  const _ImageFallback({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final showText = size >= 96;

    return Semantics(
      label: 'Imagen no disponible',
      image: true,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _DashedBorderPainter(color: scheme.outline),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                size: size * (showText ? 0.28 : 0.4),
                color: scheme.onSurfaceVariant,
              ),
              if (showText) ...[
                const SizedBox(height: 6),
                Text(
                  'Imagen no disponible',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(12),
    ).deflate(1);
    final path = Path()..addRRect(rect);

    // Recorre el contorno dibujando trazos de 4 px con huecos de 4 px.
    for (final metric in path.computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 8) {
        canvas.drawPath(metric.extractPath(d, d + 4), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color;
}
