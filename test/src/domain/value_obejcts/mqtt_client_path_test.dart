import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_path.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('MqttClientPath', () {
    test('建立 MqttClientPath 實例', () {
      final path = MqttClientPath(
        endpoint: 'test-endpoint',
        region: 'us-east-1',
        policyName: 'test-policy'
      );
      
      expect(path.endpoint, equals('test-endpoint'));
      expect(path.region, equals('us-east-1')); 
      expect(path.policyName, equals('test-policy'));
    });

    test('相等性測試', () {
      final path1 = MqttClientPath(
        endpoint: 'test-endpoint',
        region: 'us-east-1',
        policyName: 'test-policy'
      );

      final path2 = MqttClientPath(
        endpoint: 'test-endpoint',
        region: 'us-east-1',
        policyName: 'test-policy'
      );

      final path3 = MqttClientPath(
        endpoint: 'different-endpoint',
        region: 'us-east-1',
        policyName: 'test-policy'
      );

      expect(path1, equals(path2));
      expect(path1, isNot(equals(path3)));
    });

    test('hashCode 測試', () {
      final path = MqttClientPath(
        endpoint: 'test-endpoint',
        region: 'us-east-1',
        policyName: 'test-policy'
      );

      final expectedHashCode = 'test-endpoint'.hashCode ^ 
                             'us-east-1'.hashCode ^ 
                             'test-policy'.hashCode;

      expect(path.hashCode, equals(expectedHashCode));
    });
  });
}
