# ADR-0002: Riverpod para estado e inyección de dependencias

- **Estado:** Aceptado
- **Fecha de registro:** 2026-11-06

## Contexto

La interfaz debe reaccionar a varias fuentes que cambian solas: el catálogo guardado, el estado de la sincronización y la conectividad. Además, debe modelar de forma explícita los estados de carga, éxito, vacío y error (OE-06).

Las dependencias también deben estar inyectadas y ser sustituibles (RNF-MAN-03). Por ejemplo, debe haber una sola `AppDatabase` compartida, porque varias conexiones al mismo archivo no se enterarían de los cambios de las otras. El enunciado recomienda Riverpod o BLoC.

## Decisión

Usar **Riverpod 3** (`flutter_riverpod`) tanto para el estado como para la inyección de dependencias, sin generación de código:

- `Provider` para las dependencias: base de datos, cliente GraphQL, repositorios y casos de uso.
- `StreamProvider` para los datos reactivos: catálogo, sincronización y conectividad.
- `NotifierProvider` para el estado de pantalla y sus acciones: `catalogProvider` y `catalogActionsProvider`.

Los providers compartidos están en `core/di/core_providers.dart`, y los de la funcionalidad, en `features/pokemon/pokemon_providers.dart`. Los contratos del dominio se exponen con su tipo abstracto: `connectivityRepositoryProvider` devuelve `ConnectivityRepository`, no su implementación.

## Alternativas consideradas

| Alternativa | Ventaja | Por qué no se eligió |
|---|---|---|
| **BLoC** | Flujo de eventos y estados muy explícito | Exige más clases por cada pantalla (eventos, estados y bloc) y un mecanismo aparte para inyectar dependencias. Para combinar varios streams, Riverpod lo resuelve observando otros providers |
| **`provider`** | Simple y muy conocido | Depende del árbol de widgets para encontrar las dependencias. Riverpod es su evolución y resuelve esa limitación |
| **`setState` con `get_it`** | Sin conceptos nuevos de estado | El estado asíncrono y la combinación de fuentes habría que escribirlos a mano, y se mezclaría lógica con widgets |

## Consecuencias

**Positivas**

- `StreamProvider` conecta directo con los streams de Drift, y `AsyncValue` da los estados de carga, datos y error.
- `catalogProvider` combina base local, sincronización y conectividad observando otros providers, y `buildCatalogState` es una función pura y fácil de probar.
- Las dependencias se reemplazan con `overrides` del `ProviderScope`, sin tocar el código de producción.
- `ref.onDispose` centraliza el cierre de recursos, como la base de datos y el coordinador.
- Como `CatalogState` es una clase sellada, el compilador obliga a la pantalla a cubrir todos los estados.

**Negativas**

- Hay que entender bien sus conceptos: `watch` frente a `read`, y cuándo se reconstruye cada provider. Por ejemplo, `CatalogNotifier` se reconstruye cuando cambian sus fuentes, por lo que el estado de `loadMore` y `refresh` vive en un provider aparte, `catalogActionsProvider`.
- Los providers son declaraciones globales: la estructura del proyecto no impide que una capa use uno que no le corresponde, así que hay que cuidar esa separación por disciplina.
