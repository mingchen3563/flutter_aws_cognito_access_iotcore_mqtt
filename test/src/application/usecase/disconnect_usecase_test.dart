import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/disconnect_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'disconnect_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MqttClientRepository>()])
void main() {
  late DisconnectUsecase usecase;
  late MockMqttClientRepository mockMqttClientRepository;

  setUp(() {
    mockMqttClientRepository = MockMqttClientRepository();
    usecase = DisconnectUsecase(
      mqttClientRepository: mockMqttClientRepository,
    );
  });

  group('DisconnectUsecase', () {
    test('當呼叫 disconnect 時，應該調用 repository 的 disconnect 方法', () {
      // Arrange
      when(mockMqttClientRepository.disconnect())
          .thenAnswer((_) async => Future.value());

      // Act
      usecase.disconnect();

      // Assert
      verify(mockMqttClientRepository.disconnect()).called(1);
    });
  });
}
