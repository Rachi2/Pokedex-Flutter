/// Preferencia de juegos para los movimientos: version groups de PokeAPI en
/// el orden en que se buscan.
///
/// 25 Escarlata/Purpura, 23 Diamante Brillante/Perla Reluciente,
/// 20 Espada/Escudo, 18 Ultrasol/Ultraluna, 17 Sol/Luna, 16 Rubi Omega/
/// Zafiro Alfa, 15 X/Y y los anteriores. Se saltan los juegos con pocos
/// Pokemon o las versiones japonesas (12, 13, 19, 21, 22, 24 y 26 a 32).
/// Sin un filtro asi, un Pokemon como Charizard trae mas de 1500 filas.
const movesVersionGroupPreference = [
  25, 23, 20, 18, 17, 16, 15, 14, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, //
];

/// Eleccion del juego: el primero de la preferencia en el que el Pokemon
/// tiene movimientos. Si no aparece en ninguno, el de id mas alto que tenga;
/// si no tiene ninguno (por ejemplo, las formas gigamax), null.
int? pickMovesVersionGroup(Iterable<int> available) {
  if (available.isEmpty) return null;
  for (final versionGroup in movesVersionGroupPreference) {
    if (available.contains(versionGroup)) return versionGroup;
  }
  return available.reduce((a, b) => a > b ? a : b);
}

/// Inventario de juegos: en que version groups tiene movimientos un Pokemon.
/// Es una consulta chica que va antes de la del detalle.
const versionGroupsQuery = r'''
query PokemonVersionGroups($id: Int!) {
  pokemon(where: {id: {_eq: $id}}) {
    pokemonmoves(distinct_on: version_group_id) {
      version_group_id
    }
  }
}
''';

/// Consulta del detalle de un Pokemon (o de una de sus formas, por su id).
///
/// - Movimientos de un solo juego ($versionGroup), elegido con
///   [pickMovesVersionGroup].
/// - Nombres y efectos en espanol (7) e ingles (9), uno por idioma.
/// - El efecto de la habilidad es el flavor_text del juego mas reciente:
///   el efecto largo solo existe en ingles.
/// - La cadena evolutiva completa, con sus ramas (Eevee).
const pokemonDetailQuery = r'''
query PokemonDetail($id: Int!, $versionGroup: Int!) {
  pokemon(where: {id: {_eq: $id}}) {
    id
    name
    height
    weight
    is_default
    pokemon_species_id
    pokemontypes(order_by: {slot: asc}) {
      slot
      type {
        id
        name
      }
    }
    pokemonsprites {
      artwork: sprites(path: "other.official-artwork.front_default")
      sprite: sprites(path: "front_default")
    }
    pokemonstats {
      base_stat
      effort
      stat {
        id
        name
      }
    }
    pokemonabilities(order_by: {slot: asc}) {
      slot
      is_hidden
      ability {
        id
        name
        nameEs: abilitynames(where: {language_id: {_eq: 7}}, limit: 1) {
          name
        }
        nameEn: abilitynames(where: {language_id: {_eq: 9}}, limit: 1) {
          name
        }
        effectEs: abilityflavortexts(
          where: {language_id: {_eq: 7}}
          order_by: {version_group_id: desc}
          limit: 1
        ) {
          flavor_text
        }
        effectEn: abilityflavortexts(
          where: {language_id: {_eq: 9}}
          order_by: {version_group_id: desc}
          limit: 1
        ) {
          flavor_text
        }
      }
    }
    pokemonmoves(where: {version_group_id: {_eq: $versionGroup}}) {
      level
      movelearnmethod {
        name
      }
      move {
        id
        name
        power
        accuracy
        pp
        type_id
        movedamageclass {
          name
        }
        nameEs: movenames(where: {language_id: {_eq: 7}}, limit: 1) {
          name
        }
        nameEn: movenames(where: {language_id: {_eq: 9}}, limit: 1) {
          name
        }
      }
    }
    pokemonspecy {
      generation_id
      pokemonegggroups {
        egggroup {
          id
          name
        }
      }
      pokemons(order_by: {id: asc}) {
        id
        name
        is_default
      }
      evolutionchain {
        id
        pokemonspecies(order_by: {id: asc}) {
          id
          name
          evolves_from_species_id
          pokemonevolutions {
            id
            min_level
            min_happiness
            time_of_day
            evolutiontrigger {
              name
            }
            item {
              name
            }
            helditem: ItemByHeldItemId {
              name
            }
            location {
              name
            }
            move {
              name
            }
            type {
              name
            }
          }
        }
      }
    }
  }
}
''';

/// Matriz de efectividad: los 18 tipos con el multiplicador de dano contra
/// cada tipo defensor (0, 50, 100 o 200). Se descarga una sola vez.
const typeEfficacyQuery = r'''
query TypeEfficacy {
  type(where: {typeefficacies: {}}, order_by: {id: asc}) {
    id
    name
    typeefficacies {
      target_type_id
      damage_factor
    }
  }
}
''';
