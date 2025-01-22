import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mqtt_client/mqtt_client.dart';

void main() {
  group('MqttClientOptions', () {
    test('建立 MqttClientOptions 實例', () {
      final options = MqttClientOptions(
        disconnectOnNoResponsePeriod: 90,
        keepAlivePeriod: 30,
        maxConnectionAttempts: 2,
        qos: MqttQos.atMostOnce,
      );
      
      expect(options.disconnectOnNoResponsePeriod, equals(90));
      expect(options.keepAlivePeriod, equals(30));
      expect(options.maxConnectionAttempts, equals(2));
      expect(options.qos, equals(MqttQos.atMostOnce));
    });

    test('使用預設值建立 MqttClientOptions 實例', () {
      final options = MqttClientOptions.defaultOptions();
      
      expect(options.disconnectOnNoResponsePeriod, equals(90));
      expect(options.keepAlivePeriod, equals(30));
      expect(options.maxConnectionAttempts, equals(2));
      expect(options.qos, equals(MqttQos.atMostOnce));
    });

    test('相等性測試', () {
      final options1 = MqttClientOptions(
        disconnectOnNoResponsePeriod: 90,
        keepAlivePeriod: 30,
        maxConnectionAttempts: 2,
        qos: MqttQos.atMostOnce,
      );

      final options2 = MqttClientOptions(
        disconnectOnNoResponsePeriod: 90,
        keepAlivePeriod: 30,
        maxConnectionAttempts: 2,
        qos: MqttQos.atMostOnce,
      );

      final options3 = MqttClientOptions(
        disconnectOnNoResponsePeriod: 60,
        keepAlivePeriod: 30,
        maxConnectionAttempts: 2,
        qos: MqttQos.atMostOnce,
      );

      expect(options1, equals(options2));
      expect(options1, isNot(equals(options3)));
    });

    test('hashCode 測試', () {
      final options = MqttClientOptions(
        disconnectOnNoResponsePeriod: 90,
        keepAlivePeriod: 30,
        maxConnectionAttempts: 2,
        qos: MqttQos.atMostOnce,
      );

      final expectedHashCode = 90.hashCode ^ 
                             30.hashCode ^ 
                             2.hashCode;

      expect(options.hashCode, equals(expectedHashCode));
    });
  });
}
