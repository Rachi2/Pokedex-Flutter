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
}

/// Fila del catálogo: imagen, número, nombre y tipos. Tocarla abre el detalle.
class PokemonListTile extends StatelessWidget {
  const PokemonListTile({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  /// Alto fijo de cada fila. La lista lo usa como `itemExtent`, así no tiene
  /// que medir cada fila para saber dónde va el scroll.
  static const double height = 96;

  static const double _imageSize = 72;

  final Pokemon pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final types = pokemon.types;

    // El área de la imagen se tiñe con el color del tipo principal.
    final tint = types.isEmpty
        ? theme.colorScheme.surfaceContainerHighest
        : TypeStyle.of(types.first.name).background;

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
      child: SizedBox(
        height: height,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    width: _imageSize + 8,
                    height: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: tint,
                      borderRadius: BorderRadius.circular(12),
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
                        Text(
                          pokemon.dexLabel,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        Text(
                          pokemon.displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 6,
                          children: [for (final t in types) TypeChip(type: t)],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
