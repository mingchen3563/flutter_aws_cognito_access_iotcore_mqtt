import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/aws_sign_service.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/data_sources/remote_aws_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_aws_data_source_test.mocks.dart';

@GenerateMocks([
  AWSSigV4Signer,
  http.Client,
  AwsSignService,
])
void main() {
  const accessKey = 'testAccessKey';
  const secretKey = 'testSecretKey';
  const sessionToken = 'testSessionToken';
  const identityId = 'testIdentityId';
  const region = 'ap-northeast-1';
  const policyName = 'testPolicy';
  late MockAwsSignService mockAwsSignService;
  late MockClient mockHttpClient;
  late RemoteAwsDataSource remoteAwsDataSource;
  late AWSCredentials awsCredentials;
  late AWSHttpRequest request;
  late AWSCredentialScope credentialScope;
  late AWSSignedRequest signedRequest;
  setUpAll(() {
    mockAwsSignService = MockAwsSignService();
    mockHttpClient = MockClient();
    remoteAwsDataSource = RemoteAwsDataSource(
      httpClient: mockHttpClient,
      awsSignService: mockAwsSignService,
    );

    awsCredentials = const AWSCredentials(accessKey, secretKey, sessionToken);
    request = AWSHttpRequest(
      method: AWSHttpMethod.put,
      uri: Uri.parse(
          'https://iot.$region.amazonaws.com/target-policies/$policyName'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: '{"target":"$identityId"}'.codeUnits,
    );
    credentialScope = AWSCredentialScope(
      dateTime: AWSDateTime.now(),
      region: region,
      service: AWSService.iot,
    );
    signedRequest = AWSSignedRequest(
      canonicalRequest: CanonicalRequest(
        request: request,
        credentials: awsCredentials,
        credentialScope: credentialScope,
        contentLength: 0,
        payloadHash: 'mock-payload-hash',
      ),
      signature: 'mock-signature',
      method: AWSHttpMethod.put,
      host: 'iot.$region.amazonaws.com',
      path: '/target-policies/$policyName',
      body: Stream.fromIterable(['{"target":"$identityId"}'.codeUnits]),
    );
  });

  group('test attach policy', () {
    test('當 attachPolicy 成功時應返回 true', () async {
      // stub
      when(mockAwsSignService.signRequest(
        any,
        any,
        any,
      )).thenAnswer((_) async => signedRequest);

      when(mockHttpClient.put(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Success', 200));
      // act
      final result = await remoteAwsDataSource.attachPolicy(
        accessKey: accessKey,
        secretKey: secretKey,
        sessionToken: sessionToken,
        identityId: identityId,
        region: region,
        policyName: policyName,
      );
      expect(result, true);
    });

    test('當 attachPolicy 失敗時應返回 false', () async {
      // stub
      when(mockAwsSignService.signRequest(
        any,
        any,
        any,
      )).thenAnswer((_) async => signedRequest);

      when(mockHttpClient.put(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('failed', 400));
      // act
      final result = await remoteAwsDataSource.attachPolicy(
        accessKey: accessKey,
        secretKey: secretKey,
        sessionToken: sessionToken,
        identityId: identityId,
        region: region,
        policyName: policyName,
      );
      expect(result, false);
    });
  });
}
