import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MqttClientRepositoryImpl implements MqttClientRepository {
  final MqttClient client;
  final MqttClientPayloadBuilder mqttClientPayloadBuilder;
  MqttClientRepositoryImpl({
    MqttClient? client,
    MqttClientPayloadBuilder? mqttClientPayloadBuilder,
  })  : client = client ?? GetIt.I.get<MqttClient>(),
        mqttClientPayloadBuilder =
            mqttClientPayloadBuilder ?? MqttClientPayloadBuilder();
  @override
  Future<bool> connect() async {
    var result = await client.connect();
    return result?.state == MqttConnectionState.connected;
  }

  @override
  Future<void> disconnect() async {
    client.disconnect();
  }

  @override
  int publish(String topic, String message, MqttQos qos) {
    final builder = mqttClientPayloadBuilder;
    builder.addString(message);

    if (builder.payload case var payload?) {
      final messageId = client.publishMessage(topic, qos, payload);
      return messageId;
    } else {
      throw Exception('Payload is null');
    }
  }

  @override
  Subscription? subscribe(String topic, MqttQos qos) {
    return client.subscribe(topic, qos);
  }

  @override
  void unsubscribe(String topic) {
    client.unsubscribe(topic, expectAcknowledge: true);
  }
}
