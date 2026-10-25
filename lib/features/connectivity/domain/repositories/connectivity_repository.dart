import '../entities/service_status.dart';

/// Contrato para consultar la disponibilidad del servicio remoto.
/// La implementación vive en la capa data
abstract interface class ConnectivityRepository {
  /// Emite el estado actual y un valor nuevo cada vez que cambia
  Stream<ServiceStatus> watchStatus();

  /// Comprueba el valor del estado al momento y entrega el resultado
  Future<ServiceStatus> checkNow();
}
