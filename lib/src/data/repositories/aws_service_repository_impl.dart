import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/data_sources/remote_aws_data_source.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/aws_service_repository.dart';

class AwsServiceRepositoryImpl implements AwsServiceRepository {
  final RemoteAwsDataSource remoteAwsDataSource;

  AwsServiceRepositoryImpl({
    RemoteAwsDataSource? remoteAwsDataSource,
  }) : remoteAwsDataSource = remoteAwsDataSource ?? RemoteAwsDataSource();

  @override
  Future<bool> attachPolicy({
    required String accessKey,
    required String secretKey,
    required String sessionToken,
    required String identityId,
    required String region,
    required String policyName,
  }) async {
    remoteAwsDataSource.attachPolicy(
      accessKey: accessKey,
      secretKey: secretKey,
      sessionToken: sessionToken,
      identityId: identityId,
      region: region,
      policyName: policyName,
    );
    return true;
  }
}
