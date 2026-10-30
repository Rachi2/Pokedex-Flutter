/// Cantidad de Pokemon que se piden por pagina.
const catalogPageSize = 50;

/// Consulta del catalogo con paginacion por offset.
///
/// - Ordena por id para que las paginas siempre salgan en el mismo orden.
/// - Filtra is_default = true: solo la forma principal de cada especie
///   (sin megas ni formas regionales).
/// - pokemon_aggregate devuelve el total para saber cuantos hay en PokeAPI.
/// - De sprites solo se piden dos rutas del JSON: el artwork oficial
///   y el sprite normal como respaldo.
const catalogQuery = r'''
query Catalog($limit: Int!, $offset: Int!) {
  pokemon(
    limit: $limit
    offset: $offset
    order_by: {id: asc}
    where: {is_default: {_eq: true}}
  ) {
    id
    name
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
  }
  pokemon_aggregate(where: {is_default: {_eq: true}}) {
    aggregate {
      count
    }
  }
}
''';
