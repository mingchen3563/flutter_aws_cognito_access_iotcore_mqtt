import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:get_it/get_it.dart';

class UnsubscribeToTopicUsecase {
  final MqttClientRepository mqttClientRepository;
  final MqttClientOptions options;

  UnsubscribeToTopicUsecase({
    MqttClientRepository? mqttClientRepository,
    required this.options,
  }) : mqttClientRepository =
            mqttClientRepository ?? GetIt.I.get<MqttClientRepository>();

  void unsubscribe({required String topic}) {
    mqttClientRepository.unsubscribe(topic);
  }
}
