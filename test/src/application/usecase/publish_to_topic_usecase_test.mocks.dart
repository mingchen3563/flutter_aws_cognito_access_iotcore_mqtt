// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_aws_cognito_access_iotcore_mqtt/test/src/application/usecase/publish_to_topic_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_aws_cognito_access_iotcore_mqtt/src/domain/repositories/mqtt_client_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mqtt_client/mqtt_client.dart' as _i4;

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

/// A class which mocks [MqttClientRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMqttClientRepository extends _i1.Mock
    implements _i2.MqttClientRepository {
  @override
  _i3.Future<bool> connect() => (super.noSuchMethod(
        Invocation.method(
          #connect,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<void> disconnect() => (super.noSuchMethod(
        Invocation.method(
          #disconnect,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  int publish(
    String? topic,
    String? message,
    _i4.MqttQos? qos,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #publish,
          [
            topic,
            message,
            qos,
          ],
        ),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  _i4.Subscription? subscribe(
    String? topic,
    _i4.MqttQos? qos,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #subscribe,
          [
            topic,
            qos,
          ],
        ),
        returnValueForMissingStub: null,
      ) as _i4.Subscription?);

  @override
  void unsubscribe(String? topic) => super.noSuchMethod(
        Invocation.method(
          #unsubscribe,
          [topic],
        ),
        returnValueForMissingStub: null,
      );
}
