///
//  Generated code. Do not modify.
//  source: airdrop/v4/airdrop_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class RequestAirdropResponse_Result extends $pb.ProtobufEnum {
  static const RequestAirdropResponse_Result OK = RequestAirdropResponse_Result._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const RequestAirdropResponse_Result NOT_FOUND = RequestAirdropResponse_Result._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOT_FOUND');
  static const RequestAirdropResponse_Result INSUFFICIENT_KIN = RequestAirdropResponse_Result._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INSUFFICIENT_KIN');

  static const $core.List<RequestAirdropResponse_Result> values = <RequestAirdropResponse_Result> [
    OK,
    NOT_FOUND,
    INSUFFICIENT_KIN,
  ];

  static final $core.Map<$core.int, RequestAirdropResponse_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RequestAirdropResponse_Result valueOf($core.int value) => _byValue[value];

  const RequestAirdropResponse_Result._($core.int v, $core.String n) : super(v, n);
}

