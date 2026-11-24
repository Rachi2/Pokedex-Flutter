import 'pokemon.dart';

/// Aprendizaje: como se aprende un movimiento. La pantalla filtra por los
/// cuatro primeros; los demas metodos de PokeAPI quedan en [other].
enum MoveLearnMethod { levelUp, machine, tutor, egg, other }

/// Pilar del Pokemon: una de sus seis estadisticas base.
class PokemonStat {
  const PokemonStat({
    required this.id,
    required this.name,
    required this.baseStat,
    required this.effort,
  });

  final int id;

  /// hp, attack, defense, special-attack, special-defense o speed.
  final String name;

  /// De 1 a 255.
  final int baseStat;

  /// Puntos de esfuerzo que da al derrotarlo, de 0 a 3.
  final int effort;

  /// Proporcion respecto al maximo posible (255), para la barra del grafico.
  double get ratio => baseStat / 255;
}

/// Don del Pokemon: una de sus habilidades.
class PokemonAbility {
  const PokemonAbility({
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

  /// Nombre de PokeAPI ("overgrow"), por si falta la traduccion.
  final String name;
  final int slot;

  /// true en la habilidad oculta.
  final bool isHidden;
  final String? nameEs;
  final String? nameEn;
  final String? effectEs;
  final String? effectEn;
}

/// Tecnica que el Pokemon puede aprender.
class PokemonMove {
  const PokemonMove({
    required this.id,
    required this.name,
    required this.method,
    required this.level,
    this.nameEs,
    this.nameEn,
    this.power,
    this.accuracy,
    this.pp,
    this.typeId,
    this.damageClass,
  });

  final int id;
  final String name;
  final MoveLearnMethod method;

  /// Nivel en que se aprende; 0 cuando no aplica (MT, tutor, huevo).
  final int level;
  final String? nameEs;
  final String? nameEn;

  /// null en los movimientos de estado.
  final int? power;
  final int? accuracy;
  final int? pp;
  final int? typeId;

  /// physical, special o status.
  final String? damageClass;
}

/// Perfil de una forma de la especie: la normal, una mega, una gigamax...
class PokemonForm {
  const PokemonForm({
    required this.id,
    required this.name,
    required this.isDefault,
  });

  /// Id de PokeAPI de la forma; con el se abre su detalle.
  final int id;
  final String name;
  final bool isDefault;
}

/// Sendero para evolucionar: el disparador y sus condiciones.
class EvolutionMethod {
  const EvolutionMethod({
    required this.trigger,
    this.minLevel,
    this.minHappiness,
    this.timeOfDay,
    this.item,
    this.heldItem,
    this.location,
    this.knownMove,
    this.knownMoveType,
  });

  /// level-up, use-item, trade...
  final String trigger;
  final int? minLevel;
  final int? minHappiness;

  /// day o night.
  final String? timeOfDay;

  /// Objeto que se usa (piedra) o que lleva equipado.
  final String? item;
  final String? heldItem;

  /// Lugar donde sube de nivel (Leafeon, Glaceon).
  final String? location;

  /// Movimiento, o tipo de movimiento, que tiene que conocer (Ambipom,
  /// Sylveon).
  final String? knownMove;
  final String? knownMoveType;
}

/// Etapa de la cadena evolutiva: una especie y de cual evoluciona.
class EvolutionStage {
  const EvolutionStage({
    required this.speciesId,
    required this.name,
    required this.evolvesFromId,
    required this.methods,
  });

  final int speciesId;
  final String name;

  /// null en la primera etapa.
  final int? evolvesFromId;

  /// Como se llega a esta etapa; vacio en la primera.
  final List<EvolutionMethod> methods;
}

/// Familia evolutiva completa, con sus ramas.
class EvolutionChain {
  const EvolutionChain({required this.stages});

  final List<EvolutionStage> stages;

  /// false si la especie no evoluciona ni viene de otra ("No evoluciona").
  bool get evolves => stages.length > 1;

  /// Las etapas que no vienen de ninguna otra (normalmente una sola).
  List<EvolutionStage> get roots => [
    for (final stage in stages)
      if (stage.evolvesFromId == null) stage,
  ];

  /// Arbol de ramas: las etapas que evolucionan desde [speciesId].
  List<EvolutionStage> childrenOf(int speciesId) => [
    for (final stage in stages)
      if (stage.evolvesFromId == speciesId) stage,
  ];
}

/// Panorama completo de un Pokemon para la pagina de detalle.
class PokemonDetail {
  const PokemonDetail({
    required this.pokemon,
    required this.isDefault,
    required this.stats,
    required this.abilities,
    required this.moves,
    required this.eggGroups,
    required this.forms,
    this.height,
    this.weight,
    this.generationId,
    this.evolutionChain,
  });

  /// Lo basico: id, nombre, numero, imagenes y tipos.
  final Pokemon pokemon;

  /// false en las megas, gigamax y demas formas.
  final bool isDefault;

  /// En decimetros y hectogramos, como los manda PokeAPI.
  final int? height;
  final int? weight;
  final int? generationId;
  final List<PokemonStat> stats;
  final List<PokemonAbility> abilities;
  final List<PokemonMove> moves;
  final List<String> eggGroups;
  final List<PokemonForm> forms;
  final EvolutionChain? evolutionChain;

  /// Balance: la suma de las seis estadisticas base.
  int get totalBaseStats => stats.fold(0, (sum, stat) => sum + stat.baseStat);

  /// Altura en metros (7 decimetros -> 0.7 m).
  double? get heightMeters => height == null ? null : height! / 10;

  /// Peso en kilogramos (69 hectogramos -> 6.9 kg).
  double? get weightKilograms => weight == null ? null : weight! / 10;
}
