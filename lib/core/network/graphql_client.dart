import 'package:graphql/client.dart';

import 'api_outage_simulator.dart';

/// Endpoint de PokeAPI: la direccion de su API GraphQL.
const pokeApiGraphQLUrl = 'https://graphql.pokeapi.co/v1beta2';

/// Plazo maximo que se espera a PokeAPI en cada consulta.
/// Si no responde en 10 s, la consulta falla y el datasource remoto
/// lo traduce a TimeoutFailure. Se usa en PokemonRemoteDataSource.
const graphQLRequestTimeout = Duration(seconds: 10);

/// Fabrica del cliente GraphQL de la app.
///
/// Usa FetchPolicy.noCache porque la fuente de verdad es Drift,
/// no la cache del cliente GraphQL (seccion 6.5 del enunciado).
/// Si se pasa [isOutage], cada consulta pasa antes por el simulador de API
/// caida, que la corta mientras [isOutage] devuelva true.
GraphQLClient createGraphQLClient({bool Function()? isOutage}) {
  final http = HttpLink(pokeApiGraphQLUrl);
  return GraphQLClient(
    link: isOutage == null ? http : Link.from([OutageLink(isOutage), http]),
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
    ),
    // El timeout se aplica en el datasource remoto con Future.timeout,
    // porque el de la libreria falla si la respuesta llega tarde.
    queryRequestTimeout: null,
  );
}
