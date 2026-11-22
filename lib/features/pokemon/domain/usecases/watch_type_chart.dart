import '../entities/type_chart.dart';
import '../repositories/pokemon_detail_repository.dart';

/// Brujula de tipos: observa la tabla de efectividad guardada, para calcular
/// las debilidades en la pagina de detalle.
class WatchTypeChart {
  const WatchTypeChart(this._repository);

  final PokemonDetailRepository _repository;

  Stream<TypeChart?> call() => _repository.watchTypeChart();
}
