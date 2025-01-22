import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:get_it/get_it.dart';

class PublishToTopicUsecase {
  final MqttClientRepository mqttClientRepository;
  final MqttClientOptions options;

  PublishToTopicUsecase({
    MqttClientRepository? mqttClientRepository,
    required this.options,
  }) : mqttClientRepository =
            mqttClientRepository ?? GetIt.I.get<MqttClientRepository>();

  /// return a message id
  Future<int> publish({required String message, required String topic}) async {
    return mqttClientRepository.publish(topic, message, options.qos);
  }
}
