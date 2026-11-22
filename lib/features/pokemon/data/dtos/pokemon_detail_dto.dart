import 'pokemon_dto.dart';

/// Atributo base de un Pokemon (hp, attack...), con sus puntos de esfuerzo.
class StatDto {
  const StatDto({
    required this.id,
    required this.name,
    required this.baseStat,
    required this.effort,
  });

  final int id;
  final String name;

  /// De 1 a 255.
  final int baseStat;

  /// De 0 a 3.
  final int effort;

  /// Devuelve null si falta un dato o esta fuera del rango que acepta la base.
  static StatDto? tryFromJson(Map<String, dynamic> json) {
    final baseStat = json['base_stat'];
    final effort = json['effort'];
    final stat = json['stat'];
    if (baseStat is! int || effort is! int || stat is! Map<String, dynamic>) {
      return null;
    }
    final id = stat['id'];
    final name = stat['name'];
    if (id is! int || name is! String) return null;
    if (baseStat < 1 || baseStat > 255 || effort < 0 || effort > 3) return null;
    return StatDto(id: id, name: name, baseStat: baseStat, effort: effort);
  }
}

/// Talento del Pokemon: una habilidad con su slot, nombre y efecto en
/// espanol e ingles.
class AbilityDto {
  const AbilityDto({
    required this.id,
    required this.name,
    required this.slot,
    required this.isHidden,
    this.nameEs,
    this.nameEn,
    this.effectEs,
    this.effectEn,
  });

  final int id;
  final String name;

  /// 1 y 2 las normales; 3 la oculta.
  final int slot;
  final bool isHidden;
  final String? nameEs;
  final String? nameEn;
  final String? effectEs;
  final String? effectEn;

  static AbilityDto? tryFromJson(Map<String, dynamic> json) {
    final slot = json['slot'];
    final ability = json['ability'];
    if (slot is! int || slot < 1 || slot > 3) return null;
    if (ability is! Map<String, dynamic>) return null;
    final id = ability['id'];
    final name = ability['name'];
    if (id is! int || name is! String) return null;
    return AbilityDto(
      id: id,
      name: name,
      slot: slot,
      isHidden: json['is_hidden'] == true,
      nameEs: _firstText(ability['nameEs'], 'name'),
      nameEn: _firstText(ability['nameEn'], 'name'),
      effectEs: _firstText(ability['effectEs'], 'flavor_text'),
      effectEn: _firstText(ability['effectEn'], 'flavor_text'),
    );
  }
}

/// Golpe aprendible: un movimiento con el metodo y el nivel en que se
/// aprende.
class MoveDto {
  const MoveDto({
    required this.id,
    required this.name,
    required this.method,
    required this.level,
    this.power,
    this.accuracy,
    this.pp,
    this.typeId,
    this.damageClass,
    this.nameEs,
    this.nameEn,
  });

  final int id;
  final String name;

  /// level-up, machine, tutor, egg u otros.
  final String method;

  /// De 0 a 100. Es 0 en MT, tutor, huevo y al evolucionar.
  final int level;

  /// null en los movimientos de estado.
  final int? power;
  final int? accuracy;
  final int? pp;
  final int? typeId;

  /// physical, special o status.
  final String? damageClass;
  final String? nameEs;
  final String? nameEn;

  static MoveDto? tryFromJson(Map<String, dynamic> json) {
    final level = json['level'];
    final method = json['movelearnmethod'];
    final move = json['move'];
    if (level is! int || level < 0 || level > 100) return null;
    if (method is! Map<String, dynamic> || move is! Map<String, dynamic>) {
      return null;
    }
    final methodName = method['name'];
    final id = move['id'];
    final name = move['name'];
    if (methodName is! String || id is! int || name is! String) return null;
    final damageClass = move['movedamageclass'];
    return MoveDto(
      id: id,
      name: name,
      method: methodName,
      level: level,
      power: _intOrNull(move['power']),
      accuracy: _intOrNull(move['accuracy']),
      pp: _intOrNull(move['pp']),
      typeId: _intOrNull(move['type_id']),
      damageClass: damageClass is Map<String, dynamic>
          ? _stringOrNull(damageClass['name'])
          : null,
      nameEs: _firstText(move['nameEs'], 'name'),
      nameEn: _firstText(move['nameEn'], 'name'),
    );
  }
}

/// Cria: un grupo huevo de la especie.
class EggGroupDto {
  const EggGroupDto({required this.id, required this.name});

  final int id;
  final String name;

  static EggGroupDto? tryFromJson(Map<String, dynamic> json) {
    final group = json['egggroup'];
    if (group is! Map<String, dynamic>) return null;
    final id = group['id'];
    final name = group['name'];
    if (id is! int || name is! String) return null;
    return EggGroupDto(id: id, name: name);
  }
}

/// Variante de la especie: la forma normal, una mega, una gigamax...
class FormDto {
  const FormDto({
    required this.id,
    required this.name,
    required this.isDefault,
  });

  /// Id de PokeAPI de esta forma; con el se pide su propio detalle.
  final int id;
  final String name;
  final bool isDefault;

  static FormDto? tryFromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    if (id is! int || name is! String) return null;
    return FormDto(id: id, name: name, isDefault: json['is_default'] == true);
  }
}

/// Requisito para evolucionar: el disparador y sus condiciones.
class EvolutionMethodDto {
  const EvolutionMethodDto({
    required this.id,
    required this.trigger,
    this.minLevel,
    this.minHappiness,
    this.timeOfDay,
    this.item,
    this.heldItem,
  });

  final int id;

  /// level-up, use-item, trade...
  final String trigger;
  final int? minLevel;
  final int? minHappiness;

  /// day, night o null. PokeAPI manda "" cuando no aplica.
  final String? timeOfDay;
  final String? item;
  final String? heldItem;

  static EvolutionMethodDto? tryFromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final trigger = json['evolutiontrigger'];
    if (id is! int || trigger is! Map<String, dynamic>) return null;
    final triggerName = trigger['name'];
    if (triggerName is! String) return null;
    final timeOfDay = json['time_of_day'];
    final item = json['item'];
    final heldItem = json['helditem'];
    return EvolutionMethodDto(
      id: id,
      trigger: triggerName,
      minLevel: _intOrNull(json['min_level']),
      minHappiness: _intOrNull(json['min_happiness']),
      timeOfDay: timeOfDay is String && timeOfDay.isNotEmpty ? timeOfDay : null,
      item: item is Map<String, dynamic> ? _stringOrNull(item['name']) : null,
      heldItem: heldItem is Map<String, dynamic>
          ? _stringOrNull(heldItem['name'])
          : null,
    );
  }
}

/// Eslabon de la cadena: una especie y de cual evoluciona.
class EvolutionSpeciesDto {
  const EvolutionSpeciesDto({
    required this.id,
    required this.name,
    required this.evolvesFromId,
    required this.methods,
  });

  final int id;
  final String name;

  /// null en la especie que empieza la cadena.
  final int? evolvesFromId;

  /// Puede tener varios: un metodo distinto segun el juego.
  final List<EvolutionMethodDto> methods;

  static EvolutionSpeciesDto? tryFromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    if (id is! int || name is! String) return null;
    return EvolutionSpeciesDto(
      id: id,
      name: name,
      evolvesFromId: _intOrNull(json['evolves_from_species_id']),
      methods: _parseList(
        json['pokemonevolutions'],
        EvolutionMethodDto.tryFromJson,
      ),
    );
  }
}

/// Linaje completo: la cadena evolutiva con todas sus ramas.
class EvolutionChainDto {
  const EvolutionChainDto({required this.id, required this.species});

  final int id;
  final List<EvolutionSpeciesDto> species;

  static EvolutionChainDto? tryFromJson(Map<String, dynamic> json) {
    final id = json['id'];
    if (id is! int) return null;
    return EvolutionChainDto(
      id: id,
      species: _parseList(
        json['pokemonspecies'],
        EvolutionSpeciesDto.tryFromJson,
      ),
    );
  }
}

/// Semblanza completa de un Pokemon, con la forma del JSON de la consulta
/// del detalle.
class PokemonDetailDto {
  const PokemonDetailDto({
    required this.pokemon,
    required this.isDefault,
    required this.stats,
    required this.abilities,
    required this.moves,
    required this.eggGroups,
    required this.forms,
    required this.evolutionChain,
  });

  /// Lo mismo que trae el catalogo: id, nombre, numero, imagenes, tipos,
  /// altura, peso y generacion.
  final PokemonDto pokemon;

  /// false en las megas, gigamax y demas formas.
  final bool isDefault;
  final List<StatDto> stats;
  final List<AbilityDto> abilities;
  final List<MoveDto> moves;
  final List<EggGroupDto> eggGroups;
  final List<FormDto> forms;
  final EvolutionChainDto? evolutionChain;

  /// Recibe el campo "data" de la respuesta GraphQL.
  ///
  /// Lanza FormatException si no llega el Pokemon o le falta el id o el
  /// nombre. Las piezas invalidas se descartan una por una, sin perder las
  /// demas.
  factory PokemonDetailDto.fromJson(Map<String, dynamic> data) {
    final list = data['pokemon'];
    if (list is! List || list.isEmpty || list.first is! Map<String, dynamic>) {
      throw const FormatException('La respuesta no trae el Pokemon');
    }
    final json = list.first as Map<String, dynamic>;
    final pokemon = PokemonDto.tryFromJson(json);
    if (pokemon == null) {
      throw const FormatException('El Pokemon llego sin id o sin nombre');
    }

    final species = json['pokemonspecy'];
    final speciesJson = species is Map<String, dynamic>
        ? species
        : const <String, dynamic>{};
    final chain = speciesJson['evolutionchain'];

    return PokemonDetailDto(
      pokemon: pokemon,
      isDefault: json['is_default'] != false,
      stats: _parseList(json['pokemonstats'], StatDto.tryFromJson),
      abilities: _parseList(json['pokemonabilities'], AbilityDto.tryFromJson),
      moves: _parseList(json['pokemonmoves'], MoveDto.tryFromJson),
      eggGroups: _parseList(
        speciesJson['pokemonegggroups'],
        EggGroupDto.tryFromJson,
      ),
      forms: _parseList(speciesJson['pokemons'], FormDto.tryFromJson),
      evolutionChain: chain is Map<String, dynamic>
          ? EvolutionChainDto.tryFromJson(chain)
          : null,
    );
  }
}

/// Multiplicador de dano de un tipo atacante contra un tipo defensor.
class TypeEfficacyDto {
  const TypeEfficacyDto({
    required this.attackingTypeId,
    required this.defendingTypeId,
    required this.damageFactor,
  });

  final int attackingTypeId;
  final int defendingTypeId;

  /// 0, 50, 100 o 200 (x0, x0.5, x1, x2).
  final int damageFactor;
}

/// Afinidad entre tipos: los 18 tipos y las 324 filas de efectividad.
class TypeEfficacyTableDto {
  const TypeEfficacyTableDto({required this.types, required this.efficacies});

  final List<PokemonTypeDto> types;
  final List<TypeEfficacyDto> efficacies;

  static const _validFactors = {0, 50, 100, 200};

  /// Recibe el campo "data" de la respuesta GraphQL.
  /// Lanza FormatException si no llega la lista de tipos.
  factory TypeEfficacyTableDto.fromJson(Map<String, dynamic> data) {
    final rawTypes = data['type'];
    if (rawTypes is! List) {
      throw const FormatException('La respuesta no trae la lista de tipos');
    }
    final types = <PokemonTypeDto>[];
    final efficacies = <TypeEfficacyDto>[];
    for (final rawType in rawTypes) {
      if (rawType is! Map<String, dynamic>) continue;
      final id = rawType['id'];
      final name = rawType['name'];
      if (id is! int || name is! String) continue;
      // El slot no aplica aqui; 1 es solo para reutilizar PokemonTypeDto.
      types.add(PokemonTypeDto(id: id, name: name, slot: 1));
      final rows = rawType['typeefficacies'];
      if (rows is! List) continue;
      for (final row in rows) {
        if (row is! Map<String, dynamic>) continue;
        final target = row['target_type_id'];
        final factor = row['damage_factor'];
        if (target is! int || factor is! int) continue;
        if (!_validFactors.contains(factor)) continue;
        efficacies.add(
          TypeEfficacyDto(
            attackingTypeId: id,
            defendingTypeId: target,
            damageFactor: factor,
          ),
        );
      }
    }
    return TypeEfficacyTableDto(types: types, efficacies: efficacies);
  }
}

/// Criba de listas: recorre una lista del JSON y se queda con los elementos
/// validos.
List<T> _parseList<T>(Object? raw, T? Function(Map<String, dynamic>) parse) {
  if (raw is! List) return [];
  return [
    for (final item in raw)
      if (item is Map<String, dynamic>) ?parse(item),
  ];
}

/// Cosecha de un alias de idioma: el texto del primer elemento, limpio.
String? _firstText(Object? raw, String field) {
  if (raw is! List || raw.isEmpty || raw.first is! Map<String, dynamic>) {
    return null;
  }
  return _cleanText((raw.first as Map<String, dynamic>)[field]);
}

/// Limpieza de los textos de los juegos: quita saltos de linea, guiones
/// blandos y espacios repetidos.
String? _cleanText(Object? raw) {
  if (raw is! String) return null;
  final text = raw
      // Guion blando (codigo AD) al final de linea: la palabra sigue en la
      // otra linea, asi que se pegan sin espacio.
      .replaceAll(RegExp(r'\xAD\s*'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  return text.isEmpty ? null : text;
}

int? _intOrNull(Object? raw) => raw is int ? raw : null;

String? _stringOrNull(Object? raw) => raw is String ? raw : null;
