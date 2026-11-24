import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/entities/type_chart.dart';
import 'package:pokedex/features/pokemon/pokemon_providers.dart';

/// Escaparate del detalle: el detalle completo guardado en Drift, por id, o
/// null si todavia no se descargo. Emite de nuevo cada vez que cambia.
final fullDetailProvider = StreamProvider.autoDispose
    .family<PokemonDetail?, int>((ref, id) {
      return ref.watch(watchPokemonDetailProvider)(id);
    });

/// Cartilla de tipos: la tabla de efectividad guardada, para las debilidades.
final typeChartProvider = StreamProvider<TypeChart?>((ref) {
  return ref.watch(watchTypeChartProvider)();
});

/// Compas de la descarga: lo que esta pasando con el detalle al abrir la
/// pagina.
class DetailDownloadState {
  const DetailDownloadState({this.isLoading = false, this.failure});

  final bool isLoading;

  /// Error de la ultima descarga, o null si salio bien.
  final Failure? failure;
}

/// Apertura del detalle: lo descarga al abrir la pagina, por id.
///
/// Es autoDispose: cada vez que se vuelve a abrir el detalle se descarga de
/// nuevo, y asi tambien se restauran los datos alterados de ese Pokemon.
final detailDownloadProvider = NotifierProvider.autoDispose
    .family<DetailDownloadNotifier, DetailDownloadState, int>(
      DetailDownloadNotifier.new,
    );

class DetailDownloadNotifier extends Notifier<DetailDownloadState> {
  DetailDownloadNotifier(this.pokemonId);

  final int pokemonId;

  @override
  DetailDownloadState build() {
    // Se lanza despues de construir el estado, sin await: la pagina muestra
    // lo guardado mientras baja la version de PokeAPI.
    Future.microtask(load);
    return const DetailDownloadState(isLoading: true);
  }

  /// Telon de la descarga: pide el detalle a PokeAPI y deja el resultado en
  /// el estado. Tambien es el boton Reintentar.
  Future<void> load() async {
    state = const DetailDownloadState(isLoading: true);
    try {
      await ref.read(loadPokemonDetailProvider)(pokemonId);
      if (!ref.mounted) return;
      state = const DetailDownloadState();
    } on Failure catch (failure) {
      if (!ref.mounted) return;
      state = DetailDownloadState(failure: failure);
    }
  }
}
