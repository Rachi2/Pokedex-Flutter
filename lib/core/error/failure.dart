/// Error de la app que entiende la capa de dominio. La capa de data
/// traduce los errroes tecnicos a uno de estos tipos
sealed class Failure {
  final String message;

  const Failure(this.message);
}

// Error sobre el internet
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sin conexión a Internet']);
}

// Error de duracion para respuesta
final class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message = 'El servidor tardó demasiado en responder',
  ]);
}

// Fallos en el servidor
final class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'El servicio de Pokémon respondió con un error',
  ]);
}

// Errores desconocidos
final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Ocurrió un error inesperado']);
}
