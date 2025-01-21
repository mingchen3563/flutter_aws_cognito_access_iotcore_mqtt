import 'package:mqtt_client/mqtt_client.dart';

class MqttClientOptions {
  final int disconnectOnNoResponsePeriod;
  final int keepAlivePeriod;
  final int maxConnectionAttempts;
  final MqttQos qos;

  MqttClientOptions({
    required this.disconnectOnNoResponsePeriod,
    required this.keepAlivePeriod,
    required this.maxConnectionAttempts,
    required this.qos,
  });

  factory MqttClientOptions.defaultOptions() {
    return MqttClientOptions(
      disconnectOnNoResponsePeriod: 90,
      keepAlivePeriod: 30,
      maxConnectionAttempts: 2,
      qos: MqttQos.atMostOnce,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MqttClientOptions &&
      other.disconnectOnNoResponsePeriod == disconnectOnNoResponsePeriod &&
      other.keepAlivePeriod == keepAlivePeriod &&
      other.maxConnectionAttempts == maxConnectionAttempts;

  @override
  int get hashCode =>
      disconnectOnNoResponsePeriod.hashCode ^
      keepAlivePeriod.hashCode ^
      maxConnectionAttempts.hashCode;
}
