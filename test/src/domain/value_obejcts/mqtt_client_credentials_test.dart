import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_credentials.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MqttClientCredentials', () {
    test('建立 MqttClientCredentials 實例', () {
      final credentials = MqttClientCredentials(
        accessKey: 'test-access-key',
        secretKey: 'test-secret-key', 
        sessionToken: 'test-session-token',
        identityId: 'test-identity-id'
      );
      
      expect(credentials.accessKey, equals('test-access-key'));
      expect(credentials.secretKey, equals('test-secret-key'));
      expect(credentials.sessionToken, equals('test-session-token'));
      expect(credentials.identityId, equals('test-identity-id'));
    });

    test('相等性測試', () {
      final credentials1 = MqttClientCredentials(
        accessKey: 'test-access-key',
        secretKey: 'test-secret-key',
        sessionToken: 'test-session-token',
        identityId: 'test-identity-id'
      );

      final credentials2 = MqttClientCredentials(
        accessKey: 'test-access-key',
        secretKey: 'test-secret-key',
        sessionToken: 'test-session-token',
        identityId: 'test-identity-id'
      );

      final credentials3 = MqttClientCredentials(
        accessKey: 'different-access-key',
        secretKey: 'test-secret-key',
        sessionToken: 'test-session-token',
        identityId: 'test-identity-id'
      );

      expect(credentials1, equals(credentials2));
      expect(credentials1, isNot(equals(credentials3)));
    });

    test('hashCode 測試', () {
      final credentials = MqttClientCredentials(
        accessKey: 'test-access-key',
        secretKey: 'test-secret-key',
        sessionToken: 'test-session-token',
        identityId: 'test-identity-id'
      );

      final expectedHashCode = 'test-access-key'.hashCode ^ 
                             'test-secret-key'.hashCode ^
                             'test-session-token'.hashCode ^
                             'test-identity-id'.hashCode;

      expect(credentials.hashCode, equals(expectedHashCode));
    });
  });
}
