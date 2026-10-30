import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';

import '../datasources/pokemon_local_datasource.dart';
import '../dtos/pokemon_dto.dart';

/// Convierte entre las tres formas de un Pokemon:
/// PokemonDto (JSON de PokeAPI) -> filas de Drift -> entidad Pokemon.
///
/// Gracias a esto la pantalla nunca ve un DTO ni una fila de Drift.
class PokemonMapper {
  const PokemonMapper._();

  /// DTO -> filas de Drift, listas para PokemonLocalDataSource.upsertPage.
  static PokemonWithTypes toRows(
    PokemonDto dto, {
    required DateTime updatedAt,
  }) {
    return PokemonWithTypes(
      pokemon: PokemonRow(
        id: dto.id,
        dexNumber: dto.dexNumber,
        name: dto.name,
        spriteUrl: dto.spriteUrl,
        artworkUrl: dto.artworkUrl,
        updatedAt: updatedAt,
      ),
      types: [
        for (final type in dto.types)
          // La tabla pokemon_types solo acepta slot 1 o 2.
          if (type.slot == 1 || type.slot == 2)
            SlottedType(
              type: TypeRow(id: type.id, name: type.name),
              slot: type.slot,
            ),
      ],
    );
  }

  /// Filas de Drift -> entidad Pokemon que usa la capa de presentacion.
  static Pokemon toEntity(PokemonWithTypes rows) {
    final pokemon = rows.pokemon;
    return Pokemon(
      id: pokemon.id,
      name: pokemon.name,
      nationalDexNumber: pokemon.dexNumber,
      imageUrl: pokemon.artworkUrl ?? pokemon.spriteUrl,
      types: [
        for (final slotted in rows.types)
          PokemonType(
            id: slotted.type.id,
            name: slotted.type.name,
            slot: slotted.slot,
          ),
      ],
    );
  }
}
