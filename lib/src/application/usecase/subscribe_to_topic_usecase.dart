import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/repositories/mqtt_client_repository_impl.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:mqtt_client/mqtt_client.dart';

class SubscribeToTopicUsecase {
  final MqttClientRepository mqttClientRepository;
  final MqttClientOptions options;
  SubscribeToTopicUsecase({
    MqttClientRepository? mqttClientRepository,
    required this.options,
  }) : mqttClientRepository =
            mqttClientRepository ?? MqttClientRepositoryImpl();

  Subscription subscribe(String topic) {
    var subResult = mqttClientRepository.subscribe(topic, options.qos);
    if (subResult == null) {
      throw Exception('Failed to subscribe to topic');
    }
    return subResult;
  }
}
