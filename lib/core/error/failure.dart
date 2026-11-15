/// Jerarquia de errores de la app: los que entiende la capa de dominio.
/// La capa de data traduce los errores tecnicos a uno de estos tipos.
sealed class Failure {
  final String message;

  const Failure(this.message);
}

/// Desconexion: no se pudo llegar al servidor.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sin conexión a Internet']);
}

/// Demora: el servidor no respondio a tiempo.
final class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message = 'El servidor tardó demasiado en responder',
  ]);
}

/// Averia: el servidor respondio con un error o algo que no se entiende.
final class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'El servicio de Pokémon respondió con un error',
  ]);
}

/// Imprevisto: un error que no se sabe clasificar.
final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Ocurrió un error inesperado']);
}
