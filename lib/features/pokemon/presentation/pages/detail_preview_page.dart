import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';
import 'package:pokedex/features/pokemon/domain/entities/type_chart.dart';

import '../widgets/detail/pokemon_detail_view.dart';

/// Maqueta del detalle: muestra la vista completa con datos de prueba
/// escritos a mano, mientras el repositorio del detalle no esta conectado.
/// Solo se abre desde Ajustes en modo depuracion; se borra cuando la pagina
/// real lea el detalle de la base.
class DetailPreviewPage extends StatefulWidget {
  const DetailPreviewPage({super.key});

  @override
  State<DetailPreviewPage> createState() => _DetailPreviewPageState();
}

class _DetailPreviewPageState extends State<DetailPreviewPage> {
  var _id = 6;

  @override
  Widget build(BuildContext context) {
    final samples = _Samples.all;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista previa del detalle'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SegmentedButton<int>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: 6, label: Text('Charizard')),
                ButtonSegment(value: 133, label: Text('Eevee')),
                ButtonSegment(value: 10205, label: Text('Eevee gmax')),
              ],
              selected: {_id},
              onSelectionChanged: (s) => setState(() => _id = s.first),
            ),
          ),
        ),
      ),
      body: PokemonDetailView(
        key: ValueKey(_id),
        detail: samples[_id]!,
        typeChart: _Samples.typeChart,
        onOpenPokemon: (id) {
          if (samples.containsKey(id)) {
            setState(() => _id = id);
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('El #$id no está en los datos de prueba.'),
                ),
              );
          }
        },
      ),
    );
  }
}

/// Muestrario: Charizard (tipo doble, x4, megas) y Eevee (cadena con
/// ocho ramas, habilidad oculta y una gigamax sin movimientos).
abstract final class _Samples {
  static const _art =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/'
      'pokemon/other/official-artwork';
  static const _sprite =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/'
      'pokemon';

  static Pokemon _pokemon(
    int id,
    String name,
    int dex,
    List<(int, String)> t,
  ) => Pokemon(
    id: id,
    name: name,
    nationalDexNumber: dex,
    artworkUrl: '$_art/$id.png',
    spriteUrl: '$_sprite/$id.png',
    types: [
      for (var i = 0; i < t.length; i++)
        PokemonType(id: t[i].$1, name: t[i].$2, slot: i + 1),
    ],
  );

  static List<PokemonStat> _stats(List<int> values) {
    const names = [
      'hp',
      'attack',
      'defense',
      'special-attack',
      'special-defense',
      'speed',
    ];
    return [
      for (var i = 0; i < 6; i++)
        PokemonStat(id: i + 1, name: names[i], baseStat: values[i], effort: 0),
    ];
  }

  static PokemonMove _move(
    int id,
    String name,
    String es,
    MoveLearnMethod method,
    int level,
    int type,
    String damageClass, {
    int? power,
    int? accuracy,
    int? pp,
  }) => PokemonMove(
    id: id,
    name: name,
    nameEs: es,
    method: method,
    level: level,
    typeId: type,
    damageClass: damageClass,
    power: power,
    accuracy: accuracy,
    pp: pp,
  );

  static const _lv = MoveLearnMethod.levelUp;
  static const _mt = MoveLearnMethod.machine;
  static const _tutor = MoveLearnMethod.tutor;
  static const _egg = MoveLearnMethod.egg;

  static final charizard = PokemonDetail(
    pokemon: _pokemon(6, 'charizard', 6, [(10, 'fire'), (3, 'flying')]),
    isDefault: true,
    height: 17,
    weight: 905,
    generationId: 1,
    stats: _stats([78, 84, 78, 109, 85, 100]),
    abilities: const [
      PokemonAbility(
        id: 66,
        name: 'blaze',
        slot: 1,
        isHidden: false,
        nameEs: 'Mar Llamas',
        effectEs:
            'Potencia sus ataques de tipo Fuego cuando le quedan pocos PS.',
      ),
      PokemonAbility(
        id: 94,
        name: 'solar-power',
        slot: 3,
        isHidden: true,
        nameEs: 'Poder Solar',
        effectEs:
            'Con sol intenso sube su Ataque Especial, pero pierde PS en cada '
            'turno. Es una habilidad pensada para equipos que controlan el '
            'clima y quieren sacar el máximo partido a los ataques especiales.',
      ),
    ],
    moves: [
      _move(
        10,
        'scratch',
        'Arañazo',
        _lv,
        1,
        1,
        'physical',
        power: 40,
        accuracy: 100,
        pp: 35,
      ),
      _move(45, 'growl', 'Gruñido', _lv, 1, 1, 'status', accuracy: 100, pp: 40),
      _move(
        17,
        'wing-attack',
        'Ataque Ala',
        _lv,
        0,
        3,
        'physical',
        power: 60,
        accuracy: 100,
        pp: 35,
      ),
      _move(
        52,
        'ember',
        'Ascuas',
        _lv,
        4,
        10,
        'special',
        power: 40,
        accuracy: 100,
        pp: 25,
      ),
      _move(
        108,
        'smokescreen',
        'Pantalla de Humo',
        _lv,
        8,
        1,
        'status',
        accuracy: 100,
        pp: 20,
      ),
      _move(
        225,
        'dragon-breath',
        'Dragoaliento',
        _lv,
        12,
        16,
        'special',
        power: 60,
        accuracy: 100,
        pp: 20,
      ),
      _move(
        424,
        'fire-fang',
        'Colmillo Ígneo',
        _lv,
        19,
        10,
        'physical',
        power: 65,
        accuracy: 95,
        pp: 15,
      ),
      _move(
        163,
        'slash',
        'Cuchillada',
        _lv,
        24,
        1,
        'physical',
        power: 70,
        accuracy: 100,
        pp: 20,
      ),
      _move(
        53,
        'flamethrower',
        'Lanzallamas',
        _lv,
        30,
        10,
        'special',
        power: 90,
        accuracy: 100,
        pp: 15,
      ),
      _move(
        83,
        'fire-spin',
        'Giro Fuego',
        _lv,
        46,
        10,
        'special',
        power: 35,
        accuracy: 85,
        pp: 15,
      ),
      _move(
        394,
        'flare-blitz',
        'Envite Ígneo',
        _lv,
        62,
        10,
        'physical',
        power: 120,
        accuracy: 100,
        pp: 15,
      ),
      _move(
        89,
        'earthquake',
        'Terremoto',
        _mt,
        0,
        5,
        'physical',
        power: 100,
        accuracy: 100,
        pp: 10,
      ),
      _move(
        337,
        'dragon-claw',
        'Garra Dragón',
        _mt,
        0,
        16,
        'physical',
        power: 80,
        accuracy: 100,
        pp: 15,
      ),
      _move(
        257,
        'heat-wave',
        'Onda Ígnea',
        _mt,
        0,
        10,
        'special',
        power: 95,
        accuracy: 90,
        pp: 10,
      ),
      _move(
        307,
        'blast-burn',
        'Anillo Ígneo',
        _tutor,
        0,
        10,
        'special',
        power: 150,
        accuracy: 90,
        pp: 5,
      ),
      _move(349, 'dragon-dance', 'Danza Dragón', _egg, 0, 16, 'status', pp: 20),
    ],
    eggGroups: const ['monster', 'dragon'],
    forms: const [
      PokemonForm(id: 6, name: 'charizard', isDefault: true),
      PokemonForm(id: 10034, name: 'charizard-mega-x', isDefault: false),
      PokemonForm(id: 10035, name: 'charizard-mega-y', isDefault: false),
      PokemonForm(id: 10196, name: 'charizard-gmax', isDefault: false),
    ],
    evolutionChain: const EvolutionChain(
      stages: [
        EvolutionStage(
          speciesId: 4,
          name: 'charmander',
          evolvesFromId: null,
          methods: [],
        ),
        EvolutionStage(
          speciesId: 5,
          name: 'charmeleon',
          evolvesFromId: 4,
          methods: [EvolutionMethod(trigger: 'level-up', minLevel: 16)],
        ),
        EvolutionStage(
          speciesId: 6,
          name: 'charizard',
          evolvesFromId: 5,
          methods: [EvolutionMethod(trigger: 'level-up', minLevel: 36)],
        ),
      ],
    ),
  );

  static const _eeveeChain = EvolutionChain(
    stages: [
      EvolutionStage(
        speciesId: 133,
        name: 'eevee',
        evolvesFromId: null,
        methods: [],
      ),
      EvolutionStage(
        speciesId: 134,
        name: 'vaporeon',
        evolvesFromId: 133,
        methods: [EvolutionMethod(trigger: 'use-item', item: 'water-stone')],
      ),
      EvolutionStage(
        speciesId: 135,
        name: 'jolteon',
        evolvesFromId: 133,
        methods: [EvolutionMethod(trigger: 'use-item', item: 'thunder-stone')],
      ),
      EvolutionStage(
        speciesId: 136,
        name: 'flareon',
        evolvesFromId: 133,
        methods: [EvolutionMethod(trigger: 'use-item', item: 'fire-stone')],
      ),
      EvolutionStage(
        speciesId: 196,
        name: 'espeon',
        evolvesFromId: 133,
        methods: [
          EvolutionMethod(
            trigger: 'level-up',
            minHappiness: 160,
            timeOfDay: 'day',
          ),
        ],
      ),
      EvolutionStage(
        speciesId: 197,
        name: 'umbreon',
        evolvesFromId: 133,
        methods: [
          EvolutionMethod(
            trigger: 'level-up',
            minHappiness: 160,
            timeOfDay: 'night',
          ),
        ],
      ),
      EvolutionStage(
        speciesId: 470,
        name: 'leafeon',
        evolvesFromId: 133,
        methods: [EvolutionMethod(trigger: 'use-item', item: 'leaf-stone')],
      ),
      EvolutionStage(
        speciesId: 471,
        name: 'glaceon',
        evolvesFromId: 133,
        methods: [EvolutionMethod(trigger: 'use-item', item: 'ice-stone')],
      ),
      EvolutionStage(
        speciesId: 700,
        name: 'sylveon',
        evolvesFromId: 133,
        methods: [EvolutionMethod(trigger: 'level-up', minHappiness: 160)],
      ),
    ],
  );

  static const _eeveeForms = [
    PokemonForm(id: 133, name: 'eevee', isDefault: true),
    PokemonForm(id: 10205, name: 'eevee-gmax', isDefault: false),
  ];

  static const _eeveeAbilities = [
    PokemonAbility(
      id: 50,
      name: 'run-away',
      slot: 1,
      isHidden: false,
      nameEs: 'Fuga',
      effectEs: 'Puede escapar siempre de los Pokémon salvajes.',
    ),
    PokemonAbility(
      id: 91,
      name: 'adaptability',
      slot: 2,
      isHidden: false,
      nameEs: 'Adaptable',
      effectEs: 'Aumenta la potencia de los movimientos de su mismo tipo.',
    ),
    PokemonAbility(
      id: 107,
      name: 'anticipation',
      slot: 3,
      isHidden: true,
      nameEs: 'Anticipación',
      effectEs: 'Detecta si el rival tiene movimientos peligrosos.',
    ),
  ];

  static final eevee = PokemonDetail(
    pokemon: _pokemon(133, 'eevee', 133, [(1, 'normal')]),
    isDefault: true,
    height: 3,
    weight: 65,
    generationId: 1,
    stats: _stats([55, 55, 50, 45, 65, 55]),
    abilities: _eeveeAbilities,
    moves: [
      _move(
        33,
        'tackle',
        'Placaje',
        _lv,
        1,
        1,
        'physical',
        power: 40,
        accuracy: 100,
        pp: 35,
      ),
      _move(
        39,
        'tail-whip',
        'Látigo',
        _lv,
        1,
        1,
        'status',
        accuracy: 100,
        pp: 30,
      ),
      _move(
        28,
        'sand-attack',
        'Ataque Arena',
        _lv,
        5,
        5,
        'status',
        accuracy: 100,
        pp: 15,
      ),
      _move(
        98,
        'quick-attack',
        'Ataque Rápido',
        _lv,
        10,
        1,
        'physical',
        power: 40,
        accuracy: 100,
        pp: 30,
      ),
      _move(
        44,
        'bite',
        'Mordisco',
        _lv,
        20,
        17,
        'physical',
        power: 60,
        accuracy: 100,
        pp: 25,
      ),
      _move(
        36,
        'take-down',
        'Derribo',
        _lv,
        30,
        1,
        'physical',
        power: 90,
        accuracy: 85,
        pp: 20,
      ),
      _move(
        387,
        'last-resort',
        'Última Baza',
        _lv,
        45,
        1,
        'physical',
        power: 140,
        accuracy: 100,
        pp: 5,
      ),
      _move(
        38,
        'double-edge',
        'Doble Filo',
        _lv,
        50,
        1,
        'physical',
        power: 120,
        accuracy: 100,
        pp: 15,
      ),
      _move(
        247,
        'shadow-ball',
        'Bola Sombra',
        _mt,
        0,
        8,
        'special',
        power: 80,
        accuracy: 100,
        pp: 15,
      ),
      _move(273, 'wish', 'Deseo', _egg, 0, 1, 'status', pp: 10),
    ],
    eggGroups: const ['ground'],
    forms: _eeveeForms,
    evolutionChain: _eeveeChain,
  );

  /// Las gigamax no tienen movimientos en PokeAPI.
  static final eeveeGmax = PokemonDetail(
    pokemon: Pokemon(
      id: 10205,
      name: 'eevee-gmax',
      nationalDexNumber: 133,
      artworkUrl: '$_art/10205.png',
      spriteUrl: null,
      types: const [PokemonType(id: 1, name: 'normal', slot: 1)],
    ),
    isDefault: false,
    height: 180,
    weight: 0,
    generationId: 8,
    stats: _stats([55, 55, 50, 45, 65, 55]),
    abilities: _eeveeAbilities,
    moves: const [],
    eggGroups: const ['ground'],
    forms: _eeveeForms,
    evolutionChain: _eeveeChain,
  );

  static final all = {6: charizard, 133: eevee, 10205: eeveeGmax};

  /// Tabla de efectividad completa (solo lo que no es x1).
  static final typeChart = TypeChart(
    typeNames: const {
      1: 'normal',
      2: 'fighting',
      3: 'flying',
      4: 'poison',
      5: 'ground',
      6: 'rock',
      7: 'bug',
      8: 'ghost',
      9: 'steel',
      10: 'fire',
      11: 'water',
      12: 'grass',
      13: 'electric',
      14: 'psychic',
      15: 'ice',
      16: 'dragon',
      17: 'dark',
      18: 'fairy',
    },
    factors: const {
      1: {6: 50, 8: 0, 9: 50},
      2: {
        1: 200,
        15: 200,
        4: 50,
        3: 50,
        14: 50,
        7: 50,
        6: 200,
        8: 0,
        17: 200,
        9: 200,
        18: 50,
      },
      3: {13: 50, 12: 200, 2: 200, 7: 200, 6: 50, 9: 50},
      4: {12: 200, 4: 50, 5: 50, 6: 50, 8: 50, 9: 0, 18: 200},
      5: {10: 200, 13: 200, 12: 50, 4: 200, 3: 0, 7: 50, 6: 200, 9: 200},
      6: {10: 200, 15: 200, 2: 50, 5: 50, 3: 200, 7: 200, 9: 50},
      7: {
        10: 50,
        12: 200,
        2: 50,
        4: 50,
        3: 50,
        14: 200,
        8: 50,
        17: 200,
        9: 50,
        18: 50,
      },
      8: {1: 0, 14: 200, 8: 200, 17: 50},
      9: {10: 50, 11: 50, 13: 50, 15: 200, 6: 200, 9: 50, 18: 200},
      10: {10: 50, 11: 50, 12: 200, 15: 200, 7: 200, 6: 50, 16: 50, 9: 200},
      11: {10: 200, 11: 50, 12: 50, 5: 200, 6: 200, 16: 50},
      12: {
        10: 50,
        11: 200,
        12: 50,
        4: 50,
        5: 200,
        3: 50,
        7: 50,
        6: 200,
        16: 50,
        9: 50,
      },
      13: {11: 200, 13: 50, 12: 50, 5: 0, 3: 200, 16: 50},
      14: {2: 200, 4: 200, 14: 50, 17: 0, 9: 50},
      15: {10: 50, 11: 50, 12: 200, 15: 50, 5: 200, 3: 200, 16: 200, 9: 50},
      16: {16: 200, 9: 50, 18: 0},
      17: {2: 50, 14: 200, 8: 200, 17: 50, 18: 50},
      18: {10: 50, 2: 200, 4: 50, 16: 200, 17: 200, 9: 50},
    },
  );
}
