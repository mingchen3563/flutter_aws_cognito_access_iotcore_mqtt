class MqttClientCredentials {
  final String accessKey;
  final String secretKey;
  final String sessionToken;
  final String identityId;

  MqttClientCredentials({
    required this.accessKey,
    required this.secretKey,
    required this.sessionToken,
    required this.identityId,
  });


  @override
  bool operator ==(Object other) =>
      other is MqttClientCredentials &&
      other.accessKey == accessKey &&
      other.secretKey == secretKey &&
      other.sessionToken == sessionToken &&
      other.identityId == identityId;

  @override
  int get hashCode =>
      accessKey.hashCode ^ secretKey.hashCode ^ sessionToken.hashCode ^ identityId.hashCode;
}
