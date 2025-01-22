import 'package:typed_data/typed_data.dart' as typed;

import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/repositories/mqtt_client_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'mqtt_client_repository_impl_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<MqttClient>(), MockSpec<MqttClientPayloadBuilder>()])
void main() {
  late MqttClientRepositoryImpl repository;
  late MockMqttClient mockClient;
  late MockMqttClientPayloadBuilder mockMqttClientPayloadBuilder;
  setUp(() {
    mockClient = MockMqttClient();
    mockMqttClientPayloadBuilder = MockMqttClientPayloadBuilder();
    repository = MqttClientRepositoryImpl(
      client: mockClient,
      mqttClientPayloadBuilder: mockMqttClientPayloadBuilder,
    );
  });

  group('MqttClientRepositoryImpl', () {
    test('當連接成功時 connect() 應該返回 true', () async {
      // Arrange
      when(mockClient.connect()).thenAnswer((_) async =>
          MqttClientConnectionStatus()..state = MqttConnectionState.connected);

      // Act
      final result = await repository.connect();

      // Assert
      expect(result, true);
      verify(mockClient.connect()).called(1);
    });

    test('當連接失敗時 connect() 應該返回 false', () async {
      // Arrange
      when(mockClient.connect()).thenAnswer((_) async =>
          MqttClientConnectionStatus()
            ..state = MqttConnectionState.disconnected);

      // Act
      final result = await repository.connect();

      // Assert
      expect(result, false);
      verify(mockClient.connect()).called(1);
    });

    test('disconnect() 應該調用客戶端的 disconnect()', () async {
      // Act
      await repository.disconnect();

      // Assert
      verify(mockClient.disconnect()).called(1);
    });

    test('publish() 應該正確發布消息並返回消息ID', () {
      // Arrange
      const topic = 'test/topic';
      const message = 'test message';
      const messageId = 1;
      when(mockClient.publishMessage(any, any, any)).thenReturn(messageId);
      when(mockMqttClientPayloadBuilder.addString(any))
          .thenReturn(mockMqttClientPayloadBuilder);

      when(mockMqttClientPayloadBuilder.payload)
          .thenReturn(typed.Uint8Buffer());

      // Act
      final result = repository.publish(topic, message, MqttQos.atLeastOnce);

      // Assert
      expect(result, messageId);
      verify(mockClient.publishMessage(topic, MqttQos.atLeastOnce, any))
          .called(1);
    });

    test('publish() 當 payload 為 null 時應拋出異常', () {
      // Arrange
      const topic = 'test/topic';
      const message = '';

      when(mockMqttClientPayloadBuilder.payload).thenReturn(null);

      // Act & Assert
      expect(() => repository.publish(topic, message, MqttQos.atLeastOnce),
          throwsException);
    });

    test('subscribe() 應該調用客戶端的 subscribe()', () {
      // Arrange
      const topic = 'test/topic';
      final subscription = Subscription();
      when(mockClient.subscribe(topic, MqttQos.atLeastOnce))
          .thenReturn(subscription);

      // Act
      final result = repository.subscribe(topic, MqttQos.atLeastOnce);

      // Assert
      expect(result, subscription);
      verify(mockClient.subscribe(topic, MqttQos.atLeastOnce)).called(1);
    });

    test('unsubscribe() 應該調用客戶端的 unsubscribe()', () {
      // Arrange
      const topic = 'test/topic';

      // Act
      repository.unsubscribe(topic);

      // Assert
      verify(mockClient.unsubscribe(topic, expectAcknowledge: true)).called(1);
    });
  });
}
