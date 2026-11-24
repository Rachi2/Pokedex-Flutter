import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/entities/type_chart.dart';

import '../datasources/pokemon_detail_local_datasource.dart';
import '../datasources/pokemon_local_datasource.dart';
import '../dtos/pokemon_detail_dto.dart';
import 'pokemon_mapper.dart';

/// Interprete del detalle: pasa el detalle de PokemonDetailDto a las filas de
/// Drift, y de las filas a la entidad PokemonDetail. Hace lo mismo con la
/// tabla de efectividad de tipos.
class PokemonDetailMapper {
  const PokemonDetailMapper._();

  /// DTO -> filas, listas para PokemonDetailLocalDataSource.saveDetail.
  static PokemonDetailRows toRows(
    PokemonDetailDto dto, {
    required DateTime updatedAt,
  }) {
    final base = PokemonMapper.toRows(dto.pokemon, updatedAt: updatedAt);
    final pokemonId = dto.pokemon.id;
    final chainId = dto.evolutionChain?.id;

    return PokemonDetailRows(
      // El mapper del catalogo deja isDefault en true; aqui se corrige para
      // que las megas y gigamax no salgan en el catalogo.
      main: PokemonWithTypes(
        pokemon: base.pokemon.copyWith(isDefault: dto.isDefault),
        types: base.types,
      ),
      stats: [
        for (final stat in dto.stats)
          StatEntry(
            stat: StatRow(id: stat.id, name: stat.name),
            link: PokemonStatRow(
              pokemonId: pokemonId,
              statId: stat.id,
              baseStat: stat.baseStat,
              effort: stat.effort,
            ),
          ),
      ],
      abilities: [
        for (final ability in _uniqueBy(dto.abilities, (a) => a.slot))
          AbilityEntry(
            ability: AbilityRow(
              id: ability.id,
              name: ability.name,
              nameEs: ability.nameEs,
              nameEn: ability.nameEn,
              effectEs: ability.effectEs,
              effectEn: ability.effectEn,
            ),
            link: PokemonAbilityRow(
              pokemonId: pokemonId,
              abilityId: ability.id,
              slot: ability.slot,
              isHidden: ability.isHidden,
            ),
          ),
      ],
      moves: [
        // La clave de pokemon_moves es (Pokemon, metodo, nivel, movimiento):
        // si PokeAPI repite una fila, se guarda una sola vez.
        for (final move in _uniqueBy(
          dto.moves,
          (m) => '${m.method}|${m.level}|${m.id}',
        ))
          MoveEntry(
            move: MoveRow(
              id: move.id,
              name: move.name,
              nameEs: move.nameEs,
              nameEn: move.nameEn,
              typeId: move.typeId,
              power: move.power,
              accuracy: move.accuracy,
              pp: move.pp,
              damageClass: move.damageClass,
            ),
            link: PokemonMoveRow(
              pokemonId: pokemonId,
              moveId: move.id,
              method: move.method,
              level: move.level,
            ),
          ),
      ],
      eggGroups: [
        for (final group in dto.eggGroups)
          EggGroupRow(id: group.id, name: group.name),
      ],
      forms: [
        // Solo id, nombre y numero: saveDetail no borra lo que ya hubiera
        // guardado de esas formas (imagenes, tipos, altura...).
        for (final form in dto.forms)
          if (form.id != pokemonId)
            PokemonRow(
              id: form.id,
              dexNumber: dto.pokemon.dexNumber,
              name: form.name,
              isDefault: form.isDefault,
              updatedAt: updatedAt,
            ),
      ],
      chainSpecies: [
        if (chainId != null)
          for (final species in dto.evolutionChain!.species)
            EvolutionSpeciesRow(
              speciesId: species.id,
              chainId: chainId,
              evolvesFromId: species.evolvesFromId,
              name: species.name,
            ),
      ],
      chainMethods: [
        if (chainId != null)
          for (final species in dto.evolutionChain!.species)
            for (final method in species.methods)
              EvolutionMethodRow(
                id: method.id,
                speciesId: species.id,
                trigger: method.trigger,
                minLevel: method.minLevel,
                item: method.item,
                heldItem: method.heldItem,
                minHappiness: method.minHappiness,
                timeOfDay: method.timeOfDay,
                location: method.location,
                knownMove: method.knownMove,
                knownMoveType: method.knownMoveType,
              ),
      ],
    );
  }

  /// Filas -> entidad PokemonDetail que usa la pagina de detalle.
  static PokemonDetail toEntity(PokemonDetailRows rows) {
    final pokemon = rows.main.pokemon;
    final stats = [...rows.stats]
      ..sort((a, b) => a.stat.id.compareTo(b.stat.id));
    final abilities = [...rows.abilities]
      ..sort((a, b) => a.link.slot.compareTo(b.link.slot));
    final species = [...rows.chainSpecies]
      ..sort((a, b) => a.speciesId.compareTo(b.speciesId));

    return PokemonDetail(
      pokemon: PokemonMapper.toEntity(rows.main),
      isDefault: pokemon.isDefault,
      height: pokemon.height,
      weight: pokemon.weight,
      generationId: pokemon.generationId,
      stats: [
        for (final entry in stats)
          PokemonStat(
            id: entry.stat.id,
            name: entry.stat.name,
            baseStat: entry.link.baseStat,
            effort: entry.link.effort,
          ),
      ],
      abilities: [
        for (final entry in abilities)
          PokemonAbility(
            id: entry.ability.id,
            name: entry.ability.name,
            slot: entry.link.slot,
            isHidden: entry.link.isHidden,
            nameEs: entry.ability.nameEs,
            nameEn: entry.ability.nameEn,
            effectEs: entry.ability.effectEs,
            effectEn: entry.ability.effectEn,
          ),
      ],
      moves: [
        for (final entry in rows.moves)
          PokemonMove(
            id: entry.move.id,
            name: entry.move.name,
            method: learnMethodOf(entry.link.method),
            level: entry.link.level,
            nameEs: entry.move.nameEs,
            nameEn: entry.move.nameEn,
            power: entry.move.power,
            accuracy: entry.move.accuracy,
            pp: entry.move.pp,
            typeId: entry.move.typeId,
            damageClass: entry.move.damageClass,
          ),
      ],
      eggGroups: [for (final group in rows.eggGroups) group.name],
      forms: [
        for (final form in rows.forms)
          PokemonForm(id: form.id, name: form.name, isDefault: form.isDefault),
      ],
      evolutionChain: species.isEmpty
          ? null
          : EvolutionChain(
              stages: [
                for (final stage in species)
                  EvolutionStage(
                    speciesId: stage.speciesId,
                    name: stage.name,
                    evolvesFromId: stage.evolvesFromId,
                    methods: [
                      for (final method in rows.chainMethods)
                        if (method.speciesId == stage.speciesId)
                          EvolutionMethod(
                            trigger: method.trigger,
                            minLevel: method.minLevel,
                            minHappiness: method.minHappiness,
                            timeOfDay: method.timeOfDay,
                            item: method.item,
                            heldItem: method.heldItem,
                            location: method.location,
                            knownMove: method.knownMove,
                            knownMoveType: method.knownMoveType,
                          ),
                    ],
                  ),
              ],
            ),
    );
  }

  /// Equivalencia de metodos: el de PokeAPI -> MoveLearnMethod. Los raros
  /// quedan en other.
  static MoveLearnMethod learnMethodOf(String name) => switch (name) {
    'level-up' => MoveLearnMethod.levelUp,
    'machine' => MoveLearnMethod.machine,
    'tutor' => MoveLearnMethod.tutor,
    'egg' => MoveLearnMethod.egg,
    _ => MoveLearnMethod.other,
  };

  /// DTO de la tabla de efectividad -> filas para saveTypeChart.
  static TypeChartRows toTypeChartRows(TypeEfficacyTableDto dto) {
    return TypeChartRows(
      types: [
        for (final type in dto.types) TypeRow(id: type.id, name: type.name),
      ],
      efficacies: [
        for (final efficacy in dto.efficacies)
          TypeEfficacyRow(
            attackingTypeId: efficacy.attackingTypeId,
            defendingTypeId: efficacy.defendingTypeId,
            damageFactor: efficacy.damageFactor,
          ),
      ],
    );
  }

  /// Filas de la tabla de efectividad -> entidad TypeChart.
  static TypeChart toTypeChart(TypeChartRows rows) {
    final factors = <int, Map<int, int>>{};
    for (final row in rows.efficacies) {
      (factors[row.attackingTypeId] ??= {})[row.defendingTypeId] =
          row.damageFactor;
    }
    return TypeChart(
      typeNames: {for (final type in rows.types) type.id: type.name},
      factors: factors,
    );
  }

  /// Depurado de repetidos: se queda con el primero de cada clave.
  static List<T> _uniqueBy<T>(List<T> items, Object Function(T item) key) {
    final seen = <Object>{};
    return [
      for (final item in items)
        if (seen.add(key(item))) item,
    ];
  }
}
