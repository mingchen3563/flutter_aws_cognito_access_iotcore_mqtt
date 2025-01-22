import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/mqtt_server_client_build_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  late MqttServerClientBuildUsecase usecase;

  setUp(() {
    usecase = MqttServerClientBuildUsecase();
  });

  test('測試建立 MqttServerClient', () {
    // arrange
    final credentials = MqttClientCredentials(
      accessKey: 'test-access-key',
      secretKey: 'test-secret-key',
      sessionToken: 'test-session-token',
      identityId: 'test-identity-id',
    );
    final path = MqttClientPath(
      endpoint: 'test-endpoint',
      region: 'test-region',
      policyName: 'test-policy-name',
    );
    final behavior = MqttClientBehavior.defaultBehavior();
    final options = MqttClientOptions.defaultOptions();

    // act
    final client = usecase.build(
      credentials: credentials,
      path: path,
      behavior: behavior,
      options: options,
    );

    // assert
    expect(client, isA<MqttServerClient>());
    expect(client.clientIdentifier, 'test-identity-id');
    expect(client.useWebSocket, isTrue);
    expect(client.secure, isFalse);
    expect(client.autoReconnect, isTrue);
    expect(client.disconnectOnNoResponsePeriod,
        options.disconnectOnNoResponsePeriod);
    expect(client.keepAlivePeriod, options.keepAlivePeriod);
    expect(client.maxConnectionAttempts, options.maxConnectionAttempts);
  });

  test('測試建立 MqttServerClient 失敗時應拋出異常', () {
    // arrange
    final credentials = MqttClientCredentials(
      accessKey: '',
      secretKey: '',
      sessionToken: '',
      identityId: '',
    );
    final path = MqttClientPath(
      endpoint: '',
      region: '',
      policyName: '',
    );
    final behavior = MqttClientBehavior.defaultBehavior();
    final options = MqttClientOptions.defaultOptions();

    // act & assert
    expect(
      () => usecase.build(
        credentials: credentials,
        path: path,
        behavior: behavior,
        options: options,
      ),
      throwsException,
    );
  });
}
