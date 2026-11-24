import 'package:flutter/foundation.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/sync/retry_policy.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/entities/type_chart.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_detail_repository.dart';

import '../datasources/pokemon_detail_local_datasource.dart';
import '../datasources/pokemon_remote_datasource.dart';
import '../mappers/pokemon_detail_mapper.dart';

/// Despacho del detalle: cumple PokemonDetailRepository.
///
/// Los watch... leen solo de Drift. loadDetail descarga de PokeAPI con
/// reintentos, guarda y, la primera vez, trae tambien la tabla de tipos.
class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  PokemonDetailRepositoryImpl({
    required this._remote,
    required this._local,
    this.retryPolicy = const RetryPolicy(),
  });

  final PokemonRemoteDataSource _remote;
  final PokemonDetailLocalDataSource _local;

  /// Reintentos de la descarga cuando PokeAPI falla de forma pasajera.
  final RetryPolicy retryPolicy;

  /// Descargas en curso por id: si se abre dos veces el mismo detalle
  /// mientras baja, las dos esperan la misma descarga.
  final _loading = <int, Future<void>>{};

  @override
  Stream<PokemonDetail?> watchDetail(int pokemonId) {
    return _local
        .watchDetail(pokemonId)
        .map(
          (rows) => rows == null ? null : PokemonDetailMapper.toEntity(rows),
        );
  }

  @override
  Future<void> loadDetail(int pokemonId) {
    // Con llaves y sin return: si la funcion devolviera el Future quitado
    // del mapa, whenComplete se quedaria esperandose a si mismo.
    return _loading[pokemonId] ??= _download(pokemonId).whenComplete(() {
      _loading.remove(pokemonId);
    });
  }

  @override
  Stream<TypeChart?> watchTypeChart() {
    return _local.watchTypeChart().map(
      (rows) => rows == null ? null : PokemonDetailMapper.toTypeChart(rows),
    );
  }

  /// Bajada del detalle: PokeAPI -> mapper -> Drift, en una transaccion.
  ///
  /// Sobrescribe lo guardado, asi que tambien restaura los datos alterados
  /// de ese Pokemon. Si falla, lo guardado no se toca.
  Future<void> _download(int pokemonId) async {
    try {
      final dto = await retryPolicy.run(
        () => _remote.fetchDetail(pokemonId),
        label: 'Detail id $pokemonId',
      );
      await _local.saveDetail(
        PokemonDetailMapper.toRows(dto, updatedAt: DateTime.now()),
      );
    } on Failure {
      rethrow;
    } catch (error) {
      debugPrint('[Detail] Error inesperado al guardar: $error');
      throw const UnknownFailure();
    }
    await _ensureTypeChart();
  }

  /// Provision de la tabla de tipos: la descarga solo si todavia no esta.
  ///
  /// Si falla no se lanza el error: el detalle ya se guardo, y las
  /// debilidades aparecen cuando la tabla se consiga en otra apertura.
  Future<void> _ensureTypeChart() async {
    if (await _local.watchTypeChart().first != null) return;
    try {
      final dto = await retryPolicy.run(
        _remote.fetchTypeChart,
        label: 'TypeChart',
      );
      await _local.saveTypeChart(PokemonDetailMapper.toTypeChartRows(dto));
    } on Failure catch (failure) {
      debugPrint('[Detail] No se pudo bajar la tabla de tipos: $failure');
    }
  }
}
