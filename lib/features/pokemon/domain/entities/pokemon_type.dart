/// Tipo con posicion: id, nombre en ingles y slot (1 principal, 2 secundario).
class PokemonType {
  const PokemonType({required this.id, required this.name, required this.slot})
    : assert(slot == 1 || slot == 2, 'slot debe ser 1 o 2');

  final int id;
  final String name;

  /// 1 es tipo principal y 2 es tipo secundario.
  final int slot;

  @override
  bool operator ==(Object other) =>
      other is PokemonType &&
      other.id == id &&
      other.name == name &&
      other.slot == slot;

  @override
  int get hashCode => Object.hash(id, name, slot);

  @override
  String toString() => 'PokemonType($id, $name, slot $slot)';
}
