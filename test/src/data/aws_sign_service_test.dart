import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/aws_sign_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'aws_sign_service_test.mocks.dart';

@GenerateMocks([AWSSigV4Signer])
void main() {
  const accessKey = 'testAccessKey';
  const secretKey = 'testSecretKey';
  const sessionToken = 'testSessionToken';
  const region = 'ap-northeast-1';
  late MockAWSSigV4Signer mockAWSSigV4Signer;
  late AwsSignService awsSignService;
  late AWSCredentials awsCredentials;
  late AWSHttpRequest request;
  late AWSCredentialScope credentialScope;
  late AWSSignedRequest signedRequest;

  setUpAll(() {
    mockAWSSigV4Signer = MockAWSSigV4Signer();
    awsSignService = AwsSignService(signer: mockAWSSigV4Signer);
    awsCredentials = const AWSCredentials(accessKey, secretKey, sessionToken);
    request = AWSHttpRequest(
      method: AWSHttpMethod.put,
      uri: Uri.parse('https://test.com'),
      headers: const {'Content-Type': 'application/json'},
      body: '{"test":"test"}'.codeUnits,
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
      host: 'test.com',
      path: '/',
      body: Stream.fromIterable(['{"test":"test"}'.codeUnits]),
    );
  });
  group('test get signer', () {
    test('test get signer', () {
      final result = awsSignService.getAWSSigV4Signer(awsCredentials);
      expect(result, mockAWSSigV4Signer);
    });
    test('test get signer with signer', () {
      final result = AwsSignService().getAWSSigV4Signer(awsCredentials);
      expect(result, isA<AWSSigV4Signer>());
    });
  });

  group('測試 AwsSignService', () {
    test('當 getAWSSigV4Signer 被呼叫時，如果有提供 signer 應返回該 signer', () {
      final result = awsSignService.getAWSSigV4Signer(awsCredentials);
      expect(result, mockAWSSigV4Signer);
    });

    test('當 signRequest 被呼叫時應正確簽署請求', () async {
      when(mockAWSSigV4Signer.sign(
        any,
        credentialScope: anyNamed('credentialScope'),
      )).thenAnswer((_) async => signedRequest);

      final result = await awsSignService.signRequest(
        awsCredentials,
        request,
        credentialScope,
      );

      verify(mockAWSSigV4Signer.sign(
        request,
        credentialScope: credentialScope,
      )).called(1);

      expect(result, signedRequest);
    });
  });
}
