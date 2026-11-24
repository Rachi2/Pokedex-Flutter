import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import 'pokemon_image.dart';
import 'pokemon_list_tile.dart';
import 'type_chip.dart';

/// Ficha de cuadricula: la vista en dos columnas del catalogo. Arriba la
/// imagen sobre el color del tipo principal, con el numero y una Pokeball
/// de marca de agua; abajo el nombre y los tipos.
class PokemonGridCard extends StatelessWidget {
  const PokemonGridCard({
    super.key,
    required this.pokemon,
    required this.onTap,
    this.trailing,
  });

  /// Altura de ficha: la cuadricula lo usa como `mainAxisExtent`
  /// para no medir cada una (igual que la lista con [PokemonListTile.height]).
  static const double height = 220;

  final Pokemon pokemon;
  final VoidCallback onTap;

  /// Lo que va en la esquina de la imagen (el corazon de favoritos).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final ink = pokemon.imageInk(theme);

    return Card(
      margin: const EdgeInsets.all(4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Semantics(
              button: true,
              label: pokemon.semanticSummary,
              onTap: onTap,
              excludeSemantics: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: pokemon.imageTint(theme),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -18,
                            bottom: -18,
                            child: SizedBox.square(
                              dimension: 96,
                              child: CustomPaint(
                                painter: _WatermarkPainter(
                                  ink.withValues(alpha: 0.12),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 8,
                            child: Text(
                              pokemon.dexLabel,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: ink,
                                fontWeight: FontWeight.w700,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: PokemonImage(
                                url: pokemon.imageUrl,
                                size: 96,
                                semanticLabel:
                                    'Imagen de ${pokemon.displayName}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pokemon.displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TypeChipStrip(types: pokemon.types),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              Positioned(
                top: 4,
                right: 4,
                child: DecoratedBox(
                  // Circulo claro detras del corazon para que se vea sobre
                  // cualquier color de tipo.
                  decoration: BoxDecoration(
                    color: scheme.surface.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: trailing,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Marca de agua: contorno de una Pokeball en un solo color.
class _WatermarkPainter extends CustomPainter {
  _WatermarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final stroke = size.width * 0.08;
    final radius = size.width / 2 - stroke / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = color;

    final button = radius * 0.3;
    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, button, paint);
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx - button, center.dy),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx + button, center.dy),
      Offset(center.dx + radius, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(_WatermarkPainter oldDelegate) =>
      oldDelegate.color != color;
}
