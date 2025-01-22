import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/subscribe_to_topic_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'subscribe_to_topic_usecase_test.mocks.dart';



@GenerateNiceMocks([MockSpec<MqttClientRepository>()])
void main() {
  late SubscribeToTopicUsecase usecase;
  late MockMqttClientRepository mockMqttClientRepository;
  late MqttClientOptions options;

  setUp(() {
    mockMqttClientRepository = MockMqttClientRepository();
    options = MqttClientOptions(
      keepAlivePeriod: 20,
      qos: MqttQos.atLeastOnce,
      disconnectOnNoResponsePeriod: 10,
      maxConnectionAttempts: 3,
    );
    usecase = SubscribeToTopicUsecase(
      mqttClientRepository: mockMqttClientRepository,
      options: options,
    );
  });

  group('SubscribeToTopicUsecase', () {
    test('當訂閱成功時，應該返回 Subscription', () {
      // Arrange
      const topic = 'test/topic';
      final subscription = Subscription();
      when(mockMqttClientRepository.subscribe(topic, options.qos))
          .thenReturn(subscription);

      // Act
      final result = usecase.subscribe(topic);

      // Assert
      expect(result, subscription);
      verify(mockMqttClientRepository.subscribe(topic, options.qos)).called(1);
    });

    test('當訂閱失敗時，應該拋出異常', () {
      // Arrange
      const topic = 'test/topic';
      when(mockMqttClientRepository.subscribe(topic, options.qos))
          .thenReturn(null);

      // Act & Assert
      expect(() => usecase.subscribe(topic), throwsException);
      verify(mockMqttClientRepository.subscribe(topic, options.qos)).called(1);
    });
  });
}
