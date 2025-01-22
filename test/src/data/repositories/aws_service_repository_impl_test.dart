import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/data_sources/remote_aws_data_source.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/repositories/aws_service_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'aws_service_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteAwsDataSource])
void main() {
  late AwsServiceRepositoryImpl awsServiceRepository;
  late MockRemoteAwsDataSource mockRemoteAwsDataSource;

  setUp(() {
    mockRemoteAwsDataSource = MockRemoteAwsDataSource();
    awsServiceRepository = AwsServiceRepositoryImpl(
      remoteAwsDataSource: mockRemoteAwsDataSource,
    );
  });

  group('attachPolicy', () {
    test('應該呼叫 RemoteAwsDataSource.attachPolicy 並返回 true', () async {
      // Arrange
      const accessKey = 'testAccessKey';
      const secretKey = 'testSecretKey';
      const sessionToken = 'testSessionToken';
      const identityId = 'testIdentityId';
      const region = 'testRegion';
      const policyName = 'testPolicyName';

      when(mockRemoteAwsDataSource.attachPolicy(
        accessKey: accessKey,
        secretKey: secretKey,
        sessionToken: sessionToken,
        identityId: identityId,
        region: region,
        policyName: policyName,
      )).thenAnswer((_) async => true);

      // Act
      final result = await awsServiceRepository.attachPolicy(
        accessKey: accessKey,
        secretKey: secretKey,
        sessionToken: sessionToken,
        identityId: identityId,
        region: region,
        policyName: policyName,
      );

      // Assert
      expect(result, true);
      verify(mockRemoteAwsDataSource.attachPolicy(
        accessKey: accessKey,
        secretKey: secretKey,
        sessionToken: sessionToken,
        identityId: identityId,
        region: region,
        policyName: policyName,
      )).called(1);
    });
  });
}
