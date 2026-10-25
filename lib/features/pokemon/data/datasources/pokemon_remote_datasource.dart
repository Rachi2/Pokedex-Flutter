import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/graphql_client.dart';

import '../dtos/pokemon_dto.dart';
import '../graphql/pokemon_queries.dart';

/// Unico lugar de la app que usa el cliente GraphQL.
class PokemonRemoteDataSource {
  PokemonRemoteDataSource(this._client);

  final GraphQLClient _client;

  /// Descarga una pagina del catalogo desde PokeAPI.
  ///
  /// Lanza NetworkFailure, TimeoutFailure, ServerFailure o UnknownFailure
  /// si algo sale mal.
  Future<CatalogPageDto> fetchPage({
    required int offset,
    int limit = catalogPageSize,
  }) async {
    debugPrint('[GraphQL] Catalog -> offset: $offset, limit: $limit');

    final QueryResult result;
    try {
      result = await _client
          .query(
            QueryOptions(
              document: gql(catalogQuery),
              variables: {'offset': offset, 'limit': limit},
            ),
          )
          .timeout(graphQLRequestTimeout);
    } on TimeoutException {
      debugPrint('[GraphQL] Catalog <- timeout');
      throw const TimeoutFailure();
    }

    final exception = result.exception;
    if (exception != null) {
      final failure = _toFailure(exception);
      debugPrint('[GraphQL] Catalog <- ${failure.runtimeType}');
      throw failure;
    }

    final data = result.data;
    if (data == null) {
      debugPrint('[GraphQL] Catalog <- respuesta sin data');
      throw const ServerFailure();
    }

    try {
      final page = CatalogPageDto.fromJson(data);
      debugPrint(
        '[GraphQL] Catalog <- ${page.pokemon.length} Pokemon '
        '(total en PokeAPI: ${page.totalCount})',
      );
      return page;
    } on FormatException catch (e) {
      debugPrint('[GraphQL] Catalog <- respuesta invalida: ${e.message}');
      throw const ServerFailure();
    }
  }

  /// Traduce los errores tecnicos de GraphQL a los Failure de la app.
  Failure _toFailure(OperationException exception) {
    final linkException = exception.linkException;

    // No se pudo llegar al servidor: sin red o sin DNS.
    if (linkException is NetworkException ||
        linkException?.originalException is SocketException) {
      return const NetworkFailure();
    }

    // Error que no sabemos clasificar.
    if (linkException is UnknownException) {
      return const UnknownFailure();
    }

    // El servidor respondio, pero con un error o con algo que no se entiende.
    return const ServerFailure();
  }
}
