import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_type.dart';

/// Colores y nombre en español de un tipo. PokeAPI manda el nombre en
/// inglés ("grass"); la traducción es solo de presentación.
class TypeStyle {
  const TypeStyle(this.label, this._lightBackground, this._lightForeground);

  final String label;

  // Par del tema claro: fondo suave + texto oscuro del mismo tono.
  final Color _lightBackground;
  final Color _lightForeground;

  /// Busca el estilo de un tipo por su nombre de PokeAPI. Si llega un tipo
  /// desconocido se muestra con colores neutros y el nombre tal cual.
  static TypeStyle of(String apiName) =>
      _styles[apiName] ??
      TypeStyle(apiName, const Color(0xFFECE4E3), const Color(0xFF3A3030));

  /// Fondo del chip o del cuadro de la imagen según el tema.
  /// En oscuro se usa el tono del tipo apagado, para no encandilar.
  Color backgroundFor(Brightness brightness) => brightness == Brightness.dark
      ? Color.lerp(_lightForeground, darkSurface, 0.45)!
      : _lightBackground;

  /// Fondo del tema oscuro con el que se apagan los colores.
  static const darkSurface = Color(0xFF1A1111);

  /// Color del texto según el tema. En oscuro se invierte el par: el fondo
  /// claro pasa a ser el texto, así el contraste se mantiene.
  Color foregroundFor(Brightness brightness) =>
      brightness == Brightness.dark ? _lightBackground : _lightForeground;

  static const _styles = {
    'normal': TypeStyle('Normal', Color(0xFFEDE7DD), Color(0xFF4A4535)),
    'fire': TypeStyle('Fuego', Color(0xFFFFE1CF), Color(0xFF8A3608)),
    'water': TypeStyle('Agua', Color(0xFFD7E6FF), Color(0xFF1D4C96)),
    'grass': TypeStyle('Planta', Color(0xFFDDF0D2), Color(0xFF2B5A1B)),
    'electric': TypeStyle('Eléctrico', Color(0xFFFFF1BF), Color(0xFF6B5300)),
    'ice': TypeStyle('Hielo', Color(0xFFD6F2F2), Color(0xFF145656)),
    'fighting': TypeStyle('Lucha', Color(0xFFF7D9D5), Color(0xFF7D231B)),
    'poison': TypeStyle('Veneno', Color(0xFFF0DDF3), Color(0xFF682A78)),
    'ground': TypeStyle('Tierra', Color(0xFFF3E6CC), Color(0xFF6B4A12)),
    'flying': TypeStyle('Volador', Color(0xFFE5E3FA), Color(0xFF463C96)),
    'psychic': TypeStyle('Psíquico', Color(0xFFFDDCE8), Color(0xFF8A1F4B)),
    'bug': TypeStyle('Bicho', Color(0xFFE8F0C8), Color(0xFF4B5A10)),
    'rock': TypeStyle('Roca', Color(0xFFEDE5CF), Color(0xFF5E5022)),
    'ghost': TypeStyle('Fantasma', Color(0xFFE4DDF0), Color(0xFF45336B)),
    'dragon': TypeStyle('Dragón', Color(0xFFDDD9FB), Color(0xFF3A23A0)),
    'dark': TypeStyle('Siniestro', Color(0xFFE6DFDA), Color(0xFF3E3229)),
    'steel': TypeStyle('Acero', Color(0xFFE1E6EC), Color(0xFF3B4756)),
    'fairy': TypeStyle('Hada', Color(0xFFFBDDF1), Color(0xFF85246A)),
  };
}

/// Chip de un tipo: color de fondo + nombre escrito, para no depender solo
/// del color.
class TypeChip extends StatelessWidget {
  const TypeChip({super.key, required this.type, this.large = false});

  final PokemonType type;

  /// Versión más grande para la página de detalle.
  final bool large;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = TypeStyle.of(type.name);
    final textStyle = large
        ? theme.textTheme.labelLarge
        : theme.textTheme.labelMedium;

    return Container(
      padding: large
          ? const EdgeInsets.symmetric(horizontal: 14, vertical: 5)
          : const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: style.backgroundFor(theme.brightness),
        borderRadius: BorderRadius.circular(large ? 10 : 8),
      ),
      child: Text(
        style.label,
        style: textStyle?.copyWith(
          color: style.foregroundFor(theme.brightness),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
