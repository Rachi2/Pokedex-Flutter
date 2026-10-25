import 'package:graphql/client.dart';

/// Direccion del API GraphQL de PokeAPI.
const pokeApiGraphQLUrl = 'https://graphql.pokeapi.co/v1beta2';

/// Tiempo mximo que se espera a PokeAPI en cada consulta (RNF-RES-01).
/// Si no responde en 10 s, la consulta falla y el datasource remoto
/// lo traduce a TimeoutFailure. Se usa en PokemonRemoteDataSource.
const graphQLRequestTimeout = Duration(seconds: 10);

/// Crea el cliente GraphQL de la app.
///
/// Usa FetchPolicy.noCache porque la fuente de verdad es Drift,
/// no la cache del cliente GraphQL (seccion 6.5 del enunciado).
GraphQLClient createGraphQLClient() {
  return GraphQLClient(
    link: HttpLink(pokeApiGraphQLUrl),
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
    ),
    // El timeout se aplica en el datasource remoto con Future.timeout,
    // porque el de la libreria falla si la respuesta llega tarde.
    queryRequestTimeout: null,
  );
}
