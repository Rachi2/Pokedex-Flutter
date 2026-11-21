import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:pokedex/core/error/failure.dart';

/// Paciencia ante fallas pasajeras: reintentos con backoff exponencial.
///
/// Con los valores por defecto hace hasta 4 intentos en total y espera
/// 1 s, 2 s y 4 s entre ellos (nunca mas de [maxDelay]).
class RetryPolicy {
  const RetryPolicy({
    this.maxAttempts = 4,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 8),
    this.maxRetryAfter = const Duration(seconds: 30),
    this.wait = _sleep,
  });

  /// Intentos en total, contando el primero.
  final int maxAttempts;

  /// Espera antes del primer reintento; despues se duplica.
  final Duration initialDelay;

  /// Tope de la espera entre intentos.
  final Duration maxDelay;

  /// Lo maximo que se respeta del Retry-After de un 429.
  final Duration maxRetryAfter;

  /// Como se espera. Las pruebas pasan una que no espera de verdad.
  final Future<void> Function(Duration) wait;

  /// Escalera de esperas: 1 s, 2 s, 4 s... para el reintento [retry] (desde 1).
  Duration delayFor(int retry) {
    final millis = initialDelay.inMilliseconds * pow(2, retry - 1);
    return Duration(milliseconds: min(millis.toInt(), maxDelay.inMilliseconds));
  }

  /// Insistencia: ejecuta [action] y la repite si falla con un error que
  /// [retryIf] acepta, hasta [maxAttempts] intentos. Cada reintento se
  /// escribe en consola. Si se acaban los intentos, lanza el ultimo error.
  Future<T> run<T>(
    Future<T> Function() action, {
    bool Function(Object error) retryIf = isTransient,
    String label = 'Operacion',
  }) async {
    for (var attempt = 1; ; attempt++) {
      try {
        return await action();
      } catch (error) {
        if (attempt >= maxAttempts || !retryIf(error)) rethrow;

        var delay = delayFor(attempt);
        // Tope: si PokeAPI pidio esperar mas (HTTP 429), se respeta,
        // pero nunca mas de [maxRetryAfter].
        if (error is RateLimitFailure && error.retryAfter != null) {
          final asked = error.retryAfter! < maxRetryAfter
              ? error.retryAfter!
              : maxRetryAfter;
          if (asked > delay) delay = asked;
        }
        debugPrint(
          '[Retry] $label: intento $attempt de $maxAttempts fallo '
          '(${error.runtimeType}). Reintento en ${delay.inMilliseconds} ms',
        );
        await wait(delay);
      }
    }
  }

  /// Pasajero: errores que pueden arreglarse solos si se vuelve a intentar.
  ///
  /// NetworkFailure no se reintenta: sin red no sirve insistir, y la
  /// descarga se retoma sola cuando vuelve la conexion.
  static bool isTransient(Object error) =>
      error is TimeoutFailure || error is ServerFailure;
}

Future<void> _sleep(Duration delay) => Future<void>.delayed(delay);
