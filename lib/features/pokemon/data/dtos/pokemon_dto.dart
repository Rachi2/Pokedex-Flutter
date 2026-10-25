/// Un tipo de un Pokemon tal como llega de PokeAPI.
class PokemonTypeDto {
  const PokemonTypeDto({
    required this.id,
    required this.name,
    required this.slot,
  });

  final int id;
  final String name;
  final int slot;

  /// Devuelve null si el tipo llega incompleto.
  static PokemonTypeDto? tryFromJson(Map<String, dynamic> json) {
    final slot = json['slot'];
    final type = json['type'];
    if (slot is! int || type is! Map<String, dynamic>) return null;

    final id = type['id'];
    final name = type['name'];
    if (id is! int || name is! String) return null;

    return PokemonTypeDto(id: id, name: name, slot: slot);
  }
}

/// Un Pokemon con la forma del JSON de PokeAPI.
class PokemonDto {
  const PokemonDto({
    required this.id,
    required this.name,
    required this.dexNumber,
    required this.artworkUrl,
    required this.spriteUrl,
    required this.types,
  });

  final int id;
  final String name;
  final int dexNumber;
  final String? artworkUrl;
  final String? spriteUrl;
  final List<PokemonTypeDto> types;

  /// Imagen a mostrar: el artwork oficial y, si no existe, el sprite normal.
  String? get imageUrl => artworkUrl ?? spriteUrl;

  /// Devuelve null si el registro llega sin id o sin nombre (OF-04).
  static PokemonDto? tryFromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    if (id is! int || name is! String || name.isEmpty) return null;

    final dexNumber = json['pokemon_species_id'];

    final types = <PokemonTypeDto>[];
    final rawTypes = json['pokemontypes'];
    if (rawTypes is List) {
      for (final rawType in rawTypes) {
        if (rawType is Map<String, dynamic>) {
          final type = PokemonTypeDto.tryFromJson(rawType);
          if (type != null) types.add(type);
        }
      }
    }

    String? artworkUrl;
    String? spriteUrl;
    final rawSprites = json['pokemonsprites'];
    if (rawSprites is List && rawSprites.isNotEmpty) {
      final sprites = rawSprites.first;
      if (sprites is Map<String, dynamic>) {
        final artwork = sprites['artwork'];
        final sprite = sprites['sprite'];
        if (artwork is String) artworkUrl = artwork;
        if (sprite is String) spriteUrl = sprite;
      }
    }

    return PokemonDto(
      id: id,
      name: name,
      dexNumber: dexNumber is int ? dexNumber : id,
      artworkUrl: artworkUrl,
      spriteUrl: spriteUrl,
      types: types,
    );
  }
}

/// Una pagina del catalogo: los Pokemon validos y el total en PokeAPI.
class CatalogPageDto {
  const CatalogPageDto({required this.pokemon, required this.totalCount});

  final List<PokemonDto> pokemon;
  final int totalCount;

  /// Recibe el campo "data" de la respuesta GraphQL.
  /// Lanza FormatException si la respuesta no tiene la lista de Pokemon.
  factory CatalogPageDto.fromJson(Map<String, dynamic> data) {
    final rawPokemon = data['pokemon'];
    if (rawPokemon is! List) {
      throw const FormatException('La respuesta no trae la lista pokemon');
    }

    final pokemon = <PokemonDto>[];
    for (final rawItem in rawPokemon) {
      if (rawItem is Map<String, dynamic>) {
        final dto = PokemonDto.tryFromJson(rawItem);
        if (dto != null) pokemon.add(dto);
      }
    }

    final aggregate = data['pokemon_aggregate']?['aggregate'];
    final count = aggregate is Map<String, dynamic> ? aggregate['count'] : null;

    return CatalogPageDto(
      pokemon: pokemon,
      totalCount: count is int ? count : 0,
    );
  }
}
