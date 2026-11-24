import 'package:flutter/material.dart';

/// Corazon animado: marca o desmarca un favorito. Al marcarlo late una vez
/// (crece y vuelve a su tamano); si el sistema pide menos animaciones, cambia
/// sin moverse.
///
/// Solo dibuja y avisa con [onPressed]: guardar el cambio es trabajo del
/// provider de favoritos.
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
    this.pokemonName,
    this.size = 24,
  });

  final bool isFavorite;
  final VoidCallback onPressed;

  /// Nombre para el lector de pantalla («Agregar Charizard a favoritos»).
  final String? pokemonName;

  /// Tamano del icono. El area tactil siempre es de 48 x 48 o mas.
  final double size;

  /// Rojo del corazon lleno, el mismo tono de la Pokeball de la cabecera.
  static const activeColor = Color(0xFFC62839);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 320),
  );

  /// Rebote del corazon: 1 -> 1.3 -> 1, con un pequeno rebote al final.
  late final _scale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween<double>(
        begin: 1,
        end: 1.3,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 40,
    ),
    TweenSequenceItem(
      tween: Tween<double>(
        begin: 1.3,
        end: 1,
      ).chain(CurveTween(curve: Curves.elasticOut)),
      weight: 60,
    ),
  ]).animate(_controller);

  @override
  void didUpdateWidget(FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Late solo cuando pasa a favorito, y aunque el cambio venga de otra
    // pantalla (el stream de la base actualiza todas a la vez).
    final justMarked = widget.isFavorite && !oldWidget.isFavorite;
    if (justMarked && !MediaQuery.disableAnimationsOf(context)) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final name = widget.pokemonName;
    final tooltip = widget.isFavorite
        ? 'Quitar${name == null ? '' : ' a $name'} de favoritos'
        : 'Agregar${name == null ? '' : ' a $name'} a favoritos';

    return IconButton(
      tooltip: tooltip,
      isSelected: widget.isFavorite,
      onPressed: widget.onPressed,
      // IconButton ya garantiza 48 x 48 de area tactil.
      icon: ScaleTransition(
        scale: _scale,
        child: Icon(
          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
          size: widget.size,
          color: widget.isFavorite
              ? FavoriteButton.activeColor
              : scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
