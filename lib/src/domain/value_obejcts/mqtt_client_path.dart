class MqttClientPath {
  final String endpoint;
  final String region;
  final String policyName;

  MqttClientPath({
    required this.endpoint,
    required this.region,
    required this.policyName,
  });

  @override
  bool operator ==(Object other) =>
      other is MqttClientPath &&
      other.endpoint == endpoint &&
      other.region == region &&
      other.policyName == policyName;

  @override
  int get hashCode => endpoint.hashCode ^ region.hashCode ^ policyName.hashCode;
}
