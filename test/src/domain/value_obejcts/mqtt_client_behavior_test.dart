import 'dart:io';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_behavior.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MqttClientBehavior', () {
    test('建立 MqttClientBehavior 實例', () {
      bool onBadCertificateCallback(X509Certificate certificate) => true;
      void onAutoReconnectCallback() {}
      void onConnectedCallback() {}
      void onDisconnectedCallback() {}
      void onSubscribedCallback(String topic) {}
      void onSubscribeFailCallback(String topic) {}
      void onUnsubscribedCallback(String? topic) {}
      void onFailedConnectionAttemptCallback(int attempt) {}
      void onAutoReconnectedCallback() {}

      final behavior = MqttClientBehavior(
        onBadCertificate: onBadCertificateCallback,
        onAutoReconnect: onAutoReconnectCallback,
        onConnected: onConnectedCallback,
        onDisconnected: onDisconnectedCallback,
        onSubscribed: onSubscribedCallback,
        onSubscribeFail: onSubscribeFailCallback,
        onUnsubscribed: onUnsubscribedCallback,
        onFailedConnectionAttempt: onFailedConnectionAttemptCallback,
        onAutoReconnected: onAutoReconnectedCallback,
      );

      expect(behavior.onBadCertificate, equals(onBadCertificateCallback));
      expect(behavior.onAutoReconnect, equals(onAutoReconnectCallback));
      expect(behavior.onConnected, equals(onConnectedCallback));
      expect(behavior.onDisconnected, equals(onDisconnectedCallback));
      expect(behavior.onSubscribed, equals(onSubscribedCallback));
      expect(behavior.onSubscribeFail, equals(onSubscribeFailCallback));
      expect(behavior.onUnsubscribed, equals(onUnsubscribedCallback));
      expect(behavior.onFailedConnectionAttempt, equals(onFailedConnectionAttemptCallback));
      expect(behavior.onAutoReconnected, equals(onAutoReconnectedCallback));
    });

    test('使用預設值建立 MqttClientBehavior 實例', () {
      final behavior = MqttClientBehavior.defaultBehavior();
      
      expect(behavior.onBadCertificate, isNull);
      expect(behavior.onAutoReconnect, isNull);
      expect(behavior.onConnected, isNull);
      expect(behavior.onDisconnected, isNull);
      expect(behavior.onSubscribed, isNull);
      expect(behavior.onSubscribeFail, isNull);
      expect(behavior.onUnsubscribed, isNull);
      expect(behavior.onFailedConnectionAttempt, isNull);
      expect(behavior.onAutoReconnected, isNull);
    });

    test('相等性測試', () {
      void onConnectedCallback() {}
      void onDisconnectedCallback() {}

      final behavior1 = MqttClientBehavior(
        onConnected: onConnectedCallback,
        onDisconnected: onDisconnectedCallback,
      );

      final behavior2 = MqttClientBehavior(
        onConnected: onConnectedCallback,
        onDisconnected: onDisconnectedCallback,
      );

      final behavior3 = MqttClientBehavior(
        onConnected: () {},
        onDisconnected: onDisconnectedCallback,
      );

      expect(behavior1, equals(behavior2));
      expect(behavior1, isNot(equals(behavior3)));
    });

    test('hashCode 測試', () {
      void onConnectedCallback() {}
      void onDisconnectedCallback() {}

      final behavior = MqttClientBehavior(
        onConnected: onConnectedCallback,
        onDisconnected: onDisconnectedCallback,
      );

      final expectedHashCode = behavior.onBadCertificate.hashCode ^
                             behavior.onAutoReconnect.hashCode ^
                             onConnectedCallback.hashCode ^
                             onDisconnectedCallback.hashCode;

      expect(behavior.hashCode, equals(expectedHashCode));
    });
  });
}
