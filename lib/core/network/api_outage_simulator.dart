import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

/// Simulacro de API caida: interruptor de depuracion que hace fallar todas
/// las consultas a PokeAPI aunque haya red.
///
/// Sirve para mostrar en la demo los reintentos, el indicador en
/// "Servicio no disponible" y la app funcionando con los datos guardados.
/// En una version de produccion no hace nada.
final apiOutageSimulatorProvider = NotifierProvider<ApiOutageSimulator, bool>(
  ApiOutageSimulator.new,
);

class ApiOutageSimulator extends Notifier<bool> {
  @override
  bool build() => false;

  /// Conmutador: enciende o apaga el simulacro (solo en modo depuracion).
  void setEnabled(bool enabled) {
    if (!kDebugMode) return;
    state = enabled;
    debugPrint('[Simulador] API caida ${enabled ? 'activada' : 'desactivada'}');
  }
}

/// Barrera del simulacro: Link que, con el simulacro encendido, corta cada
/// consulta antes de que salga, como si PokeAPI respondiera 503.
class OutageLink extends Link {
  OutageLink(this._isOutage);

  final bool Function() _isOutage;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    if (_isOutage()) {
      debugPrint('[Simulador] Consulta bloqueada: API caida simulada');
      return Stream.error(
        const ServerException(parsedResponse: null, statusCode: 503),
      );
    }
    return forward!(request);
  }
}
