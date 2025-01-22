import 'dart:convert';
import 'dart:developer';

import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';

import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/aws_sign_service.dart';
import 'package:http/http.dart' as http;

class RemoteAwsDataSource {
  final http.Client httpClient;
  final AwsSignService awsSignService;

  RemoteAwsDataSource({
    http.Client? httpClient,
    AwsSignService? awsSignService,
  })  : httpClient = httpClient ?? http.Client(),
        awsSignService = awsSignService ?? AwsSignService();

  Future<bool> attachPolicy(
      {required String accessKey,
      required String secretKey,
      required String sessionToken,
      required String identityId,
      required String region,
      required String policyName}) async {
    final iotApiUrl = 'https://iot.$region.amazonaws.com/target-policies';

    final AWSCredentials creds =
        AWSCredentials(accessKey, secretKey, sessionToken);

    final scope = AWSCredentialScope(region: region, service: AWSService.iot);

    final body = json.encode({'target': identityId});

    final request = AWSHttpRequest(
      method: AWSHttpMethod.put,
      uri: Uri.parse('$iotApiUrl/$policyName'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: body.codeUnits,
    );

    final AWSSignedRequest signedRequest = await awsSignService.signRequest(
      creds,
      request,
      scope,
    );

    final result = await httpClient.put(
      signedRequest.uri,
      headers: signedRequest.headers,
      body: await signedRequest.body.first,
    );

    if (result.statusCode != 200) {
      log('Error attaching IoT Policy ${result.body}');
    }

    return result.statusCode == 200;
  }
}
