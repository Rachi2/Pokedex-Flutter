import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:pokedex/core/error/failure.dart';
import 'package:pokedex/core/network/graphql_client.dart';

import '../dtos/pokemon_detail_dto.dart';
import '../dtos/pokemon_dto.dart';
import '../graphql/pokemon_detail_queries.dart';
import '../graphql/pokemon_queries.dart';

/// Mensajero de PokeAPI: unico lugar de la app que usa el cliente GraphQL.
class PokemonRemoteDataSource {
  PokemonRemoteDataSource(this._client);

  final GraphQLClient _client;

  /// Pedido de pagina: descarga una pagina del catalogo desde PokeAPI.
  Future<CatalogPageDto> fetchPage({
    required int offset,
    int limit = catalogPageSize,
  }) async {
    debugPrint('[GraphQL] Catalog -> offset: $offset, limit: $limit');
    final page = await _run(
      label: 'Catalog',
      document: catalogQuery,
      variables: {'offset': offset, 'limit': limit},
      parse: CatalogPageDto.fromJson,
    );
    debugPrint(
      '[GraphQL] Catalog <- ${page.pokemon.length} Pokemon '
      '(total en PokeAPI: ${page.totalCount})',
    );
    return page;
  }

  /// Solicitud del detalle: descarga el detalle completo de un Pokemon (o de
  /// una forma, por su id).
  ///
  /// Son dos consultas: primero en que juegos tiene movimientos, para elegir
  /// uno con [pickMovesVersionGroup], y despues el detalle con ese juego.
  /// Lanza los mismos Failure que [fetchPage].
  Future<PokemonDetailDto> fetchDetail(int pokemonId) async {
    debugPrint('[GraphQL] Detail -> id: $pokemonId');
    final versionGroups = await _run(
      label: 'Detail',
      document: versionGroupsQuery,
      variables: {'id': pokemonId},
      parse: _parseVersionGroups,
    );
    final versionGroup = pickMovesVersionGroup(versionGroups);

    final detail = await _run(
      label: 'Detail',
      document: pokemonDetailQuery,
      // Sin juego (formas gigamax) se pide el 0, que no existe: llegan cero
      // movimientos y el resto del detalle completo.
      variables: {'id': pokemonId, 'versionGroup': versionGroup ?? 0},
      parse: PokemonDetailDto.fromJson,
    );
    debugPrint(
      '[GraphQL] Detail <- ${detail.pokemon.name}, juego '
      '${versionGroup ?? '-'}, ${detail.moves.length} movimientos',
    );
    return detail;
  }

  /// Tabulado de tipos: descarga la tabla de efectividad (18 x 18).
  Future<TypeEfficacyTableDto> fetchTypeChart() async {
    debugPrint('[GraphQL] TypeChart ->');
    final table = await _run(
      label: 'TypeChart',
      document: typeEfficacyQuery,
      parse: TypeEfficacyTableDto.fromJson,
    );
    debugPrint(
      '[GraphQL] TypeChart <- ${table.types.length} tipos, '
      '${table.efficacies.length} filas',
    );
    return table;
  }

  /// Envio de una consulta: aplica el timeout, traduce los errores a Failure
  /// y convierte la respuesta con [parse]. [label] es el nombre que se ve en
  /// la consola.
  Future<T> _run<T>({
    required String label,
    required String document,
    Map<String, dynamic> variables = const {},
    required T Function(Map<String, dynamic> data) parse,
  }) async {
    final QueryResult result;
    try {
      result = await _client
          .query(
            QueryOptions(
              document: gql(document),
              variables: variables,
              // all: si llegan datos y errores juntos, se reciben los dos
              // para poder reconocer una respuesta incompleta.
              errorPolicy: ErrorPolicy.all,
            ),
          )
          .timeout(graphQLRequestTimeout);
    } on TimeoutException {
      debugPrint('[GraphQL] $label <- timeout');
      throw const TimeoutFailure();
    }

    final exception = result.exception;
    if (exception != null) {
      final failure = _toFailure(exception, hasData: result.data != null);
      debugPrint('[GraphQL] $label <- ${_describe(failure, exception)}');
      throw failure;
    }

    final data = result.data;
    if (data == null) {
      debugPrint('[GraphQL] $label <- respuesta sin data');
      throw const ServerFailure();
    }

    try {
      return parse(data);
    } on FormatException catch (e) {
      debugPrint('[GraphQL] $label <- respuesta invalida: ${e.message}');
      throw const ServerFailure();
    }
  }

  /// Recuento de juegos: saca los version groups de la primera consulta.
  /// Lanza FormatException si PokeAPI no tiene ese Pokemon.
  static List<int> _parseVersionGroups(Map<String, dynamic> data) {
    final list = data['pokemon'];
    if (list is! List || list.isEmpty || list.first is! Map<String, dynamic>) {
      throw const FormatException('PokeAPI no tiene ese Pokemon');
    }
    final moves = (list.first as Map<String, dynamic>)['pokemonmoves'];
    if (moves is! List) return [];
    return [
      for (final move in moves)
        if (move is Map<String, dynamic> && move['version_group_id'] is int)
          move['version_group_id'] as int,
    ];
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
