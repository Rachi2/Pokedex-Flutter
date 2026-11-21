import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/features/connectivity/data/connectivity_repository_impl.dart';
import 'package:pokedex/features/connectivity/domain/entities/service_status.dart';
import 'package:pokedex/features/connectivity/domain/repositories/connectivity_repository.dart';

import '../network/api_outage_simulator.dart';
import '../network/graphql_client.dart';
import '../database/app_database.dart';

/// Instancia unica de AppDatabase para toda la app; se cierra al apagar
/// Riverpod.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Cliente compartido de GraphQL: lo usan el health check y el datasource
/// remoto.
final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  // El simulador se lee en cada consulta, asi el interruptor actua al momento.
  return createGraphQLClient(
    isOutage: () => ref.read(apiOutageSimulatorProvider),
  );
});

/// Vigia de la conexion: el repositorio que evalua la red y el servidor.
final connectivityRepositoryProvider = Provider<ConnectivityRepository>((ref) {
  return ConnectivityRepositoryImpl(
    Connectivity(),
    ref.watch(graphqlClientProvider),
  );
});

/// Pulso de la conexion: stream con cada cambio de estado del servicio.
final serviceStatusProvider = StreamProvider<ServiceStatus>((ref) {
  return ref.watch(connectivityRepositoryProvider).watchStatus();
});
