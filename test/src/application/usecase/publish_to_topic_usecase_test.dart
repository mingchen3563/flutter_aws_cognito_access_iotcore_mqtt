import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/publish_to_topic_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'publish_to_topic_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MqttClientRepository>()])
void main() {
  late PublishToTopicUsecase usecase;
  late MockMqttClientRepository mockMqttClientRepository;
  late MqttClientOptions options;

  setUp(() {
    mockMqttClientRepository = MockMqttClientRepository();
    options = MqttClientOptions(
      qos: MqttQos.atLeastOnce,
      keepAlivePeriod: 20,
      disconnectOnNoResponsePeriod: 30,
      maxConnectionAttempts: 3,
    );
    usecase = PublishToTopicUsecase(
      mqttClientRepository: mockMqttClientRepository,
      options: options,
    );
  });

  group('PublishToTopicUsecase', () {
    test('當發布訊息成功時，應該返回訊息ID', () async {
      // Arrange
      const expectedMessageId = 1;
      const testMessage = 'test message';
      const testTopic = 'test/topic';
      
      when(mockMqttClientRepository.publish(
        testTopic,
        testMessage,
        options.qos,
      )).thenReturn(expectedMessageId);

      // Act
      final result = await usecase.publish(
        message: testMessage,
        topic: testTopic,
      );

      // Assert
      expect(result, expectedMessageId);
      verify(mockMqttClientRepository.publish(
        testTopic,
        testMessage,
        options.qos,
      )).called(1);
    });

    test('當發布訊息失敗時，應該拋出異常', () async {
      // Arrange
      const testMessage = 'test message';
      const testTopic = 'test/topic';
      
      when(mockMqttClientRepository.publish(
        testTopic,
        testMessage,
        options.qos,
      )).thenThrow(Exception('發布失敗'));

      // Act & Assert
      expect(
        () => usecase.publish(message: testMessage, topic: testTopic),
        throwsException,
      );
    });
  });
}
