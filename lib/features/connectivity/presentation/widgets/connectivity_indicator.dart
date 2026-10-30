import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../../pokemon/domain/entities/catalog_sync_status.dart';
import '../../domain/entities/service_status.dart';

/// Indicador de conectividad (IND-01): dice si hay conexión y de dónde salen
/// los datos que se ven.
///
/// - Normal: tarjeta bajo la barra superior, con ícono, estado y una segunda
///   línea con el origen y la hora de los datos.
/// - [compact]: pastilla para la barra superior de otras páginas (detalle).
///
/// El estado de la red lo lee de [serviceStatusProvider]. La sincronización
/// llega por parámetro ([syncStatus]) desde quien la escucha, para que este
/// widget no dependa del repositorio del catálogo.
class ConnectivityIndicator extends ConsumerWidget {
  const ConnectivityIndicator({
    super.key,
    this.syncStatus,
    this.compact = false,
  });

  /// null mientras no se sabe nada de la sincronización.
  final CatalogSyncStatus? syncStatus;

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mientras el stream no emite, o si fallara, se muestra "Comprobando".
    final status =
        ref.watch(serviceStatusProvider).value ?? ServiceStatus.checking;
    final look = _IndicatorLook.from(status, syncStatus);
    final colors = look.colorsFor(Theme.of(context).brightness);

    return Semantics(
      container: true,
      liveRegion: true,
      label: '${look.title}. ${look.detail}',
      child: ExcludeSemantics(
        // Cambia de estado con un fundido en vez de un salto brusco.
        child: AnimatedSwitcher(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : const Duration(milliseconds: 250),
          child: compact
              ? _IndicatorPill(
                  key: ValueKey(look.kind),
                  look: look,
                  colors: colors,
                )
              : _IndicatorCard(
                  key: ValueKey(look.kind),
                  look: look,
                  colors: colors,
                ),
        ),
      ),
    );
  }
}

class _IndicatorCard extends StatelessWidget {
  const _IndicatorCard({super.key, required this.look, required this.colors});

  final _IndicatorLook look;
  final _Colors colors;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(look.icon, size: 22, color: colors.foreground),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      look.title,
                      style: text.titleSmall?.copyWith(
                        color: colors.foreground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      look.detail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodySmall?.copyWith(color: colors.foreground),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (look.kind == _Kind.syncing) ...[
            const SizedBox(height: 10),
            // Indeterminada: no sabemos cuánto tarda PokeAPI.
            LinearProgressIndicator(
              minHeight: 4,
              borderRadius: BorderRadius.circular(2),
              color: colors.foreground,
              backgroundColor: colors.foreground.withValues(alpha: 0.2),
            ),
          ],
        ],
      ),
    );
  }
}

/// Versión corta: ícono + "En línea · 10:42".
class _IndicatorPill extends StatelessWidget {
  const _IndicatorPill({super.key, required this.look, required this.colors});

  final _IndicatorLook look;
  final _Colors colors;

  @override
  Widget build(BuildContext context) {
    final label = look.time == null
        ? look.title
        : '${look.title} · ${look.time}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(look.icon, size: 16, color: colors.foreground),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colors.foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

enum _Kind { checking, online, syncing, offline, unavailable }

/// Un par de colores: fondo y texto.
typedef _Colors = ({Color background, Color foreground});

/// Todo lo que cambia entre estados: colores, ícono y textos.
class _IndicatorLook {
  const _IndicatorLook({
    required this.kind,
    required this.icon,
    required this.title,
    required this.detail,
    required this.time,
    required this.light,
  });

  final _Kind kind;
  final IconData icon;
  final String title;
  final String detail;

  /// Hora de los datos para la pastilla, o null si no hay.
  final String? time;

  /// Colores del tema claro (los del diseño).
  final _Colors light;

  static const _green = (
    background: Color(0xFFDCEFD9),
    foreground: Color(0xFF1B4D1D),
  );
  static const _grey = (
    background: Color(0xFFECE4E3),
    foreground: Color(0xFF3A3030),
  );
  static const _blue = (
    background: Color(0xFFDCE4F7),
    foreground: Color(0xFF1F3A6B),
  );
  static const _amber = (
    background: Color(0xFFFBE7C6),
    foreground: Color(0xFF4E3300),
  );

  /// En oscuro se invierte el par: fondo apagado del mismo tono y texto
  /// claro, igual que los chips de tipo.
  _Colors colorsFor(Brightness brightness) => brightness == Brightness.dark
      ? (
          background: Color.lerp(
            light.foreground,
            const Color(0xFF1A1111),
            0.45,
          )!,
          foreground: light.background,
        )
      : light;

  factory _IndicatorLook.from(ServiceStatus status, CatalogSyncStatus? sync) {
    final lastSync = sync?.lastSyncedAt;
    final time = lastSync == null ? null : _formatTime(lastSync);
    final savedData = time == null
        ? 'Aún no hay datos guardados'
        : 'Datos locales · última sync $time';

    // Sincronizando solo tiene sentido si la API responde.
    if (status == ServiceStatus.online && sync?.state == SyncState.syncing) {
      return _IndicatorLook(
        kind: _Kind.syncing,
        icon: Icons.sync_rounded,
        title: 'Sincronizando…',
        detail: 'En línea · puedes seguir navegando',
        time: null,
        light: _blue,
      );
    }

    return switch (status) {
      ServiceStatus.checking => _IndicatorLook(
        kind: _Kind.checking,
        icon: Icons.wifi_find_rounded,
        title: 'Comprobando conexión',
        detail: savedData,
        time: null,
        light: _grey,
      ),
      ServiceStatus.online => _IndicatorLook(
        kind: _Kind.online,
        icon: Icons.check_circle_outline_rounded,
        title: 'En línea',
        detail: switch ((sync?.state, time)) {
          (SyncState.error, null) => 'No se pudo descargar el catálogo',
          (SyncState.error, final String t) =>
            'No se pudo actualizar · datos de $t',
          (_, final String t) => 'Datos actualizados · $t',
          _ => 'Conectado a PokeAPI',
        },
        time: time,
        light: _green,
      ),
      ServiceStatus.offline => _IndicatorLook(
        kind: _Kind.offline,
        icon: Icons.wifi_off_rounded,
        title: 'Sin conexión',
        detail: savedData,
        time: time,
        light: _grey,
      ),
      ServiceStatus.unavailable => _IndicatorLook(
        kind: _Kind.unavailable,
        icon: Icons.cloud_off_rounded,
        title: 'Servicio no disponible',
        detail: savedData,
        time: time,
        light: _amber,
      ),
    };
  }

  /// "09:15" si fue hoy; "28/10 09:15" si fue otro día.
  static String _formatTime(DateTime at) {
    final local = at.toLocal();
    final now = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    final time = '${two(local.hour)}:${two(local.minute)}';
    final sameDay =
        local.year == now.year &&
        local.month == now.month &&
        local.day == now.day;
    return sameDay ? time : '${two(local.day)}/${two(local.month)} $time';
  }
}
