import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:graphql/client.dart';

import '../domain/entities/service_status.dart';
import '../domain/repositories/connectivity_repository.dart';

/// Consulta mínima para saber si PokeAPI responde (IND-02).
const _healthCheckQuery = '{ __typename }';

/// Implementación de [ConnectivityRepository] que verifica de forma combinada
/// el estado de red del dispositivo y la disponibilidad real de la PokeAPI.
class ConnectivityRepositoryImpl implements ConnectivityRepository {
  ConnectivityRepositoryImpl(
    this._connectivity,
    this._client, {
    this.healthCheckTimeout = const Duration(seconds: 5),
    this.debounce = const Duration(milliseconds: 1500),
    this.recheckInterval = const Duration(seconds: 30),
  });

  final Connectivity _connectivity;
  final GraphQLClient _client;
  final Duration healthCheckTimeout;
  final Duration debounce;
  final Duration recheckInterval;

  /// Realiza un chequeo puntual de conectividad en dos pasos:
  /// 1. Hardware (connectivity_plus).
  /// 2. Ping real a la API (solo si hay red local).
  @override
  Future<ServiceStatus> checkNow() async {
    final results = await _connectivity.checkConnectivity();
    final isCompletelyOffline = results.every(
      (result) => result == ConnectivityResult.none,
    );

    if (isCompletelyOffline) {
      return ServiceStatus.offline;
    }

    return _pingApi();
  }

  /// Ejecuta la consulta GraphQL mínima contra la PokeAPI.
  /// Si ocurre un error o el tiempo supera [healthCheckTimeout], asume que está caída (unavailable).
  Future<ServiceStatus> _pingApi() async {
    try {
      final result = await _client
          .query(QueryOptions(document: gql(_healthCheckQuery)))
          .timeout(healthCheckTimeout);
      if (result.hasException) {
        return ServiceStatus.unavailable;
      }
      return ServiceStatus.online;
    } on TimeoutException {
      // La API tardo mas de 5 segundos
      return ServiceStatus.unavailable;
    } catch (_) {
      // Cualquier otro error inesperado
      return ServiceStatus.unavailable;
    }
  }

  @override
  Stream<ServiceStatus> watchStatus() {
    late final StreamController<ServiceStatus> controller;
    StreamSubscription<List<ConnectivityResult>>? networkSubscription;
    Timer? debounceTimer;
    Timer? recheckTimer;
    ServiceStatus? lastEmitted;
    var ticket = 0;

    void emit(ServiceStatus status) {
      if (status == lastEmitted) {
        return;
      }
      lastEmitted = status;

      controller.add(status);
    }

    Future<void> evaluate() async {
      final localTicket = ++ticket;
      final result = await checkNow();
      if (localTicket != ticket) return;
      emit(result);
    }

    controller = StreamController<ServiceStatus>(
      onListen: () {
        emit(ServiceStatus.checking);

        unawaited(evaluate());

        networkSubscription = _connectivity.onConnectivityChanged.listen((_) {
          debounceTimer?.cancel();
          debounceTimer = Timer(debounce, evaluate);
        });

        recheckTimer = Timer.periodic(recheckInterval, (_) => evaluate());
      },
      onCancel: () async {
        ticket++;
        debounceTimer?.cancel();
        recheckTimer?.cancel();
        await networkSubscription?.cancel();
      },
    );

    return controller.stream;
  }
}
