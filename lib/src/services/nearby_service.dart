import 'package:nearby_nocard/app_exports.dart';
import 'package:nearby_connections/nearby_connections.dart';

class NearbySingleton {
  static final NearbySingleton _singleton = NearbySingleton._internal();
  static final Nearby _nearby = Nearby();

  factory NearbySingleton() {
    return _singleton;
  }

  NearbySingleton._internal();

  static Nearby get instance {
    return _nearby;
  }

  Future<bool> startAdvertising({
    required String userName,
    required Strategy strategy,
    void Function(String, ConnectionInfo)? onConnectionInitiated,
    void Function(String, Status)? onConnectionResult,
    void Function(String)? onDisconnected,
    String? serviceId,
  }) async {
    try {
      return await _nearby.startAdvertising(
        userName,
        strategy,
        onConnectionInitiated:
            onConnectionInitiated ?? _onAdvertisingConnectionInitiated,
        onConnectionResult:
            onConnectionResult ?? _onAdvertisingConnectionResult,
        onDisconnected: onDisconnected ?? _onAdvertisingDisconnected,
        serviceId: serviceId ?? "com.ramyam.nocardapp",
      );
    } catch (exception) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      rethrow;
    }
  }

  Future<bool> startDiscovery({
    required String userName,
    required Strategy strategy,
    void Function(String endpointId, String endpointName, String serviceId)?
        onEndpointFound,
    void Function(String?)? onEndpointLost,
    String? serviceId,
  }) async {
    try {
      return await _nearby.startDiscovery(
        userName,
        strategy,
        onEndpointFound: onEndpointFound ?? _onEndpointFound,
        onEndpointLost: onEndpointLost ?? _onEndpointLost,
        serviceId: serviceId ?? "com.ramyam.nocardapp",
      );
    } catch (exception) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      rethrow;
    }
  }

  Future<bool> requestConnection(
      {required String username,
      required String id,
      void Function(String, ConnectionInfo)? onConnectionInitiated,
      void Function(String, Status)? onConnectionResult,
      void Function(String)? onDisconnected}) async {
    try {
      return await _nearby.requestConnection(username, id,
          onConnectionInitiated:
              onConnectionInitiated ?? _onRequestConnectionInitiated,
          onConnectionResult: onConnectionResult ?? _onRequestConnectionResult,
          onDisconnected: onDisconnected ?? _onRequestDisconnected);
    } catch (exception) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      rethrow;
    }
  }

  Future<bool> acceptConnection({
    required String id,
    void Function(String endpointId, Payload payload)? onPayLoadRecieved,
    void Function(
            String endpointId, PayloadTransferUpdate payloadTransferUpdate)?
        onPayloadTransferUpdate,
  }) async {
    return await _nearby.acceptConnection(id,
        onPayLoadRecieved: onPayLoadRecieved ?? _onPayloadReceived,
        onPayloadTransferUpdate:
            onPayloadTransferUpdate ?? _onPayloadTransferUpdate);
  }

  void _onAdvertisingConnectionInitiated(String id, ConnectionInfo info) {
    // Called whenever a discoverer requests connection
  }

  void _onAdvertisingConnectionResult(String id, Status status) {
    // Called when connection is accepted/rejected
  }

  void _onAdvertisingDisconnected(String id) {
    // Called whenever a discoverer disconnects from advertiser
  }

  void _onRequestConnectionInitiated(String id, ConnectionInfo info) {
    // Called whenever a discoverer requests connection
  }

  void _onRequestConnectionResult(String id, Status status) {
    // Called when connection is accepted/rejected
  }

  void _onRequestDisconnected(String id) {
    // Called whenever a discoverer disconnects from advertiser
  }

  void _onEndpointFound(String id, String userName, String serviceId) {}

  void _onEndpointLost(String? endpointId) {}

  void _onPayloadReceived(String id, Payload payload) {}

  void _onPayloadTransferUpdate(
      String endpointId, PayloadTransferUpdate payloadTransferUpdate) {}
}
