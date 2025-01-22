import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:get_it/get_it.dart';

class DisconnectUsecase {
  final MqttClientRepository mqttClientRepository;

  DisconnectUsecase({
    MqttClientRepository? mqttClientRepository,
  }) : mqttClientRepository =
            mqttClientRepository ?? GetIt.I.get<MqttClientRepository>();

  void disconnect() {
    mqttClientRepository.disconnect();
  }
}
