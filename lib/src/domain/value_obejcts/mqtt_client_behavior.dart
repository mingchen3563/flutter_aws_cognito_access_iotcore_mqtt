import 'dart:io';

class MqttClientBehavior {
  final bool Function(X509Certificate certificate)? onBadCertificate;
  final void Function()? onAutoReconnect;
  final void Function()? onConnected;
  final void Function()? onDisconnected;
  final void Function(String topic)? onSubscribed;
  final void Function(String topic)? onSubscribeFail;
  final void Function(String? topic)? onUnsubscribed;
  final void Function(int)? onFailedConnectionAttempt;
  final void Function()? onAutoReconnected;

  MqttClientBehavior({
    this.onBadCertificate,
    this.onAutoReconnect,
    this.onConnected,
    this.onDisconnected,
    this.onSubscribed,
    this.onSubscribeFail,
    this.onUnsubscribed,
    this.onFailedConnectionAttempt,
    this.onAutoReconnected,
  });

  factory MqttClientBehavior.defaultBehavior() {
    return MqttClientBehavior();
  }

  @override
  bool operator ==(Object other) =>
      other is MqttClientBehavior &&
      other.onBadCertificate == onBadCertificate &&
      other.onAutoReconnect == onAutoReconnect &&
      other.onConnected == onConnected &&
      other.onDisconnected == onDisconnected;

  @override
  int get hashCode =>
      onBadCertificate.hashCode ^
      onAutoReconnect.hashCode ^
      onConnected.hashCode ^
      onDisconnected.hashCode;
}
