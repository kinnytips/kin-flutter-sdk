///
//  Generated code. Do not modify.
//  source: account/v3/account_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CreateAccountResponse_Result extends $pb.ProtobufEnum {
  static const CreateAccountResponse_Result OK = CreateAccountResponse_Result._(0, 'OK');
  static const CreateAccountResponse_Result EXISTS = CreateAccountResponse_Result._(1, 'EXISTS');

  static const $core.List<CreateAccountResponse_Result> values = <CreateAccountResponse_Result> [
    OK,
    EXISTS,
  ];

  static final $core.Map<$core.int, CreateAccountResponse_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CreateAccountResponse_Result valueOf($core.int value) => _byValue[value];

  const CreateAccountResponse_Result._($core.int v, $core.String n) : super(v, n);
}

class GetAccountInfoResponse_Result extends $pb.ProtobufEnum {
  static const GetAccountInfoResponse_Result OK = GetAccountInfoResponse_Result._(0, 'OK');
  static const GetAccountInfoResponse_Result NOT_FOUND = GetAccountInfoResponse_Result._(1, 'NOT_FOUND');

  static const $core.List<GetAccountInfoResponse_Result> values = <GetAccountInfoResponse_Result> [
    OK,
    NOT_FOUND,
  ];

  static final $core.Map<$core.int, GetAccountInfoResponse_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetAccountInfoResponse_Result valueOf($core.int value) => _byValue[value];

  const GetAccountInfoResponse_Result._($core.int v, $core.String n) : super(v, n);
}

class Events_Result extends $pb.ProtobufEnum {
  static const Events_Result OK = Events_Result._(0, 'OK');
  static const Events_Result NOT_FOUND = Events_Result._(1, 'NOT_FOUND');

  static const $core.List<Events_Result> values = <Events_Result> [
    OK,
    NOT_FOUND,
  ];

  static final $core.Map<$core.int, Events_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Events_Result valueOf($core.int value) => _byValue[value];

  const Events_Result._($core.int v, $core.String n) : super(v, n);
}

