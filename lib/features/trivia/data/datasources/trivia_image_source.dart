import 'package:pokedex/core/images/pokemon_image_cache.dart';

/// Revisor de siluetas: comprueba si la imagen de un Pokémon ya está en la
/// caché del teléfono, y si no, intenta descargarla. Sin conexión, la trivia
/// solo puede preguntar por los que ya la tienen.
class TriviaImageSource {
  /// Mira la caché sin usar la red. No usa getSingleFile porque, si la imagen
  /// tiene más de 90 días, intenta descargarla otra vez y sin red falla.
  Future<bool> isSaved(String url) async {
    final file = await PokemonImageCache.instance.getFileFromCache(url);
    return file != null;
  }

  /// Descarga la imagen y la deja en la caché; false si falla (sin red o
  /// API caída), en vez de lanzar el error.
  Future<bool> download(String url) async {
    try {
      await PokemonImageCache.instance.downloadFile(url);
      return true;
    } catch (_) {
      return false;
    }
  }
}
