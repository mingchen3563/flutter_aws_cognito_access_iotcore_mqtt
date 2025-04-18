// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_aws_cognito_access_iotcore_mqtt/test/src/data/aws_sign_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:aws_common/aws_common.dart' as _i3;
import 'package:aws_signature_v4/aws_signature_v4.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

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

class _FakeAWSAlgorithm_0 extends _i1.SmartFake implements _i2.AWSAlgorithm {
  _FakeAWSAlgorithm_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAWSCredentialsProvider_1 extends _i1.SmartFake
    implements _i3.AWSCredentialsProvider {
  _FakeAWSCredentialsProvider_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUri_2 extends _i1.SmartFake implements Uri {
  _FakeUri_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAWSSignedRequest_3 extends _i1.SmartFake
    implements _i2.AWSSignedRequest {
  _FakeAWSSignedRequest_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AWSSigV4Signer].
///
/// See the documentation for Mockito's code generation for more information.
class MockAWSSigV4Signer extends _i1.Mock implements _i2.AWSSigV4Signer {
  MockAWSSigV4Signer() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AWSAlgorithm get algorithm => (super.noSuchMethod(
        Invocation.getter(#algorithm),
        returnValue: _FakeAWSAlgorithm_0(
          this,
          Invocation.getter(#algorithm),
        ),
      ) as _i2.AWSAlgorithm);

  @override
  _i3.AWSCredentialsProvider get credentialsProvider => (super.noSuchMethod(
        Invocation.getter(#credentialsProvider),
        returnValue: _FakeAWSCredentialsProvider_1(
          this,
          Invocation.getter(#credentialsProvider),
        ),
      ) as _i3.AWSCredentialsProvider);

  @override
  _i4.Future<Uri> presign(
    _i3.AWSHttpRequest? request, {
    required _i2.AWSCredentialScope? credentialScope,
    _i2.ServiceConfiguration? serviceConfiguration =
        const _i2.BaseServiceConfiguration(),
    required Duration? expiresIn,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #presign,
          [request],
          {
            #credentialScope: credentialScope,
            #serviceConfiguration: serviceConfiguration,
            #expiresIn: expiresIn,
          },
        ),
        returnValue: _i4.Future<Uri>.value(_FakeUri_2(
          this,
          Invocation.method(
            #presign,
            [request],
            {
              #credentialScope: credentialScope,
              #serviceConfiguration: serviceConfiguration,
              #expiresIn: expiresIn,
            },
          ),
        )),
      ) as _i4.Future<Uri>);

  @override
  Uri presignSync(
    _i3.AWSHttpRequest? request, {
    required _i2.AWSCredentialScope? credentialScope,
    _i2.ServiceConfiguration? serviceConfiguration =
        const _i2.BaseServiceConfiguration(),
    required Duration? expiresIn,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #presignSync,
          [request],
          {
            #credentialScope: credentialScope,
            #serviceConfiguration: serviceConfiguration,
            #expiresIn: expiresIn,
          },
        ),
        returnValue: _FakeUri_2(
          this,
          Invocation.method(
            #presignSync,
            [request],
            {
              #credentialScope: credentialScope,
              #serviceConfiguration: serviceConfiguration,
              #expiresIn: expiresIn,
            },
          ),
        ),
      ) as Uri);

  @override
  _i4.Future<_i2.AWSSignedRequest> sign(
    _i3.AWSBaseHttpRequest? request, {
    required _i2.AWSCredentialScope? credentialScope,
    _i2.ServiceConfiguration? serviceConfiguration =
        const _i2.BaseServiceConfiguration(),
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #sign,
          [request],
          {
            #credentialScope: credentialScope,
            #serviceConfiguration: serviceConfiguration,
          },
        ),
        returnValue:
            _i4.Future<_i2.AWSSignedRequest>.value(_FakeAWSSignedRequest_3(
          this,
          Invocation.method(
            #sign,
            [request],
            {
              #credentialScope: credentialScope,
              #serviceConfiguration: serviceConfiguration,
            },
          ),
        )),
      ) as _i4.Future<_i2.AWSSignedRequest>);

  @override
  _i2.AWSSignedRequest signSync(
    _i3.AWSBaseHttpRequest? request, {
    required _i2.AWSCredentialScope? credentialScope,
    _i2.ServiceConfiguration? serviceConfiguration =
        const _i2.BaseServiceConfiguration(),
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #signSync,
          [request],
          {
            #credentialScope: credentialScope,
            #serviceConfiguration: serviceConfiguration,
          },
        ),
        returnValue: _FakeAWSSignedRequest_3(
          this,
          Invocation.method(
            #signSync,
            [request],
            {
              #credentialScope: credentialScope,
              #serviceConfiguration: serviceConfiguration,
            },
          ),
        ),
      ) as _i2.AWSSignedRequest);

  @override
  String stringToSign({
    required _i2.AWSAlgorithm? algorithm,
    required _i2.AWSCredentialScope? credentialScope,
    required _i2.CanonicalRequest? canonicalRequest,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #stringToSign,
          [],
          {
            #algorithm: algorithm,
            #credentialScope: credentialScope,
            #canonicalRequest: canonicalRequest,
          },
        ),
        returnValue: _i5.dummyValue<String>(
          this,
          Invocation.method(
            #stringToSign,
            [],
            {
              #algorithm: algorithm,
              #credentialScope: credentialScope,
              #canonicalRequest: canonicalRequest,
            },
          ),
        ),
      ) as String);

  @override
  String createAuthorizationHeader({
    required _i3.AWSCredentials? credentials,
    required _i2.AWSCredentialScope? credentialScope,
    required _i2.SignedHeaders? signedHeaders,
    required String? signature,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createAuthorizationHeader,
          [],
          {
            #credentials: credentials,
            #credentialScope: credentialScope,
            #signedHeaders: signedHeaders,
            #signature: signature,
          },
        ),
        returnValue: _i5.dummyValue<String>(
          this,
          Invocation.method(
            #createAuthorizationHeader,
            [],
            {
              #credentials: credentials,
              #credentialScope: credentialScope,
              #signedHeaders: signedHeaders,
              #signature: signature,
            },
          ),
        ),
      ) as String);
}
