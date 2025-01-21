import 'dart:developer';

import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttServerClientBuildUsecase {
  MqttServerClient build({
    required MqttClientCredentials credentials,
    required MqttClientPath path,
    required MqttClientBehavior behavior,
    required MqttClientOptions options,
  }) {
    const scheme = 'wss://';
    const urlPath = '/mqtt';
    const port = 443;

    // 取得 signed url
    String signedUrl;
    try {
      signedUrl = _getWebSocketUrlUsecase(
        accessKey: credentials.accessKey,
        secretKey: credentials.secretKey,
        sessionToken: credentials.sessionToken,
        region: path.region,
        scheme: scheme,
        endpoint: path.endpoint,
        urlPath: urlPath,
      );
    } catch (e, s) {
      log('Failed to get signed url: $e', error: e, stackTrace: s);
      throw Exception('Failed to get signed url');
    }
    MqttServerClient client = MqttServerClient.withPort(
      signedUrl,
      credentials.identityId,
      port,
      maxConnectionAttempts: options.maxConnectionAttempts,
    );

    client.setProtocolV311();
    client.logging(on: false);
    client.useWebSocket = true;
    client.secure = false;
    client.autoReconnect = true;
    client.disconnectOnNoResponsePeriod = options.disconnectOnNoResponsePeriod;
    client.keepAlivePeriod = options.keepAlivePeriod;

    final MqttConnectMessage connMess =
        MqttConnectMessage().withClientIdentifier(credentials.identityId);

    client.connectionMessage = connMess;
    // 設定行為
    client.onBadCertificate = behavior.onBadCertificate;
    client.onAutoReconnect = behavior.onAutoReconnect;
    client.onConnected = behavior.onConnected;
    client.onDisconnected = behavior.onDisconnected;
    client.onSubscribed = behavior.onSubscribed;
    client.onSubscribeFail = behavior.onSubscribeFail;
    client.onUnsubscribed = behavior.onUnsubscribed;
    client.onFailedConnectionAttempt = behavior.onFailedConnectionAttempt;
    client.onAutoReconnected = behavior.onAutoReconnected;

    return client;
  }

  String _getWebSocketUrlUsecase(
      {required String accessKey,
      required String secretKey,
      required String sessionToken,
      required String region,
      required String scheme,
      required String endpoint,
      required String urlPath}) {
    final creds = AWSCredentials(accessKey, secretKey, sessionToken);

    final signer = AWSSigV4Signer(
      credentialsProvider: AWSCredentialsProvider(creds),
    );

    final scope = AWSCredentialScope(
        region: region, service: const AWSService('iotdevicegateway'));

    final request = AWSHttpRequest(
      method: AWSHttpMethod.get,
      uri: Uri.https(endpoint, urlPath),
    );

    ServiceConfiguration serviceConfiguration =
        const BaseServiceConfiguration(omitSessionToken: true);

    var signed = signer.presignSync(
      request,
      credentialScope: scope,
      expiresIn: const Duration(hours: 1),
      serviceConfiguration: serviceConfiguration,
    );
    var finalParams = signed.query;
    final result = '$scheme$endpoint$urlPath?$finalParams';
    // log('socket url: $result');
    return result;
  }
}
