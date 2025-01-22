abstract class AwsServiceRepository {
  Future<bool> attachPolicy({
    required String accessKey,
    required String secretKey,
    required String sessionToken,
    required String identityId,

    required String region,
    required String policyName,
  });
}
