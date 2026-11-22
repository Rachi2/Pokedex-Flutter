import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';

/// Rotulacion del detalle: traduce al espanol los nombres que PokeAPI manda
/// en ingles ("special-attack", "use-item"...). Es solo de presentacion; si
/// llega un nombre desconocido se muestra embellecido tal cual.
abstract final class DetailLabels {
  /// Nombre de PokeAPI en minusculas y con guiones -> "Special Attack".
  static String pretty(String apiName) => apiName
      .split('-')
      .where((part) => part.isNotEmpty)
      .map((part) => part[0].toUpperCase() + part.substring(1))
      .join(' ');

  static String stat(String apiName) => _stats[apiName] ?? pretty(apiName);

  /// Version corta para la columna de la barra.
  static String statShort(String apiName) =>
      _statsShort[apiName] ?? stat(apiName);

  static String eggGroup(String apiName) =>
      _eggGroups[apiName] ?? pretty(apiName);

  static String damageClass(String? apiName) =>
      _damageClasses[apiName] ?? (apiName == null ? '' : pretty(apiName));

  static String item(String apiName) => _items[apiName] ?? pretty(apiName);

  static String method(MoveLearnMethod method) => switch (method) {
    MoveLearnMethod.levelUp => 'Nivel',
    MoveLearnMethod.machine => 'MT',
    MoveLearnMethod.tutor => 'Tutor',
    MoveLearnMethod.egg => 'Huevo',
    MoveLearnMethod.other => 'Otros',
  };

  /// Generacion en numeros romanos, como en los juegos (I a IX).
  static String generation(int id) {
    const roman = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX'];
    return id >= 1 && id <= roman.length ? roman[id - 1] : '$id';
  }

  /// Nombre de una habilidad: espanol, ingles o el de PokeAPI embellecido.
  static String ability(PokemonAbility ability) =>
      ability.nameEs ?? ability.nameEn ?? pretty(ability.name);

  /// Nombre de un movimiento con la misma preferencia de idioma.
  static String move(PokemonMove move) =>
      move.nameEs ?? move.nameEn ?? pretty(move.name);

  /// Efecto en espanol (o ingles) recortado a 160 caracteres sin partir
  /// palabras.
  static String? abilityEffect(PokemonAbility ability) {
    final text = ability.effectEs ?? ability.effectEn;
    if (text == null || text.length <= 160) return text;
    final cut = text.substring(0, 159);
    final lastSpace = cut.lastIndexOf(' ');
    return '${cut.substring(0, lastSpace > 100 ? lastSpace : 159)}…';
  }

  /// Requisito para evolucionar en una frase corta: "Nivel 16",
  /// "Piedra Agua", "Amistad · de dia"...
  static String evolutionMethod(EvolutionMethod method) {
    final parts = <String>[];
    switch (method.trigger) {
      case 'level-up':
        if (method.minLevel != null) parts.add('Nivel ${method.minLevel}');
      case 'use-item':
        if (method.item != null) parts.add(item(method.item!));
      case 'trade':
        parts.add('Intercambio');
      default:
        parts.add(_triggers[method.trigger] ?? pretty(method.trigger));
    }
    if (method.heldItem != null) {
      parts.add('con ${item(method.heldItem!)}');
    }
    if (method.minHappiness != null) parts.add('Amistad');
    if (method.timeOfDay == 'day') parts.add('de día');
    if (method.timeOfDay == 'night') parts.add('de noche');
    if (parts.isEmpty) parts.add('Subir de nivel');
    return parts.join(' · ');
  }

  static const _stats = {
    'hp': 'PS',
    'attack': 'Ataque',
    'defense': 'Defensa',
    'special-attack': 'Ataque especial',
    'special-defense': 'Defensa especial',
    'speed': 'Velocidad',
  };

  static const _statsShort = {
    'special-attack': 'At. esp.',
    'special-defense': 'Def. esp.',
  };

  static const _eggGroups = {
    'monster': 'Monstruo',
    'water1': 'Agua 1',
    'water2': 'Agua 2',
    'water3': 'Agua 3',
    'bug': 'Bicho',
    'flying': 'Volador',
    'ground': 'Campo',
    'fairy': 'Hada',
    'plant': 'Planta',
    'humanshape': 'Humanoide',
    'mineral': 'Mineral',
    'indeterminate': 'Amorfo',
    'ditto': 'Ditto',
    'dragon': 'Dragón',
    'no-eggs': 'Desconocido',
  };

  static const _damageClasses = {
    'physical': 'Físico',
    'special': 'Especial',
    'status': 'Estado',
  };

  static const _triggers = {
    'shed': 'Muda',
    'spin': 'Girar',
    'tower-of-darkness': 'Torre de la Oscuridad',
    'tower-of-waters': 'Torre del Agua',
    'three-critical-hits': 'Tres golpes críticos',
    'take-damage': 'Recibir daño',
    'agile-style-move': 'Estilo rápido',
    'strong-style-move': 'Estilo fuerte',
    'recoil-damage': 'Daño de retroceso',
    'other': 'Condición especial',
  };

  static const _items = {
    'water-stone': 'Piedra Agua',
    'thunder-stone': 'Piedra Trueno',
    'fire-stone': 'Piedra Fuego',
    'leaf-stone': 'Piedra Hoja',
    'ice-stone': 'Piedra Hielo',
    'moon-stone': 'Piedra Lunar',
    'sun-stone': 'Piedra Solar',
    'shiny-stone': 'Piedra Día',
    'dusk-stone': 'Piedra Noche',
    'dawn-stone': 'Piedra Alba',
    'kings-rock': 'Roca del Rey',
    'metal-coat': 'Revestimiento Metálico',
    'dragon-scale': 'Escama Dragón',
    'up-grade': 'Mejora',
    'dubious-disc': 'Disco Extraño',
    'protector': 'Protector',
    'electirizer': 'Electrizador',
    'magmarizer': 'Magmatizador',
    'reaper-cloth': 'Tela Terrible',
    'razor-claw': 'Garra Afilada',
    'razor-fang': 'Colmillo Agudo',
    'oval-stone': 'Piedra Oval',
  };
}

/// Variocolor: el mismo Pokemon con las imagenes shiny. PokeAPI las guarda
/// en una carpeta "shiny" junto a las normales, asi que la URL se deriva.
extension PokemonShiny on Pokemon {
  Pokemon get shiny => Pokemon(
    id: id,
    name: name,
    nationalDexNumber: nationalDexNumber,
    artworkUrl: _shinyUrl(artworkUrl),
    spriteUrl: _shinyUrl(spriteUrl),
    types: types,
  );

  static String? _shinyUrl(String? url) {
    if (url == null) return null;
    final slash = url.lastIndexOf('/');
    return '${url.substring(0, slash + 1)}shiny/${url.substring(slash + 1)}';
  }
}
