import 'package:flutter/material.dart';
import 'package:pokedex/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:pokedex/features/favorites/presentation/widgets/favorites_view.dart';
import 'package:pokedex/features/pokemon/domain/entities/catalog_filter.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';

import '../widgets/catalog_toolbar.dart';
import '../widgets/pokemon_grid_card.dart';
import '../widgets/pokemon_list_tile.dart';

/// Ensayo del catalogo: buscador, filtros, orden, lista/cuadricula y
/// favoritos con datos de prueba, mientras los providers no estan
/// conectados. Filtra en memoria imitando la consulta de Drift.
/// Solo se abre desde Ajustes en modo depuracion; se borra al conectar.
class CatalogPreviewPage extends StatefulWidget {
  const CatalogPreviewPage({super.key});

  @override
  State<CatalogPreviewPage> createState() => _CatalogPreviewPageState();
}

class _CatalogPreviewPageState extends State<CatalogPreviewPage> {
  var _filter = const CatalogFilter();
  var _layout = CatalogLayout.grid;
  var _tab = 0;

  /// Favoritos en memoria, del mas reciente al mas viejo.
  final _favoriteIds = <int>[6, 25];

  List<Pokemon> get _results {
    final search = _filter.query.trim().toLowerCase();
    final typeId = _filter.typeId;
    final generationId = _filter.generationId;
    final list = [
      for (final s in _PreviewSamples.all)
        if ((search.isEmpty || s.pokemon.name.contains(search)) &&
            (typeId == null || s.pokemon.types.any((t) => t.id == typeId)) &&
            (generationId == null || s.generation == generationId))
          s,
    ];
    int compare(_Sample a, _Sample b) => switch (_filter.sort) {
      CatalogSort.number => a.pokemon.nationalDexNumber.compareTo(
        b.pokemon.nationalDexNumber,
      ),
      CatalogSort.name => a.pokemon.name.compareTo(b.pokemon.name),
      CatalogSort.type => a.pokemon.types.first.id.compareTo(
        b.pokemon.types.first.id,
      ),
      CatalogSort.baseStatTotal => a.baseStatTotal.compareTo(b.baseStatTotal),
    };
    list.sort((a, b) => _filter.descending ? compare(b, a) : compare(a, b));
    return [for (final s in list) s.pokemon];
  }

  void _toggle(Pokemon pokemon) {
    setState(() {
      if (!_favoriteIds.remove(pokemon.id)) _favoriteIds.insert(0, pokemon.id);
    });
  }

  void _open(Pokemon pokemon) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Aquí se abriría ${pokemon.displayName}.')),
      );
  }

  Widget _heart(Pokemon pokemon) => FavoriteButton(
    isFavorite: _favoriteIds.contains(pokemon.id),
    pokemonName: pokemon.displayName,
    onPressed: () => _toggle(pokemon),
  );

  @override
  Widget build(BuildContext context) {
    final byId = {for (final s in _PreviewSamples.all) s.pokemon.id: s.pokemon};

    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa del catálogo')),
      body: IndexedStack(
        index: _tab,
        children: [
          Column(
            children: [
              CatalogToolbar(
                filter: _filter,
                onFilterChanged: (f) => setState(() => _filter = f),
                layout: _layout,
                onLayoutChanged: (l) => setState(() => _layout = l),
                savedCount: _PreviewSamples.all.length,
                totalCount: 1025,
              ),
              Expanded(child: _buildResults(_results)),
            ],
          ),
          FavoritesView(
            pokemon: [for (final id in _favoriteIds) byId[id]!],
            onOpen: _open,
            onToggle: _toggle,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.catching_pokemon_outlined),
            label: 'Catálogo',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }

  Widget _buildResults(List<Pokemon> results) {
    if (results.isEmpty) {
      return NoResultsView(
        onClear: () => setState(
          () => _filter = CatalogFilter(
            sort: _filter.sort,
            descending: _filter.descending,
          ),
        ),
      );
    }
    return switch (_layout) {
      CatalogLayout.list => ListView.builder(
        itemExtent: PokemonListTile.height,
        itemCount: results.length,
        itemBuilder: (_, i) => PokemonListTile(
          pokemon: results[i],
          onTap: () => _open(results[i]),
          trailing: _heart(results[i]),
        ),
      ),
      CatalogLayout.grid => GridView.builder(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisExtent: PokemonGridCard.height,
        ),
        itemCount: results.length,
        itemBuilder: (_, i) => PokemonGridCard(
          pokemon: results[i],
          onTap: () => _open(results[i]),
          trailing: _heart(results[i]),
        ),
      ),
    };
  }
}

/// Pokemon de prueba con lo que la entidad todavia no trae.
class _Sample {
  const _Sample(this.pokemon, this.generation, this.baseStatTotal);

  final Pokemon pokemon;
  final int generation;
  final int baseStatTotal;
}

/// Elenco de prueba: 16 Pokemon de varias generaciones y tipos.
abstract final class _PreviewSamples {
  static const _art =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/'
      'pokemon/other/official-artwork';

  static _Sample _p(
    int id,
    String name,
    List<(int, String)> types,
    int gen,
    int bst,
  ) => _Sample(
    Pokemon(
      id: id,
      name: name,
      nationalDexNumber: id,
      artworkUrl: '$_art/$id.png',
      spriteUrl: null,
      types: [
        for (var i = 0; i < types.length; i++)
          PokemonType(id: types[i].$1, name: types[i].$2, slot: i + 1),
      ],
    ),
    gen,
    bst,
  );

  static final all = [
    _p(1, 'bulbasaur', [(12, 'grass'), (4, 'poison')], 1, 318),
    _p(4, 'charmander', [(10, 'fire')], 1, 309),
    _p(6, 'charizard', [(10, 'fire'), (3, 'flying')], 1, 534),
    _p(7, 'squirtle', [(11, 'water')], 1, 314),
    _p(25, 'pikachu', [(13, 'electric')], 1, 320),
    _p(94, 'gengar', [(8, 'ghost'), (4, 'poison')], 1, 500),
    _p(122, 'mr-mime', [(14, 'psychic'), (18, 'fairy')], 1, 460),
    _p(133, 'eevee', [(1, 'normal')], 1, 325),
    _p(149, 'dragonite', [(16, 'dragon'), (3, 'flying')], 1, 600),
    _p(152, 'chikorita', [(12, 'grass')], 2, 318),
    _p(197, 'umbreon', [(17, 'dark')], 2, 525),
    _p(248, 'tyranitar', [(6, 'rock'), (17, 'dark')], 2, 600),
    _p(448, 'lucario', [(2, 'fighting'), (9, 'steel')], 4, 525),
    _p(700, 'sylveon', [(18, 'fairy')], 6, 525),
    _p(778, 'mimikyu', [(8, 'ghost'), (18, 'fairy')], 7, 476),
    _p(906, 'sprigatito', [(12, 'grass')], 9, 310),
  ];
}
