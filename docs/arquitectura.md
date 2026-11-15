# Arquitectura de la Pokédex

Este documento describe cómo está construida la aplicación, según la rama `main` (commit `37b7279`).

**La idea central es Offline-First:** la interfaz **nunca** usa una respuesta de la red. Siempre lee de la base de datos local (Drift), y la red solo sirve para mantener esa base actualizada. Por eso, todo lo que se muestra con conexión también se ve sin ella.

## Índice

1. [Capas y regla de dependencias](#1-capas-y-regla-de-dependencias)
2. [Organización por funcionalidades](#2-organización-por-funcionalidades)
3. [Componentes de cada capa](#3-componentes-de-cada-capa)
4. [Inyección de dependencias](#4-inyección-de-dependencias)
5. [Recorrido de un Pokémon hasta la pantalla](#5-recorrido-de-un-pokémon-hasta-la-pantalla)
6. [Sincronización](#6-sincronización)
7. [Conectividad e indicador](#7-conectividad-e-indicador)
8. [Estado de la pantalla del catálogo](#8-estado-de-la-pantalla-del-catálogo)
9. [Modelo de datos local](#9-modelo-de-datos-local)
10. [Modelo de errores](#10-modelo-de-errores)
11. [Decisiones y límites actuales](#11-decisiones-y-límites-actuales)

---

## 1. Capas y regla de dependencias

El código sigue Clean Architecture con tres capas. **Las dependencias apuntan hacia el dominio**: el dominio no conoce a nadie, y las otras dos capas dependen de él.

| Capa | Responsabilidad | Restricción |
|---|---|---|
| **Presentation** | Páginas, widgets y estado de pantalla (providers de Riverpod) | No usa GraphQL ni Drift |
| **Domain** | Entidades, contratos de repositorio y casos de uso | No depende de Flutter, GraphQL ni Drift |
| **Data** | Implementa los contratos: fuentes de datos, DTO, mapeadores, sincronización y repositorios | Es la única capa que habla con PokeAPI y con la base local; traduce los errores técnicos a `Failure` |

```mermaid
flowchart TB
    subgraph P["Presentation"]
        Pages["CatalogPage · PokemonDetailPage · AppShell"]
        Widgets["PokemonListTile · TypeChip · PokemonImage<br/>PokemonArtCarousel · CatalogStateViews<br/>ConnectivityIndicator"]
        State["catalogProvider · pokemonDetailProvider<br/>serviceStatusProvider"]
    end
    subgraph D["Domain"]
        Entities["Pokemon · PokemonType · CatalogSyncStatus<br/>ServiceStatus"]
        Contracts["PokemonRepository · ConnectivityRepository"]
        UseCases["WatchCatalog · WatchPokemon · WatchCatalogSync<br/>LoadNextPage · RefreshCatalog"]
    end
    subgraph DA["Data"]
        RepoImpl["PokemonRepositoryImpl"]
        ConnImpl["ConnectivityRepositoryImpl"]
        Sync["CatalogSyncCoordinator"]
        Mapper["PokemonMapper · DTO"]
        Local["PokemonLocalDataSource · SyncMetadataDao<br/>FavoritesLocalDataSource"]
        Remote["PokemonRemoteDataSource"]
    end
    DB[("SQLite con Drift<br/>pokedex.sqlite")]
    API["PokeAPI GraphQL"]

    Pages --> Widgets
    Pages --> State
    State --> UseCases
    State --> Contracts
    UseCases --> Contracts
    Contracts --> Entities
    RepoImpl -. implementa .-> Contracts
    ConnImpl -. implementa .-> Contracts
    RepoImpl --> Local
    RepoImpl --> Sync
    RepoImpl --> Mapper
    Sync --> Remote
    Sync --> Local
    Sync --> Mapper
    Sync --> Contracts
    Local --> DB
    Remote --> API
    ConnImpl --> API
```

Las flechas punteadas significan "implementa el contrato". Fíjate que ninguna flecha sale de Domain hacia afuera.

## 2. Organización por funcionalidades

El código se agrupa **por funcionalidad** y, dentro de cada una, por capa. Lo que comparten varias funcionalidades va en `core/`.

```text
lib/
├── main.dart                  # Punto de entrada: ProviderScope + PokedexApp
├── app/                       # MaterialApp, tema, AppShell (cabecera, indicador, pestañas)
├── core/
│   ├── database/              # AppDatabase, tablas y SyncMetadataDao
│   ├── di/                    # Providers compartidos
│   ├── error/                 # Failure
│   └── network/               # Cliente GraphQL
└── features/
    ├── connectivity/          # ¿Se puede llegar a PokeAPI? + indicador
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── favorites/             # Por ahora solo la fuente de datos local
    │   └── data/
    └── pokemon/               # Catálogo y detalle
        ├── data/
        ├── domain/
        ├── presentation/
        └── pokemon_providers.dart
```

La descripción de cada archivo está en el README, sección "Estructura del proyecto".

## 3. Componentes de cada capa

### Presentation

| Componente | Qué hace |
|---|---|
| `AppShell` | Marco de las pantallas principales: cabecera, indicador, pestañas en un `IndexedStack` y barra inferior. En horizontal, el indicador pasa a la cabecera en forma compacta |
| `CatalogPage` | Muestra la vista de cada estado del catálogo. La lista solo construye las filas visibles (`itemExtent` fijo), pide la siguiente página cerca del final, se actualiza al deslizar hacia abajo y tiene un botón para volver arriba |
| `PokemonDetailPage` | Detalle básico: carrusel artwork/píxel, número, nombre, tipos y la tarjeta "Datos guardados" |
| `catalogProvider` | Combina base local, sincronización y conectividad en un `CatalogState`. Expone `loadMore()`, `retry()` y `refresh()` |
| `ConnectivityIndicator` | Compone el estado de la red con el de la sincronización y lo muestra con ícono, texto y hora |

### Domain

| Componente | Qué hace |
|---|---|
| `Pokemon`, `PokemonType` | Entidades puras: id, nombre, número, URLs de artwork y sprite, tipos con su slot |
| `CatalogSyncStatus`, `SyncState` | Estado de la sincronización: `idle`, `syncing`, `success` o `error`, más la hora y si quedan páginas |
| `ServiceStatus` | Estado del servicio: `checking`, `online`, `offline` o `unavailable` |
| `PokemonRepository`, `ConnectivityRepository` | Contratos: qué se puede pedir, sin decir cómo |
| Casos de uso | Una clase por acción, con un método `call()` que delega en el repositorio |

### Data

| Componente | Qué hace |
|---|---|
| `PokemonRemoteDataSource` | Único lugar que usa GraphQL. Descarga una página con timeout de 10 s y traduce los errores |
| `PokemonLocalDataSource` | Único lugar que lee y escribe el catálogo en Drift. Emite streams y guarda páginas en transacción |
| `PokemonMapper` | Convierte DTO → filas de Drift → entidad `Pokemon` |
| `CatalogSyncCoordinator` | Decide cuándo descargar, evita descargas simultáneas y guarda cada página junto con sus metadatos |
| `PokemonRepositoryImpl` | Implementa el contrato: lee de la base y le pide las descargas al coordinador |
| `ConnectivityRepositoryImpl` | Combina `connectivity_plus` con una consulta mínima a la API |

## 4. Inyección de dependencias

Las dependencias se crean y se conectan con **providers de Riverpod**. Ninguna clase crea sus propias dependencias: las recibe por el constructor. Así se pueden reemplazar en las pruebas con `overrides`.

```mermaid
flowchart LR
    subgraph core["core/di/core_providers.dart"]
        dbP["databaseProvider<br/>(una sola AppDatabase)"]
        gqlP["graphqlClientProvider"]
        connP["connectivityRepositoryProvider"]
        statusP["serviceStatusProvider<br/>(StreamProvider)"]
    end
    subgraph pk["features/pokemon/pokemon_providers.dart"]
        remoteP["pokemonRemoteDataSourceProvider"]
        localP["pokemonLocalDataSourceProvider"]
        syncP["catalogSyncCoordinatorProvider"]
        repoP["pokemonRepositoryProvider"]
        ucP["casos de uso"]
    end
    subgraph pres["presentation/providers"]
        catP["catalogProvider"]
        detP["pokemonDetailProvider"]
    end

    gqlP --> connP --> statusP
    gqlP --> remoteP
    dbP --> localP
    dbP --> syncP
    remoteP --> syncP
    localP --> syncP
    connP --> syncP
    localP --> repoP
    syncP --> repoP
    dbP --> repoP
    repoP --> ucP
    ucP --> catP
    ucP --> detP
    statusP --> catP
```

- `databaseProvider` crea **una sola** base y la cierra con `ref.onDispose`. Si hubiera dos conexiones al mismo archivo, una no se enteraría de los cambios de la otra.
- `connectivityRepositoryProvider` devuelve el **contrato** (`ConnectivityRepository`), no la implementación. Quien lo usa no sabe cómo se comprueba la conexión.
- `catalogSyncCoordinatorProvider` cierra su suscripción a la conectividad con `ref.onDispose`.

## 5. Recorrido de un Pokémon hasta la pantalla

Es la pregunta típica de la defensa: **"¿por dónde pasa un Pokémon desde PokeAPI hasta la pantalla?"**

```mermaid
sequenceDiagram
    participant API as PokeAPI
    participant R as PokemonRemoteDataSource
    participant S as CatalogSyncCoordinator
    participant M as PokemonMapper
    participant L as PokemonLocalDataSource
    participant DB as Drift
    participant Repo as PokemonRepositoryImpl
    participant C as catalogProvider
    participant UI as CatalogPage

    S->>R: fetchPage(offset, 50)
    R->>API: catalogQuery
    API-->>R: JSON
    R-->>S: CatalogPageDto
    S->>M: toRows(dto)
    M-->>S: PokemonWithTypes
    S->>L: upsertPage(filas), dentro de una transacción
    L->>DB: insertOnConflictUpdate
    DB-->>L: el stream de watchCatalog emite
    L-->>Repo: List PokemonWithTypes
    Repo->>M: toEntity(filas)
    Repo-->>C: List Pokemon
    C-->>UI: CatalogData
```

Lo importante: **la respuesta de la red termina en la base de datos**. La pantalla se entera porque la base cambió (el stream emite), no porque llegó una respuesta. Por eso funciona igual con y sin conexión.

## 6. Sincronización

La sincronización va en una sola dirección: de PokeAPI a la base local. El catálogo se descarga **por páginas de 50**, con paginación por offset; el siguiente offset se guarda en `sync_metadata`, así que se retoma donde quedó aunque se cierre la app.

### Cuándo se descarga

| Evento | Qué hace |
|---|---|
| Al abrir la app | Si `sync_metadata` quedó en `syncing` (la app se cerró a mitad de una descarga), lo marca como `error`. Luego empieza a escuchar la conectividad |
| La API está disponible al abrir, o vuelve a responder | **Actualización en segundo plano** (Online-Preferred): vuelve a descargar las páginas ya guardadas y después las que faltan |
| El usuario llega a unas 3 filas del final | Descarga la siguiente página |
| Deslizar la lista hacia abajo | Actualización manual: vuelve a pedir la primera página, sin hacer retroceder el offset |
| Botón Reintentar | Pide la siguiente página |

### Actualización en segundo plano (Online-Preferred)

Cumple el principio P-02: con la API disponible, la app prioriza traer datos actualizados, sin bloquear la navegación. La pantalla sigue leyendo solo de la base.

```mermaid
flowchart TD
    A["La API está disponible<br/>(al abrir o al reconectar)"] --> B{"¿Ya hay una<br/>actualización (_batch)?"}
    B -- Sí --> C["Anota que al terminar<br/>hay que hacer otra"]
    B -- No --> D["Lee cuántos hay guardados<br/>(next_offset)"]
    D --> E{"¿Sigue la API<br/>y la app abierta?"}
    E -- No --> Z["Marca success con lo guardado"]
    E -- Sí --> F{"¿Quedan páginas<br/>guardadas por revisar?"}
    F -- Sí --> G["Vuelve a descargar esa página<br/>y sobrescribe"]
    F -- No --> H{"¿Faltan páginas<br/>por descargar?"}
    H -- Sí --> I["Descarga la siguiente"]
    H -- No --> Z
    G --> P["Pausa de 500 ms"]
    I --> P
    P --> E
    G -. falla .-> X["Marca error y se detiene<br/>(se reintenta al reconectar)"]
    I -. falla .-> X
```

- Durante toda la tanda el estado queda en `syncing` (`markSuccess(keepSyncing: true)`) y pasa a `success` una sola vez al final: el indicador no parpadea entre páginas (IND-06).
- Si el usuario ya está bajando una página con el scroll, la tanda espera a que termine y luego hace la suya (`_exclusive`).
- Como sobrescribe lo guardado con lo de PokeAPI, un dato del catálogo alterado en la base se restaura al abrir la app o al volver la conexión (parte de OF-19).
- El catálogo completo son 21 páginas de unos 18 KB; con la pausa, la tanda dura unos 15 a 20 segundos.

### Qué pasa en cada descarga

```mermaid
flowchart TD
    A["syncNextPage o refresh"] --> B{"¿Ya hay una descarga<br/>en curso (_running)?"}
    B -- Sí --> C["Devuelve esa misma<br/>(sin duplicar)"]
    B -- No --> D["markSyncing"]
    D --> E["fetchPage(offset, 50)"]
    E -- Error --> F["markFailed<br/>(no se borra nada)"]
    F --> G["Lanza el Failure"]
    E -- OK --> H["Mapper: DTO a filas"]
    H --> I["Transacción:<br/>upsertPage + markSuccess"]
    I --> J["Drift emite el cambio<br/>y la pantalla se actualiza"]
```

| Garantía | Cómo se logra |
|---|---|
| Sin duplicados | Los registros se identifican por el `id` de PokeAPI y se guardan con `insertOnConflictUpdate` |
| Sin descargas simultáneas | `_running` guarda la descarga en curso y las demás llamadas reciben esa misma |
| Sin datos a medias | La página y sus metadatos se guardan en la misma transacción |
| Sin perder datos al fallar | Un error solo marca `error` en `sync_metadata`; las filas guardadas no se tocan |
| El avance no retrocede | El siguiente offset es el mayor entre el guardado y el nuevo |

## 7. Conectividad e indicador

Se manejan por separado **dos dimensiones**, como pide el enunciado: la disponibilidad del servicio (`ServiceStatus`) y la sincronización (`SyncState`). El indicador las combina.

### Disponibilidad del servicio

`ConnectivityRepositoryImpl` comprueba en dos pasos:

1. Con `connectivity_plus` mira si hay red. Si no hay, el estado es `offline`.
2. Si hay red, envía la consulta mínima `{ __typename }` con un límite de 5 segundos. Si responde, el estado es `online`; si falla o tarda, `unavailable`.

```mermaid
stateDiagram-v2
    [*] --> checking
    checking --> online: la API responde
    checking --> offline: no hay red
    checking --> unavailable: hay red, la API no responde
    online --> offline: se pierde la red
    online --> unavailable: la API deja de responder
    offline --> online: vuelve la red y la API responde
    unavailable --> online: la API vuelve a responder
```

Para no parpadear (IND-06), un cambio de red espera 1,5 segundos antes de evaluarse y no se emiten estados repetidos. Además, se vuelve a comprobar cada 30 segundos.

### Lo que muestra el indicador

| Estado | Cuándo | Segunda línea |
|---|---|---|
| Comprobando conexión | Todavía no se sabe | La última sincronización, si la hay |
| En línea | `online` | "Datos actualizados" con la hora |
| Sincronizando… | `online` y la sincronización en `syncing` | "En línea · puedes seguir navegando", con barra de progreso |
| Sin conexión | `offline` | "Datos locales · última sync" con la hora |
| Servicio no disponible | `unavailable` | "Datos locales · última sync" con la hora |

El indicador combina ícono y texto, tiene una etiqueta `Semantics` que anuncia los cambios (IND-05) y cambia con un fundido. En el detalle y en horizontal aparece en forma compacta, en la barra superior.

## 8. Estado de la pantalla del catálogo

`buildCatalogState` es una **función pura**: recibe los datos guardados, la sincronización, la conexión y el estado de las acciones, y devuelve uno de los cuatro estados sellados de `CatalogState`. Revisa los casos **en este orden**:

```mermaid
flowchart TD
    A{"¿Ya se leyó<br/>la base local?"} -- No --> L1["CatalogLoading<br/>(o CatalogError si la lectura falló)"]
    A -- Sí --> B{"¿Hay Pokémon<br/>guardados?"}
    B -- Sí --> DATA["CatalogData<br/>(se muestran aunque no haya red)"]
    B -- No --> C{"¿Sin red?"}
    C -- Sí --> EMPTY1["CatalogEmpty<br/>Sin conexión"]
    C -- No --> D{"¿La última<br/>sincronización falló?"}
    D -- Sí --> ERR1["CatalogError<br/>con su Failure"]
    D -- No --> E{"¿Terminó bien<br/>sin traer nada?"}
    E -- Sí --> EMPTY2["CatalogEmpty<br/>No hay Pokémon"]
    E -- No --> F{"¿API caída?"}
    F -- Sí --> ERR2["CatalogError<br/>ServerFailure"]
    F -- No --> L2["CatalogLoading<br/>(comprobando o descargando)"]
```

Como `CatalogState` es una clase sellada, `CatalogPage` usa un `switch` sin caso por defecto: si mañana se agrega un estado, el código no compila hasta decidir cómo mostrarlo.

## 9. Modelo de datos local

SQLite con Drift, archivo `pokedex.sqlite`, esquema versión 1. Las claves foráneas se activan con `PRAGMA foreign_keys = ON` al abrir la base.

```mermaid
erDiagram
    pokemon ||--o{ pokemon_types : "tiene"
    types ||--o{ pokemon_types : "clasifica"

    pokemon {
        int id PK "id de PokeAPI"
        int dex_number "indice pokemon_dex_number_idx"
        string name "indice pokemon_name_idx"
        string sprite_url "puede ser nulo"
        string artwork_url "puede ser nulo"
        datetime updated_at
    }
    types {
        int id PK
        string name
    }
    pokemon_types {
        int pokemon_id FK "cascada"
        int type_id FK "cascada"
        int slot "solo 1 o 2"
    }
    favorites {
        int pokemon_id PK "sin FK a proposito"
        datetime created_at
    }
    sync_metadata {
        string resource_key PK "catalog"
        datetime last_success_at
        string status "idle, syncing, success, error"
        int next_offset
        int total_remote
    }
```

- **`pokemon_types`** tiene clave primaria `(pokemon_id, slot)` y unicidad `(pokemon_id, type_id)`: un Pokémon no puede tener dos tipos en el mismo slot, ni el mismo tipo dos veces.
- **`favorites`** no tiene clave foránea hacia `pokemon` y la sincronización nunca la toca (PS-11): los datos del usuario no dependen de lo que pase con el catálogo.
- **`sync_metadata`** guarda el estado de cada recurso; hoy solo existe `catalog`.
- **Las imágenes no están en la base:** las guarda en disco `cached_network_image` la primera vez que se muestran.

## 10. Modelo de errores

Los errores técnicos nunca llegan a la pantalla tal cual: la capa de datos los traduce a uno de los cuatro tipos de la clase sellada `Failure`.

| Situación técnica | `Failure` | Mensaje para el usuario |
|---|---|---|
| Sin red o sin DNS (`NetworkException`, `SocketException`) | `NetworkFailure` | "Sin conexión a Internet" |
| La consulta superó los 10 s | `TimeoutFailure` | "El servidor tardó demasiado en responder" |
| Error GraphQL, respuesta vacía o con formato inválido | `ServerFailure` | "El servicio de Pokémon respondió con un error" |
| Cualquier otra cosa | `UnknownFailure` | "Ocurrió un error inesperado" |

`ErrorView` elige el ícono y el título según el tipo de `Failure`, con un `switch` que el compilador obliga a completar.

## 11. Decisiones y límites actuales

**Decisiones registradas:**
- [ADR-0001: Drift como fuente de verdad](adr/0001-drift-como-fuente-de-verdad.md)
- [ADR-0002: Riverpod para estado e inyección de dependencias](adr/0002-riverpod-estado-e-inyeccion.md)

**Límites de esta versión** (se resuelven en la entrega final):
- No hay reintentos automáticos con backoff ni manejo específico de la limitación de peticiones.
- Los datos del catálogo alterados en la base se restauran al abrir la app y al volver la conexión, pero todavía falta comprobarlos al abrir el detalle y periódicamente (OF-20).
- El detalle completo, los favoritos, la búsqueda, los filtros y la trivia todavía no existen.
