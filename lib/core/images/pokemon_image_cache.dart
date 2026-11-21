import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Despensa de imagenes: la cache en disco de los artworks y sprites, con
/// limite de 3000 archivos y 90 dias sin uso antes de borrarse.
abstract final class PokemonImageCache {
  static const _key = 'pokemonImages';

  static final instance = CacheManager(
    Config(
      _key,
      stalePeriod: const Duration(days: 90),
      maxNrOfCacheObjects: 3000,
    ),
  );
}
