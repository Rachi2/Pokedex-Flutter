import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_type.dart';

/// Colores y nombre en español de un tipo. PokeAPI manda el nombre en
/// inglés ("grass"); la traducción es solo de presentación.
class TypeStyle {
  const TypeStyle(this.label, this.background, this.foreground);

  final String label;
  final Color background;
  final Color foreground;

  /// Busca el estilo de un tipo por su nombre de PokeAPI. Si llega un tipo
  /// desconocido se muestra con colores neutros y el nombre tal cual.
  static TypeStyle of(String apiName) =>
      _styles[apiName] ??
      TypeStyle(apiName, const Color(0xFFECE4E3), const Color(0xFF3A3030));

  // Fondo suave + texto oscuro: el contraste se mantiene en tema claro y
  // oscuro porque cada par se diseñó junto.
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
  const TypeChip({super.key, required this.type});

  final PokemonType type;

  @override
  Widget build(BuildContext context) {
    final style = TypeStyle.of(type.name);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        style.label,
        style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(color: style.foreground, fontWeight: FontWeight.w600),
      ),
    );
  }
}
