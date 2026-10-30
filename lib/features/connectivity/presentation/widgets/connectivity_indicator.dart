import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../../pokemon/domain/entities/catalog_sync_status.dart';
import '../../domain/entities/service_status.dart';

/// Banda fija bajo la barra superior (IND-01) que dice si hay conexión y de
/// dónde salen los datos que se ven.
///
/// El estado de la red lo lee de [serviceStatusProvider]. La sincronización
/// llega por parámetro ([syncStatus]) desde quien la escucha (el app_shell),
/// para que este widget no dependa del repositorio del catálogo.
class ConnectivityIndicator extends ConsumerWidget {
  const ConnectivityIndicator({super.key, this.syncStatus});

  /// null mientras no se sabe nada de la sincronización.
  final CatalogSyncStatus? syncStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mientras el stream no emite, o si fallara, se muestra "Comprobando".
    final status =
        ref.watch(serviceStatusProvider).value ?? ServiceStatus.checking;
    final look = _IndicatorLook.from(status, syncStatus);

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
          child: _IndicatorBand(key: ValueKey(look.kind), look: look),
        ),
      ),
    );
  }
}

class _IndicatorBand extends StatelessWidget {
  const _IndicatorBand({super.key, required this.look});

  final _IndicatorLook look;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Material(
      color: look.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                Icon(look.icon, size: 20, color: look.foreground),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        look.title,
                        style: text.labelLarge?.copyWith(
                          color: look.foreground,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        look.detail,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.bodySmall?.copyWith(color: look.foreground),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (look.kind == _Kind.syncing)
            LinearProgressIndicator(
              minHeight: 2,
              color: look.foreground,
              backgroundColor: Colors.transparent,
            ),
        ],
      ),
    );
  }
}

enum _Kind { checking, online, syncing, offline, unavailable }

/// Todo lo que cambia entre estados: colores, ícono y textos.
class _IndicatorLook {
  const _IndicatorLook({
    required this.kind,
    required this.icon,
    required this.title,
    required this.detail,
    required this.background,
    required this.foreground,
  });

  final _Kind kind;
  final IconData icon;
  final String title;
  final String detail;
  final Color background;
  final Color foreground;

  static const _green = (Color(0xFFDCEFD9), Color(0xFF1B4D1D));
  static const _grey = (Color(0xFFECE4E3), Color(0xFF3A3030));
  static const _blue = (Color(0xFFDCE4F7), Color(0xFF1F3A6B));
  static const _amber = (Color(0xFFFBE7C6), Color(0xFF4E3300));

  factory _IndicatorLook.from(ServiceStatus status, CatalogSyncStatus? sync) {
    final lastSync = sync?.lastSyncedAt;
    final savedData = lastSync == null
        ? 'Aún no hay datos guardados'
        : 'Datos locales · última sync ${_formatTime(lastSync)}';

    // Sincronizando solo tiene sentido si la API responde.
    if (status == ServiceStatus.online && sync?.state == SyncState.syncing) {
      return _build(
        _Kind.syncing,
        Icons.sync_rounded,
        'Sincronizando',
        'Descargando Pokémon de PokeAPI',
        _blue,
      );
    }

    return switch (status) {
      ServiceStatus.checking => _build(
        _Kind.checking,
        Icons.wifi_find_rounded,
        'Comprobando conexión',
        savedData,
        _grey,
      ),
      ServiceStatus.online => _build(
        _Kind.online,
        Icons.wifi_rounded,
        'En línea',
        switch ((sync?.state, lastSync)) {
          (SyncState.error, null) => 'No se pudo descargar el catálogo',
          (SyncState.error, final DateTime at) =>
            'No se pudo actualizar · datos de ${_formatTime(at)}',
          (_, final DateTime at) => 'Datos actualizados · ${_formatTime(at)}',
          _ => 'Conectado a PokeAPI',
        },
        _green,
      ),
      ServiceStatus.offline => _build(
        _Kind.offline,
        Icons.wifi_off_rounded,
        'Sin conexión',
        savedData,
        _grey,
      ),
      ServiceStatus.unavailable => _build(
        _Kind.unavailable,
        Icons.cloud_off_rounded,
        'Servicio no disponible',
        savedData,
        _amber,
      ),
    };
  }

  static _IndicatorLook _build(
    _Kind kind,
    IconData icon,
    String title,
    String detail,
    (Color, Color) colors,
  ) => _IndicatorLook(
    kind: kind,
    icon: icon,
    title: title,
    detail: detail,
    background: colors.$1,
    foreground: colors.$2,
  );

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
