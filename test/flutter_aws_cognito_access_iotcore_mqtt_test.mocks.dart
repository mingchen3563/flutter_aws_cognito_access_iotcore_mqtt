// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_aws_cognito_access_iotcore_mqtt/test/flutter_aws_cognito_access_iotcore_mqtt_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;

import 'package:flutter_aws_cognito_access_iotcore_mqtt/flutter_aws_cognito_access_iotcore_mqtt.dart'
    as _i3;
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/connect_usecase.dart'
    as _i8;
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/disconnect_usecase.dart'
    as _i10;
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/mqtt_server_client_build_usecase.dart'
    as _i7;
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/publish_to_topic_usecase.dart'
    as _i12;
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/subscribe_to_topic_usecase.dart'
    as _i11;
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/application/usecase/unsubscribe_to_topic_usecase.dart'
    as _i13;
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/aws_service_repository.dart'
    as _i4;
import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mqtt_client/mqtt_client.dart' as _i6;
import 'package:mqtt_client/mqtt_server_client.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMqttServerClient_0 extends _i1.SmartFake
    implements _i2.MqttServerClient {
  _FakeMqttServerClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMqttClientPath_1 extends _i1.SmartFake
    implements _i3.MqttClientPath {
  _FakeMqttClientPath_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMqttClientCredentials_2 extends _i1.SmartFake
    implements _i3.MqttClientCredentials {
  _FakeMqttClientCredentials_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAwsServiceRepository_3 extends _i1.SmartFake
    implements _i4.AwsServiceRepository {
  _FakeAwsServiceRepository_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMqttClientRepository_4 extends _i1.SmartFake
    implements _i5.MqttClientRepository {
  _FakeMqttClientRepository_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMqttClientOptions_5 extends _i1.SmartFake
    implements _i3.MqttClientOptions {
  _FakeMqttClientOptions_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSubscription_6 extends _i1.SmartFake implements _i6.Subscription {
  _FakeSubscription_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MqttServerClientBuildUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockMqttServerClientBuildUsecase extends _i1.Mock
    implements _i7.MqttServerClientBuildUsecase {
  MockMqttServerClientBuildUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MqttServerClient build({
    required _i3.MqttClientCredentials? credentials,
    required _i3.MqttClientPath? path,
    required _i3.MqttClientBehavior? behavior,
    required _i3.MqttClientOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #build,
          [],
          {
            #credentials: credentials,
            #path: path,
            #behavior: behavior,
            #options: options,
          },
        ),
        returnValue: _FakeMqttServerClient_0(
          this,
          Invocation.method(
            #build,
            [],
            {
              #credentials: credentials,
              #path: path,
              #behavior: behavior,
              #options: options,
            },
          ),
        ),
      ) as _i2.MqttServerClient);
}

/// A class which mocks [ConnectUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockConnectUsecase extends _i1.Mock implements _i8.ConnectUsecase {
  MockConnectUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MqttClientPath get path => (super.noSuchMethod(
        Invocation.getter(#path),
        returnValue: _FakeMqttClientPath_1(
          this,
          Invocation.getter(#path),
        ),
      ) as _i3.MqttClientPath);

  @override
  _i3.MqttClientCredentials get credentials => (super.noSuchMethod(
        Invocation.getter(#credentials),
        returnValue: _FakeMqttClientCredentials_2(
          this,
          Invocation.getter(#credentials),
        ),
      ) as _i3.MqttClientCredentials);

  @override
  _i4.AwsServiceRepository get awsServiceRepository => (super.noSuchMethod(
        Invocation.getter(#awsServiceRepository),
        returnValue: _FakeAwsServiceRepository_3(
          this,
          Invocation.getter(#awsServiceRepository),
        ),
      ) as _i4.AwsServiceRepository);

  @override
  _i5.MqttClientRepository get mqttClientRepository => (super.noSuchMethod(
        Invocation.getter(#mqttClientRepository),
        returnValue: _FakeMqttClientRepository_4(
          this,
          Invocation.getter(#mqttClientRepository),
        ),
      ) as _i5.MqttClientRepository);

  @override
  _i9.Future<bool> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);
}

/// A class which mocks [DisconnectUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDisconnectUsecase extends _i1.Mock implements _i10.DisconnectUsecase {
  MockDisconnectUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MqttClientRepository get mqttClientRepository => (super.noSuchMethod(
        Invocation.getter(#mqttClientRepository),
        returnValue: _FakeMqttClientRepository_4(
          this,
          Invocation.getter(#mqttClientRepository),
        ),
      ) as _i5.MqttClientRepository);

  @override
  void disconnect() => super.noSuchMethod(
        Invocation.method(
          #disconnect,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [SubscribeToTopicUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSubscribeToTopicUsecase extends _i1.Mock
    implements _i11.SubscribeToTopicUsecase {
  MockSubscribeToTopicUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MqttClientRepository get mqttClientRepository => (super.noSuchMethod(
        Invocation.getter(#mqttClientRepository),
        returnValue: _FakeMqttClientRepository_4(
          this,
          Invocation.getter(#mqttClientRepository),
        ),
      ) as _i5.MqttClientRepository);

  @override
  _i3.MqttClientOptions get options => (super.noSuchMethod(
        Invocation.getter(#options),
        returnValue: _FakeMqttClientOptions_5(
          this,
          Invocation.getter(#options),
        ),
      ) as _i3.MqttClientOptions);

  @override
  _i6.Subscription subscribe(String? topic) => (super.noSuchMethod(
        Invocation.method(
          #subscribe,
          [topic],
        ),
        returnValue: _FakeSubscription_6(
          this,
          Invocation.method(
            #subscribe,
            [topic],
          ),
        ),
      ) as _i6.Subscription);
}

/// A class which mocks [PublishToTopicUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockPublishToTopicUsecase extends _i1.Mock
    implements _i12.PublishToTopicUsecase {
  MockPublishToTopicUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MqttClientRepository get mqttClientRepository => (super.noSuchMethod(
        Invocation.getter(#mqttClientRepository),
        returnValue: _FakeMqttClientRepository_4(
          this,
          Invocation.getter(#mqttClientRepository),
        ),
      ) as _i5.MqttClientRepository);

  @override
  _i3.MqttClientOptions get options => (super.noSuchMethod(
        Invocation.getter(#options),
        returnValue: _FakeMqttClientOptions_5(
          this,
          Invocation.getter(#options),
        ),
      ) as _i3.MqttClientOptions);

  @override
  _i9.Future<int> publish({
    required String? message,
    required String? topic,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #publish,
          [],
          {
            #message: message,
            #topic: topic,
          },
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);
}

/// A class which mocks [UnsubscribeToTopicUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockUnsubscribeToTopicUsecase extends _i1.Mock
    implements _i13.UnsubscribeToTopicUsecase {
  MockUnsubscribeToTopicUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MqttClientRepository get mqttClientRepository => (super.noSuchMethod(
        Invocation.getter(#mqttClientRepository),
        returnValue: _FakeMqttClientRepository_4(
          this,
          Invocation.getter(#mqttClientRepository),
        ),
      ) as _i5.MqttClientRepository);

  @override
  _i3.MqttClientOptions get options => (super.noSuchMethod(
        Invocation.getter(#options),
        returnValue: _FakeMqttClientOptions_5(
          this,
          Invocation.getter(#options),
        ),
      ) as _i3.MqttClientOptions);

  @override
  void unsubscribe({required String? topic}) => super.noSuchMethod(
        Invocation.method(
          #unsubscribe,
          [],
          {#topic: topic},
        ),
        returnValueForMissingStub: null,
      );
}
