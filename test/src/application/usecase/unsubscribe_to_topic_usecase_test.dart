import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/unsubscribe_to_topic_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'unsubscribe_to_topic_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MqttClientRepository>()])
void main() {
  late UnsubscribeToTopicUsecase usecase;
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
    usecase = UnsubscribeToTopicUsecase(
      mqttClientRepository: mockMqttClientRepository,
      options: options,
    );
  });

  group('UnsubscribeToTopicUsecase', () {
    test('當取消訂閱時，應該調用 repository 的 unsubscribe 方法', () {
      // Arrange
      const topic = 'test/topic';

      // Act
      usecase.unsubscribe(topic: topic);

      // Assert
      verify(mockMqttClientRepository.unsubscribe(topic)).called(1);
    });
  });
}
