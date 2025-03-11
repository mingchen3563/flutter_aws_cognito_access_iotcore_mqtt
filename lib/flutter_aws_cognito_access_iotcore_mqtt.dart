library flutter_aws_cognito_access_iotcore_mqtt;

import 'dart:async';
import 'dart:developer';

import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/connect_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/disconnect_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/mqtt_server_client_build_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/publish_to_topic_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/subscribe_to_topic_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/unsubscribe_to_topic_usecase.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/repositories/aws_service_repository_impl.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/data/repositories/mqtt_client_repository_impl.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/aws_service_repository.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_behavior.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_credentials.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_options.dart';
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_path.dart';
import 'package:get_it/get_it.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

export 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_behavior.dart';
export 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_credentials.dart';
export 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_options.dart';
export 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/value_obejcts/mqtt_client_path.dart';

class FlutterAwsCognitoAccessIotcoreMqtt {
  final MqttClientOptions options;
  final MqttClientBehavior behavior;
  final MqttClientPath path;
  final MqttClientCredentials credentials;
  final MqttServerClient client;
  final ConnectUsecase connectUsecase;
  final SubscribeToTopicUsecase subscribeToTopicUsecase;
  final PublishToTopicUsecase publishToTopicUsecase;
  final UnsubscribeToTopicUsecase unsubscribeToTopicUsecase;
  final DisconnectUsecase disconnectUsecase;

  FlutterAwsCognitoAccessIotcoreMqtt._({
    required this.options,
    required this.behavior,
    required this.path,
    required this.credentials,
    required this.client,
    required this.connectUsecase,
    required this.subscribeToTopicUsecase,
    required this.publishToTopicUsecase,
    required this.unsubscribeToTopicUsecase,
    required this.disconnectUsecase,
  });

  List<Subscription> subscriptions = [];
  Map<String, StreamController<String>> updateStreamControllers = {};

  Stream<List<MqttReceivedMessage<MqttMessage>>>? updateStream;

  static FlutterAwsCognitoAccessIotcoreMqtt configure({
    required MqttClientCredentials credentials,
    required MqttClientPath path,
    required MqttClientBehavior behavior,
    required MqttClientOptions options,
    MqttServerClientBuildUsecase? mqttServerClientBuildUsecase,
    ConnectUsecase? connectUsecase,
    SubscribeToTopicUsecase? subscribeToTopicUsecase,
    PublishToTopicUsecase? publishToTopicUsecase,
    UnsubscribeToTopicUsecase? unsubscribeToTopicUsecase,
    DisconnectUsecase? disconnectUsecase,
  }) {
    MqttServerClient client =
        (mqttServerClientBuildUsecase ?? MqttServerClientBuildUsecase()).build(
      credentials: credentials,
      path: path,
      behavior: behavior,
      options: options,
    );
    if (!GetIt.I.isRegistered<MqttClient>()) {
      GetIt.I.registerSingleton<MqttClient>(client);
    }
    if (!GetIt.I.isRegistered<MqttClientRepository>()) {
      GetIt.I
          .registerSingleton<MqttClientRepository>(MqttClientRepositoryImpl());
    }
    if (!GetIt.I.isRegistered<AwsServiceRepository>()) {
      GetIt.I
          .registerSingleton<AwsServiceRepository>(AwsServiceRepositoryImpl());
    }

    return FlutterAwsCognitoAccessIotcoreMqtt._(
      credentials: credentials,
      path: path,
      behavior: behavior,
      options: options,
      client: client,
      connectUsecase: connectUsecase ??
          ConnectUsecase(
            path: path,
            credentials: credentials,
          ),
      subscribeToTopicUsecase: subscribeToTopicUsecase ??
          SubscribeToTopicUsecase(
            options: options,
          ),
      publishToTopicUsecase: publishToTopicUsecase ??
          PublishToTopicUsecase(
            options: options,
          ),
      unsubscribeToTopicUsecase: unsubscribeToTopicUsecase ??
          UnsubscribeToTopicUsecase(
            options: options,
          ),
      disconnectUsecase: disconnectUsecase ?? DisconnectUsecase(),
    );
  }

  Future<void> connect() async {
    await connectUsecase.call();
    updateStream = client.updates;
    client.updates?.listen((events) {
      for (var event in events) {
        var topic = event.topic;
        var payload = event.payload as MqttPublishMessage;
        var pt =
            MqttPublishPayload.bytesToStringAsString(payload.payload.message);
        StreamController<String>? controller = updateStreamControllers[topic];
        if (controller != null) {
          controller.add(pt);
        }

        log('incoming message from topic $topic\n${event.topic}: $pt');
      }
    });
  }

  StreamController<String> subscribeToTopic(String topic) {
    // if topic is already subscribed, return the controller
    if (updateStreamControllers.containsKey(topic)) {
      log('duplicate topic: $topic');
      return updateStreamControllers[topic]!;
    }
    var s = subscribeToTopicUsecase.subscribe(topic);
    // create a StreamController pushing String on triggered
    subscriptions.add(s);

    var controller = StreamController<String>();
    updateStreamControllers.putIfAbsent(topic, () => controller);
    return controller;
  }

  /// return a message id
  Future<int> publishToTopic(String message, String topic) {
    return publishToTopicUsecase.publish(message: message, topic: topic);
  }

  void unsubscribe({required String topic}) {
    unsubscribeToTopicUsecase.unsubscribe(topic: topic);
  }

  void unSubscribeAll() {
    for (var subscription in subscriptions) {
      unsubscribeToTopicUsecase.unsubscribe(topic: subscription.topic.rawTopic);
    }
    for (var controller in updateStreamControllers.entries) {
      controller.value.close();
    }
    subscriptions.clear();
    updateStreamControllers.clear();
  }

  void disconnect() {
    disconnectUsecase.disconnect();
  }

  void dispose() {
    unSubscribeAll();
    GetIt.I.unregister<MqttClient>();
    disconnect();
    client.disconnect();
  }
}
