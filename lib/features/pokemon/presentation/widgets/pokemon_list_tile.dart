import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import 'pokemon_image.dart';
import 'type_chip.dart';

/// Formato de los datos de un Pokémon para mostrarlos en pantalla.
/// También lo puede usar la página de detalle.
extension PokemonDisplay on Pokemon {
  /// PokeAPI manda el nombre en minúsculas ("bulbasaur", "mr-mime").
  String get displayName => name
      .split('-')
      .map(
        (part) =>
            part.isEmpty ? part : part[0].toUpperCase() + part.substring(1),
      )
      .join('-');

  /// Número de la Pokédex nacional con tres cifras: #001, #025, #1025.
  String get dexLabel => '#${nationalDexNumber.toString().padLeft(3, '0')}';

  /// Fondo del cuadro de la imagen: el color del tipo principal.
  Color imageTint(ThemeData theme) => types.isEmpty
      ? theme.colorScheme.surfaceContainerHighest
      : TypeStyle.of(types.first.name).backgroundFor(theme.brightness);
}

/// Fila del catálogo: imagen, nombre, número y tipos. Tocarla abre el detalle.
class PokemonListTile extends StatelessWidget {
  const PokemonListTile({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  /// Alto fijo de cada fila (88 de tarjeta + 8 de separación). La lista lo
  /// usa como `itemExtent`, así no tiene que medir cada fila para saber
  /// dónde va el scroll.
  static const double height = 96;

  /// Margen de cada tarjeta; las filas grises de carga usan el mismo.
  static const EdgeInsets margin = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 4,
  );

  static const double _boxSize = 64;
  static const double _imageSize = 56;

  final Pokemon pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final types = pokemon.types;

    final typeNames = types.map((t) => TypeStyle.of(t.name).label).join(' y ');

    // Una sola etiqueta para el lector de pantalla en vez de leer cada
    // pedazo por separado.
    return Semantics(
      button: true,
      label:
          '${pokemon.displayName}, número ${pokemon.nationalDexNumber}'
          '${typeNames.isEmpty ? '' : ', tipo $typeNames'}',
      onTap: onTap,
      excludeSemantics: true,
      child: Card(
        margin: margin,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: _boxSize,
                  height: _boxSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: pokemon.imageTint(theme),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: PokemonImage(
                    url: pokemon.imageUrl,
                    size: _imageSize,
                    semanticLabel: 'Imagen de ${pokemon.displayName}',
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Nombre y número en la misma línea, alineados por la
                      // base del texto aunque tengan distinto tamaño.
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Flexible(
                            child: Text(
                              pokemon.displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            pokemon.dexLabel,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        children: [for (final t in types) TypeChip(type: t)],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: scheme.outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
