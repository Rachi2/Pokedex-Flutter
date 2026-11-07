import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import 'pokemon_image.dart';
import 'pokemon_list_tile.dart';

/// Cuadro grande del detalle, teñido con el color del tipo principal.
/// Deslizando se pasa del artwork oficial al arte en píxeles (sprite).
///
/// Si el Pokémon solo tiene una imagen no hay nada que deslizar: se muestra
/// esa, o el respaldo "Imagen no disponible" si no tiene ninguna.
class PokemonArtCarousel extends StatefulWidget {
  const PokemonArtCarousel({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  State<PokemonArtCarousel> createState() => _PokemonArtCarouselState();
}

class _PokemonArtCarouselState extends State<PokemonArtCarousel> {
  static const double _boxHeight = 300;
  static const double _imageSize = 240;

  final _controller = PageController();
  var _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pokemon = widget.pokemon;
    final name = pokemon.displayName;
    final artworkUrl = pokemon.artworkUrl;
    final spriteUrl = pokemon.spriteUrl;

    final pages = [
      if (artworkUrl != null)
        _ArtPage(
          label: 'Artwork',
          semanticLabel: 'Imagen oficial de $name',
          url: artworkUrl,
          pixelated: false,
        ),
      if (spriteUrl != null)
        _ArtPage(
          label: 'Píxel',
          semanticLabel: 'Arte en píxeles de $name',
          url: spriteUrl,
          pixelated: true,
        ),
    ];

    return Container(
      height: _boxHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: pokemon.imageTint(theme),
        borderRadius: BorderRadius.circular(28),
      ),
      child: pages.length < 2
          ? Center(
              child: _buildImage(
                pages.isEmpty
                    ? _ArtPage(
                        label: '',
                        semanticLabel: 'Imagen de $name',
                        url: null,
                        pixelated: false,
                      )
                    : pages.first,
              ),
            )
          : Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  // Construye también la página vecina: así el sprite se
                  // descarga al abrir el detalle y queda guardado para verlo
                  // sin conexión, aunque el usuario no haya deslizado.
                  allowImplicitScrolling: true,
                  itemCount: pages.length,
                  onPageChanged: (page) => setState(() => _page = page),
                  itemBuilder: (_, index) =>
                      Center(child: _buildImage(pages[index])),
                ),
                // IgnorePointer: un dedo que empieza encima de la etiqueta o
                // de los puntos también debe poder deslizar la imagen.
                Positioned.fill(
                  child: IgnorePointer(
                    child: _PageOverlay(
                      label: pages[_page].label,
                      page: _page,
                      pageCount: pages.length,
                      color: pokemon.imageInk(theme),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildImage(_ArtPage page) => PokemonImage(
    url: page.url,
    size: _imageSize,
    semanticLabel: page.semanticLabel,
    pixelated: page.pixelated,
  );
}

class _ArtPage {
  const _ArtPage({
    required this.label,
    required this.semanticLabel,
    required this.url,
    required this.pixelated,
  });

  final String label;
  final String semanticLabel;
  final String? url;
  final bool pixelated;
}

/// Lo que se dibuja encima de la imagen: cuál es (arriba) y los puntos (abajo).
class _PageOverlay extends StatelessWidget {
  const _PageOverlay({
    required this.label,
    required this.page,
    required this.pageCount,
    required this.color,
  });

  final String label;
  final int page;
  final int pageCount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final animate = !MediaQuery.disableAnimationsOf(context);

    return Semantics(
      label: 'Imagen ${page + 1} de $pageCount: $label',
      hint: 'Desliza para cambiar de imagen',
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium
                    ?.copyWith(color: color, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < pageCount; i++)
                    AnimatedContainer(
                      duration: animate
                          ? const Duration(milliseconds: 200)
                          : Duration.zero,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == page ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == page ? color : color.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
