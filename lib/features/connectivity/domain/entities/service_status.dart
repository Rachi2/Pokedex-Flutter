/// Semaforo del servicio remoto (PokeAPI): si se puede llegar a la API.
/// No incluye la sincronización, que se modela aparte.
enum ServiceStatus {
  /// La app esta comprobando el estado
  checking,

  /// Hay red y la API respondio
  online,

  /// No hay red
  offline,

  /// Hay red pero la API no responde o falla
  unavailable;

  /// Paso libre: true solo si se pueden hacer consultas a la API.
  bool get canReachApi => this == ServiceStatus.online;
}
