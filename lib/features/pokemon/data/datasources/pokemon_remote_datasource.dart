import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/graphql_client.dart';

import '../dtos/pokemon_dto.dart';
import '../graphql/pokemon_queries.dart';

/// Mensajero de PokeAPI: unico lugar de la app que usa el cliente GraphQL.
class PokemonRemoteDataSource {
  PokemonRemoteDataSource(this._client);

  final GraphQLClient _client;

  /// Pedido de pagina: descarga una pagina del catalogo desde PokeAPI.
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
              // all: si llegan datos y errores juntos, se reciben los dos
              // para poder reconocer una respuesta incompleta.
              errorPolicy: ErrorPolicy.all,
            ),
          )
          .timeout(graphQLRequestTimeout);
    } on TimeoutException {
      debugPrint('[GraphQL] Catalog <- timeout');
      throw const TimeoutFailure();
    }

    final exception = result.exception;
    if (exception != null) {
      final failure = _toFailure(exception, hasData: result.data != null);
      debugPrint('[GraphQL] Catalog <- ${_describe(failure, exception)}');
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

  /// Clasificador de errores: pasa los de GraphQL a los Failure de la app.
  ///
  /// [hasData] dice si, ademas de los errores, llegaron datos.
  Failure _toFailure(OperationException exception, {required bool hasData}) {
    final linkException = exception.linkException;

    // PokeAPI limito las peticiones: va antes que el resto porque la
    // respuesta 429 puede no ser JSON y parecer un error de formato.
    final rateLimit = _rateLimit(linkException);
    if (rateLimit != null) return rateLimit;

    // No se pudo llegar al servidor: sin red o sin DNS.
    if (linkException is NetworkException ||
        linkException?.originalException is SocketException) {
      return const NetworkFailure();
    }

    // Error que no sabemos clasificar.
    if (linkException is UnknownException) {
      return const UnknownFailure();
    }

    // GraphQL respondio con datos y con errores a la vez.
    if (hasData && exception.graphqlErrors.isNotEmpty) {
      return const PartialResponseFailure();
    }

    // El servidor respondio, pero con un error o con algo que no se entiende.
    return const ServerFailure();
  }

  /// Limitador: si PokeAPI respondio HTTP 429, arma el Failure con la
  /// espera que pide el encabezado Retry-After (en segundos), si lo trae.
  RateLimitFailure? _rateLimit(LinkException? linkException) {
    final response = switch (linkException) {
      HttpLinkServerException(:final response) => response,
      HttpLinkParserException(:final response) => response,
      _ => null,
    };
    if (response == null || response.statusCode != 429) return null;

    final seconds = int.tryParse(response.headers['retry-after'] ?? '');
    return RateLimitFailure(
      retryAfter: seconds == null ? null : Duration(seconds: seconds),
    );
  }

  /// Relato del error para la consola, con el detalle que sirve al revisar.
  String _describe(Failure failure, OperationException exception) {
    return switch (failure) {
      RateLimitFailure(:final retryAfter) =>
        'RateLimitFailure (HTTP 429, Retry-After: '
            '${retryAfter?.inSeconds ?? '-'} s)',
      PartialResponseFailure() =>
        'PartialResponseFailure (${exception.graphqlErrors.length} errores: '
            '${exception.graphqlErrors.first.message})',
      _ => '${failure.runtimeType}',
    };
  }
}
