import 'package:mqtt_client/mqtt_client.dart';

abstract class MqttClientRepository {
  Future<bool> connect();
  Future<void> disconnect();
  int publish(String topic, String message, MqttQos qos);
  Subscription? subscribe(String topic, MqttQos qos);
  void unsubscribe(String topic);
}
