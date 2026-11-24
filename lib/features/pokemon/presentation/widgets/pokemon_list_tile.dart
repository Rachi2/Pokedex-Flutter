import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import 'pokemon_image.dart';
import 'type_chip.dart';

/// Presentacion de datos: formato de un Pokémon para mostrarlo en pantalla.
/// También lo puede usar la página de detalle.
extension PokemonDisplay on Pokemon {
  /// Nombre bonito: PokeAPI lo manda en minúsculas ("bulbasaur", "mr-mime").
  String get displayName => name
      .split('-')
      .map(
        (part) =>
            part.isEmpty ? part : part[0].toUpperCase() + part.substring(1),
      )
      .join('-');

  /// Etiqueta de numero: Pokédex nacional con tres cifras (#001, #1025).
  String get dexLabel => '#${nationalDexNumber.toString().padLeft(3, '0')}';

  /// Tinte: fondo del cuadro de la imagen, el color del tipo principal.
  Color imageTint(ThemeData theme) => types.isEmpty
      ? theme.colorScheme.surfaceContainerHighest
      : TypeStyle.of(types.first.name).backgroundFor(theme.brightness);

  /// Tinta: color para lo que se dibuja encima de [imageTint].
  Color imageInk(ThemeData theme) => types.isEmpty
      ? theme.colorScheme.onSurfaceVariant
      : TypeStyle.of(types.first.name).foregroundFor(theme.brightness);

  /// Frase para el lector de pantalla: nombre, número y tipos.
  String get semanticSummary {
    final typeNames = types.map((t) => TypeStyle.of(t.name).label).join(' y ');
    return '$displayName, número $nationalDexNumber'
        '${typeNames.isEmpty ? '' : ', tipo $typeNames'}';
  }
}

/// Tarjeta de lista: imagen, nombre, número y tipos. Tocarla abre el detalle.
/// A la derecha va [trailing] (el corazón de favoritos) o, si no hay, una
/// flecha.
class PokemonListTile extends StatelessWidget {
  const PokemonListTile({
    super.key,
    required this.pokemon,
    required this.onTap,
    this.trailing,
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

  /// Lo que va a la derecha, con su propio toque y su propia etiqueta para
  /// el lector de pantalla.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final types = pokemon.types;

    return Card(
      margin: margin,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
          child: Row(
            children: [
              Expanded(
                // Una sola etiqueta para el lector de pantalla en vez de
                // leer cada pedazo por separado. El corazón queda fuera
                // para que se pueda tocar aparte.
                child: Semantics(
                  button: true,
                  label: pokemon.semanticSummary,
                  onTap: onTap,
                  excludeSemantics: true,
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
                            // Nombre y número en la misma línea, alineados
                            // por la base del texto aunque tengan distinto
                            // tamaño.
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Flexible(
                                  child: Text(
                                    pokemon.displayName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
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
                            TypeChipStrip(types: types),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              trailing ??
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Icons.chevron_right, color: scheme.outline),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
