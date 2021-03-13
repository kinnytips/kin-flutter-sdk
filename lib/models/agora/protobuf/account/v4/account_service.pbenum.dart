///
//  Generated code. Do not modify.
//  source: account/v4/account_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CreateAccountResponse_Result extends $pb.ProtobufEnum {
  static const CreateAccountResponse_Result OK = CreateAccountResponse_Result._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const CreateAccountResponse_Result EXISTS = CreateAccountResponse_Result._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXISTS');
  static const CreateAccountResponse_Result PAYER_REQUIRED = CreateAccountResponse_Result._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAYER_REQUIRED');
  static const CreateAccountResponse_Result BAD_NONCE = CreateAccountResponse_Result._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BAD_NONCE');

  static const $core.List<CreateAccountResponse_Result> values = <CreateAccountResponse_Result> [
    OK,
    EXISTS,
    PAYER_REQUIRED,
    BAD_NONCE,
  ];

  static final $core.Map<$core.int, CreateAccountResponse_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CreateAccountResponse_Result valueOf($core.int value) => _byValue[value];

  const CreateAccountResponse_Result._($core.int v, $core.String n) : super(v, n);
}

class GetAccountInfoResponse_Result extends $pb.ProtobufEnum {
  static const GetAccountInfoResponse_Result OK = GetAccountInfoResponse_Result._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const GetAccountInfoResponse_Result NOT_FOUND = GetAccountInfoResponse_Result._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOT_FOUND');

  static const $core.List<GetAccountInfoResponse_Result> values = <GetAccountInfoResponse_Result> [
    OK,
    NOT_FOUND,
  ];

  static final $core.Map<$core.int, GetAccountInfoResponse_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetAccountInfoResponse_Result valueOf($core.int value) => _byValue[value];

  const GetAccountInfoResponse_Result._($core.int v, $core.String n) : super(v, n);
}

class Events_Result extends $pb.ProtobufEnum {
  static const Events_Result OK = Events_Result._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const Events_Result NOT_FOUND = Events_Result._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOT_FOUND');

  static const $core.List<Events_Result> values = <Events_Result> [
    OK,
    NOT_FOUND,
  ];

  static final $core.Map<$core.int, Events_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Events_Result valueOf($core.int value) => _byValue[value];

  const Events_Result._($core.int v, $core.String n) : super(v, n);
}

