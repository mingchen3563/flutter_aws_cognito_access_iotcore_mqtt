import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/connect_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/aws_service_repository.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'connect_usecase_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MqttClient>(),
  MockSpec<AwsServiceRepository>(),
  MockSpec<MqttClientRepository>()
])
void main() {
  late ConnectUsecase usecase;

  late MockAwsServiceRepository mockAwsServiceRepository;
  late MockMqttClientRepository mockMqttClientRepository;
  late MqttClientPath path;
  late MqttClientCredentials credentials;

  setUp(() {
    mockAwsServiceRepository = MockAwsServiceRepository();
    mockMqttClientRepository = MockMqttClientRepository();
    path = MqttClientPath(
      endpoint: 'test-endpoint',
      region: 'test-region',
      policyName: 'test-policy',
    );
    credentials = MqttClientCredentials(
      accessKey: 'test-access-key',
      secretKey: 'test-secret-key',
      sessionToken: 'test-session-token',
      identityId: 'test-identity-id',
    );
    usecase = ConnectUsecase(
      path: path,
      credentials: credentials,
      awsServiceRepository: mockAwsServiceRepository,
      mqttClientRepository: mockMqttClientRepository,
    );
  });

  group('ConnectUsecase', () {
    test('當所有操作都成功時，應該返回 true', () async {
      // Arrange
      when(mockAwsServiceRepository.attachPolicy(
        accessKey: anyNamed('accessKey'),
        secretKey: anyNamed('secretKey'),
        sessionToken: anyNamed('sessionToken'),
        identityId: anyNamed('identityId'),
        region: anyNamed('region'),
        policyName: anyNamed('policyName'),
      )).thenAnswer((_) async => true);
      when(mockMqttClientRepository.connect()).thenAnswer((_) async => true);

      // Act
      final result = await usecase();

      // Assert
      expect(result, true);
      verify(mockAwsServiceRepository.attachPolicy(
        accessKey: credentials.accessKey,
        secretKey: credentials.secretKey,
        sessionToken: credentials.sessionToken,
        identityId: credentials.identityId,
        region: path.region,
        policyName: path.policyName,
      )).called(1);
      verify(mockMqttClientRepository.connect()).called(1);
    });

    test('當 attachPolicy 失敗時，應該拋出異常', () async {
      // Arrange
      when(mockAwsServiceRepository.attachPolicy(
        accessKey: anyNamed('accessKey'),
        secretKey: anyNamed('secretKey'),
        sessionToken: anyNamed('sessionToken'),
        identityId: anyNamed('identityId'),
        region: anyNamed('region'),
        policyName: anyNamed('policyName'),
      )).thenThrow(Exception('Failed to attach policy'));

      // Act & Assert
      expect(() => usecase(), throwsException);
      verify(mockAwsServiceRepository.attachPolicy(
        accessKey: credentials.accessKey,
        secretKey: credentials.secretKey,
        sessionToken: credentials.sessionToken,
        identityId: credentials.identityId,
        region: path.region,
        policyName: path.policyName,
      )).called(1);
      verifyNever(mockMqttClientRepository.connect());
    });

    test('當 mqtt attach policy 失敗時，應該拋出異常', () async {
      // Arrange
      when(mockAwsServiceRepository.attachPolicy(
        accessKey: anyNamed('accessKey'),
        secretKey: anyNamed('secretKey'),
        sessionToken: anyNamed('sessionToken'),
        identityId: anyNamed('identityId'),
        region: anyNamed('region'),
        policyName: anyNamed('policyName'),
      )).thenAnswer((_) async => false);
      when(mockMqttClientRepository.connect())
          .thenThrow(Exception('Failed to connect to mqtt'));

      // Act & Assert
      expect(() => usecase(), throwsException);
      verify(mockAwsServiceRepository.attachPolicy(
        accessKey: credentials.accessKey,
        secretKey: credentials.secretKey,
        sessionToken: credentials.sessionToken,
        identityId: credentials.identityId,
        region: path.region,
        policyName: path.policyName,
      )).called(1);
      verifyNever(mockMqttClientRepository.connect());
    });
  });
}
