import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';

class AwsSignService {
  AWSSigV4Signer? signer;
  AwsSignService({this.signer});

  AWSSigV4Signer getAWSSigV4Signer(AWSCredentials creds) {
    return signer ??
        AWSSigV4Signer(
          credentialsProvider: AWSCredentialsProvider(creds),
        );
  }

  Future<AWSSignedRequest> signRequest(
    AWSCredentials creds,
    AWSHttpRequest request,
    AWSCredentialScope scope,
  ) async {
    AWSSigV4Signer signer = getAWSSigV4Signer(creds);
    return await signer.sign(request, credentialScope: scope);
  }
}
