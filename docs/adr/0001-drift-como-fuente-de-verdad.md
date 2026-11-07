# ADR-0001: Drift como fuente de verdad

- **Estado:** Aceptado
- **Fecha de registro:** 2026-11-06

## Contexto

La aplicación debe funcionar con y sin conexión. El enunciado exige que la interfaz lea de una persistencia local observable (OF-16, OF-17) y aclara que una caché de respuestas de red no satisface el proyecto (§6.5): las búsquedas, los filtros y el orden deben funcionar sin red sobre datos locales, incluso en consultas que nunca se hicieron antes.

También se necesita guardar datos del usuario, como los favoritos, que no existen en PokeAPI y no deben verse afectados por la sincronización (PS-11). Además, cada página se guarda junto con sus metadatos, y una interrupción no debe dejar datos a medias (RNF-RES-04).

## Decisión

Usar **SQLite con Drift** como única fuente de lectura de la interfaz, y desactivar la caché del cliente GraphQL con `FetchPolicy.noCache`.

El flujo es siempre el mismo: la respuesta remota se valida, se guarda en una transacción, y la interfaz recibe el cambio a través de un stream de Drift. Ningún widget usa una respuesta GraphQL.

## Alternativas consideradas

| Alternativa | Ventaja | Por qué no se eligió |
|---|---|---|
| **Caché del cliente GraphQL** | Casi no requiere código | Guarda respuestas, no un modelo consultable. Sin red solo responde a consultas ya hechas, y es justo lo que el enunciado descarta. Tampoco es un buen lugar para los favoritos |
| **`sqflite`** | SQLite directo y muy conocido | SQL escrito a mano y sin verificación de tipos. Para observar cambios habría que construir los streams por nuestra cuenta |
| **Base de documentos (Hive, Isar u otra)** | API sencilla, sin escribir SQL | El catálogo tiene relaciones claras (Pokémon-tipos) y restricciones que una base relacional expresa de forma directa: claves foráneas, unicidad, `CHECK` e índices |

## Consecuencias

**Positivas**

- Las pantallas se actualizan solas cuando cambia la base, sin importar quién la cambió.
- El comportamiento con y sin conexión es el mismo código: la interfaz siempre lee de la base.
- Las restricciones de la base y el `upsert` evitan duplicados.
- Las transacciones impiden que quede una página guardada a medias.
- Filtrar y ordenar con SQL e índices queda disponible para la entrega final.

**Negativas**

- Requiere generación de código (`build_runner`) cada vez que cambian las tablas. Los `.g.dart` se guardan en el repositorio.
- Hay tres formas de un mismo Pokémon (DTO, fila de Drift y entidad), con sus mapeadores.
- Cada cambio de esquema exige escribir una migración.
- Las imágenes no están en la base. Se guardan aparte, con `cached_network_image`, así que hay que definir su límite y su limpieza por separado (PS-08).
