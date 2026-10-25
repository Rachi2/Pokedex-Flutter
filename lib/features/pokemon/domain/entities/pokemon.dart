import 'pokemon_type.dart';

class Pokemon {
  const Pokemon({
    required this.id,
    required this.name,
    required this.nationalDexNumber,
    required this.imageUrl,
    required this.types,
  });

  final int id;
  final String name;
  final int nationalDexNumber;

  /// URL del official artwork. Puede ser null si PokeAPI no la trae.
  final String? imageUrl;

  final List<PokemonType> types;

  @override
  bool operator ==(Object other) {
    if (other is! Pokemon) return false;
    if (other.id != id ||
        other.name != name ||
        other.nationalDexNumber != nationalDexNumber ||
        other.imageUrl != imageUrl ||
        other.types.length != types.length) {
      return false;
    }
    for (var i = 0; i < types.length; i++) {
      if (other.types[i] != types[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode =>
      Object.hash(id, name, nationalDexNumber, imageUrl, Object.hashAll(types));

  @override
  String toString() => 'Pokemon(#$nationalDexNumber $name)';
}
