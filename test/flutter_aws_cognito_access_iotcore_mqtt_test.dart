import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/connect_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/disconnect_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/publish_to_topic_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/subscribe_to_topic_usecase.dart';

import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/mqtt_server_client_build_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/unsubscribe_to_topic_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'flutter_aws_cognito_access_iotcore_mqtt_test.mocks.dart';

@GenerateMocks([
  MqttServerClientBuildUsecase,
  ConnectUsecase,
  DisconnectUsecase,
  SubscribeToTopicUsecase,
  PublishToTopicUsecase,
  UnsubscribeToTopicUsecase,
])
void main() {
  late MockMqttServerClientBuildUsecase mockMqttServerClientBuildUsecase;
  late MockConnectUsecase mockConnectUsecase;
  late MockDisconnectUsecase mockDisconnectUsecase;
  late MockSubscribeToTopicUsecase mockSubscribeToTopicUsecase;
  late MockPublishToTopicUsecase mockPublishToTopicUsecase;
  late MockUnsubscribeToTopicUsecase mockUnsubscribeToTopicUsecase;
  late FlutterAwsCognitoAccessIotcoreMqtt instance;
  setUpAll(() {
    mockMqttServerClientBuildUsecase = MockMqttServerClientBuildUsecase();
    mockConnectUsecase = MockConnectUsecase();
    mockDisconnectUsecase = MockDisconnectUsecase();
    mockSubscribeToTopicUsecase = MockSubscribeToTopicUsecase();
    mockPublishToTopicUsecase = MockPublishToTopicUsecase();
    mockUnsubscribeToTopicUsecase = MockUnsubscribeToTopicUsecase();

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

    when(mockMqttServerClientBuildUsecase.build(
      credentials: credentials,
      path: path,
      behavior: behavior,
      options: options,
    )).thenReturn(MqttServerClient(
      'server',
      'test-client-id',
    ));

    instance = FlutterAwsCognitoAccessIotcoreMqtt.configure(
      credentials: credentials,
      path: path,
      behavior: behavior,
      options: options,
      mqttServerClientBuildUsecase: mockMqttServerClientBuildUsecase,
      connectUsecase: mockConnectUsecase,
      subscribeToTopicUsecase: mockSubscribeToTopicUsecase,
      publishToTopicUsecase: mockPublishToTopicUsecase,
      unsubscribeToTopicUsecase: mockUnsubscribeToTopicUsecase,
      disconnectUsecase: mockDisconnectUsecase,
    );
  });
  test('test configure', () {
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
    // stub
    when(mockMqttServerClientBuildUsecase.build(
      credentials: credentials,
      path: path,
      behavior: behavior,
      options: options,
    )).thenReturn(MqttServerClient(
      'server',
      'test-client-id',
    ));
    // act
    final instance = FlutterAwsCognitoAccessIotcoreMqtt.configure(
      credentials: credentials,
      path: path,
      behavior: behavior,
      options: options,
      mqttServerClientBuildUsecase: mockMqttServerClientBuildUsecase,
      connectUsecase: mockConnectUsecase,
      subscribeToTopicUsecase: mockSubscribeToTopicUsecase,
      publishToTopicUsecase: mockPublishToTopicUsecase,
      unsubscribeToTopicUsecase: mockUnsubscribeToTopicUsecase,
      disconnectUsecase: mockDisconnectUsecase,
    );

    // assert
    expect(instance.behavior, behavior);
    expect(instance.credentials, credentials);
    expect(instance.path, path);
    expect(instance.options, options);
    expect(instance.client, isNotNull);
    expect(instance.connectUsecase, mockConnectUsecase);
    expect(instance.subscribeToTopicUsecase, mockSubscribeToTopicUsecase);
    expect(instance.publishToTopicUsecase, mockPublishToTopicUsecase);
    expect(instance.unsubscribeToTopicUsecase, mockUnsubscribeToTopicUsecase);
    expect(instance.disconnectUsecase, mockDisconnectUsecase);
  });

  test('configure without passing mockusecases', () {
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
    // stub
    when(mockMqttServerClientBuildUsecase.build(
      credentials: credentials,
      path: path,
      behavior: behavior,
      options: options,
    )).thenReturn(MqttServerClient(
      'server',
      'test-client-id',
    ));
    // act
    final instance = FlutterAwsCognitoAccessIotcoreMqtt.configure(
      credentials: credentials,
      path: path,
      behavior: behavior,
      options: options,
    );
    expect(instance.client, isNotNull);
    expect(instance.connectUsecase, isNotNull);
    expect(instance.subscribeToTopicUsecase, isNotNull);
    expect(instance.publishToTopicUsecase, isNotNull);
    expect(instance.unsubscribeToTopicUsecase, isNotNull);
    expect(instance.disconnectUsecase, isNotNull);
  });

  test('test connect', () async {
    // stub
    when(mockConnectUsecase.call()).thenAnswer((_) async => true);
    // act
    await instance.connect();

    // assert
    expect(instance.client, isNotNull);

    verify(mockConnectUsecase.call()).called(1);
  });

  test('test disconnect', () async {
    // stub
    when(mockDisconnectUsecase.disconnect()).thenReturn(null);
    // act
    instance.disconnect();

    // assert

    verify(mockDisconnectUsecase.disconnect()).called(1);
  });

  test('test dispose', () {
    // stub
    when(mockUnsubscribeToTopicUsecase.unsubscribe(topic: 'test-topic'))
        .thenReturn(null);
    // act
    instance.dispose();

    // assert
    verifyNever(mockUnsubscribeToTopicUsecase.unsubscribe(topic: 'test-topic'));
  });
  test('test subscribe', () {
    // stub
    when(mockSubscribeToTopicUsecase.subscribe('test-topic'))
        .thenReturn(Subscription());
    // act
    instance.subscribeToTopic('test-topic');

    // assert
    verify(mockSubscribeToTopicUsecase.subscribe('test-topic')).called(1);
  });

  test('test publish', () async {
    // stub
    when(mockPublishToTopicUsecase.publish(
            message: 'test-message', topic: 'test-topic'))
        .thenAnswer((_) async => 1);
    // act
    await instance.publishToTopic('test-message', 'test-topic');

    // assert
    verify(mockPublishToTopicUsecase.publish(
            message: 'test-message', topic: 'test-topic'))
        .called(1);
  });

  test('test unsubscribe', () {
    // stub
    when(mockUnsubscribeToTopicUsecase.unsubscribe(topic: 'test-topic'))
        .thenReturn(null);
    // act

    instance.unsubscribe(topic: 'test-topic');

    // assert
    verify(mockUnsubscribeToTopicUsecase.unsubscribe(topic: 'test-topic'))
        .called(1);
  });

  test('test unSubscribeAll', () {
    // stub
    when(mockUnsubscribeToTopicUsecase.unsubscribe(topic: 'test-topic'))
        .thenReturn(null);
    // act
    instance.subscriptions = [
      Subscription()..topic = SubscriptionTopic('test-topic')
    ];

    instance.unSubscribeAll();

    // assert
    verify(mockUnsubscribeToTopicUsecase.unsubscribe(topic: 'test-topic'))
        .called(1);
    expect(instance.subscriptions.isEmpty, isTrue);
  });
}
