import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/features/connectivity/data/connectivity_repository_impl.dart';
import 'package:pokedex/features/connectivity/domain/entities/service_status.dart';
import 'package:pokedex/features/connectivity/domain/repositories/connectivity_repository.dart';

import '../network/graphql_client.dart';
import '../database/app_database.dart';

/// Una sola AppDatabase para toda la app; se cierra al apagar Riverpod.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Un solo cliente GraphQL para el health check y el datasource remoto.
final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  return createGraphQLClient();
});

/// Repositorio que evalúa el estado de la conexión (red y servidor).
final connectivityRepositoryProvider = Provider<ConnectivityRepository>((ref) {
  return ConnectivityRepositoryImpl(
    Connectivity(),
    ref.watch(graphqlClientProvider),
  );
});

/// Stream para reaccionar en tiempo real a los cambios de conectividad.
final serviceStatusProvider = StreamProvider<ServiceStatus>((ref) {
  return ref.watch(connectivityRepositoryProvider).watchStatus();
});
