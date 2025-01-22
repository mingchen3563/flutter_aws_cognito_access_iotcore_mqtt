import 'dart:developer';

import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/data_sources/remote_aws_data_source.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/repositories/aws_service_repository_impl.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/aws_service_repository.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:get_it/get_it.dart';

class ConnectUsecase {
  final MqttClientPath path;
  final MqttClientCredentials credentials;
  final AwsServiceRepository awsServiceRepository;
  final MqttClientRepository mqttClientRepository;
  ConnectUsecase({
    required this.path,
    required this.credentials,
    AwsServiceRepository? awsServiceRepository,
    MqttClientRepository? mqttClientRepository,
  })  : awsServiceRepository = awsServiceRepository ??
            AwsServiceRepositoryImpl(
              remoteAwsDataSource: RemoteAwsDataSource(),
            ),
        mqttClientRepository =
            mqttClientRepository ?? GetIt.I.get<MqttClientRepository>();

  Future<bool> call() async {
    // 先 attach policy
    try {
      await awsServiceRepository.attachPolicy(
        accessKey: credentials.accessKey,
        secretKey: credentials.secretKey,
        sessionToken: credentials.sessionToken,
        identityId: credentials.identityId,
        region: path.region,
        policyName: path.policyName,
      );
    } catch (e) {
      log('Failed to attach policy: $e');
      throw Exception('Failed to attach policy');
    }
    // 再連接 mqtt
    try {
      return await mqttClientRepository.connect();
    } catch (e, s) {
      log('Failed to connect to mqtt: $e', error: e, stackTrace: s);
      throw Exception('Failed to connect to mqtt');
    }
  }
}
