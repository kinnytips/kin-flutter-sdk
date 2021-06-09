///
//  Generated code. Do not modify.
//  source: transaction/v3/transaction_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class GetHistoryRequest_Direction extends $pb.ProtobufEnum {
  static const GetHistoryRequest_Direction ASC = GetHistoryRequest_Direction._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ASC');
  static const GetHistoryRequest_Direction DESC = GetHistoryRequest_Direction._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DESC');

  static const $core.List<GetHistoryRequest_Direction> values = <GetHistoryRequest_Direction> [
    ASC,
    DESC,
  ];

  static final $core.Map<$core.int, GetHistoryRequest_Direction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetHistoryRequest_Direction valueOf($core.int value) => _byValue[value];

  const GetHistoryRequest_Direction._($core.int v, $core.String n) : super(v, n);
}

class GetHistoryResponse_Result extends $pb.ProtobufEnum {
  static const GetHistoryResponse_Result OK = GetHistoryResponse_Result._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const GetHistoryResponse_Result NOT_FOUND = GetHistoryResponse_Result._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOT_FOUND');

  static const $core.List<GetHistoryResponse_Result> values = <GetHistoryResponse_Result> [
    OK,
    NOT_FOUND,
  ];

  static final $core.Map<$core.int, GetHistoryResponse_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetHistoryResponse_Result valueOf($core.int value) => _byValue[value];

  const GetHistoryResponse_Result._($core.int v, $core.String n) : super(v, n);
}

class SubmitTransactionResponse_Result extends $pb.ProtobufEnum {
  static const SubmitTransactionResponse_Result OK = SubmitTransactionResponse_Result._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const SubmitTransactionResponse_Result FAILED = SubmitTransactionResponse_Result._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILED');
  static const SubmitTransactionResponse_Result REJECTED = SubmitTransactionResponse_Result._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REJECTED');
  static const SubmitTransactionResponse_Result INVOICE_ERROR = SubmitTransactionResponse_Result._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVOICE_ERROR');

  static const $core.List<SubmitTransactionResponse_Result> values = <SubmitTransactionResponse_Result> [
    OK,
    FAILED,
    REJECTED,
    INVOICE_ERROR,
  ];

  static final $core.Map<$core.int, SubmitTransactionResponse_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SubmitTransactionResponse_Result valueOf($core.int value) => _byValue[value];

  const SubmitTransactionResponse_Result._($core.int v, $core.String n) : super(v, n);
}

class GetTransactionResponse_State extends $pb.ProtobufEnum {
  static const GetTransactionResponse_State UNKNOWN = GetTransactionResponse_State._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const GetTransactionResponse_State SUCCESS = GetTransactionResponse_State._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUCCESS');

  static const $core.List<GetTransactionResponse_State> values = <GetTransactionResponse_State> [
    UNKNOWN,
    SUCCESS,
  ];

  static final $core.Map<$core.int, GetTransactionResponse_State> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetTransactionResponse_State valueOf($core.int value) => _byValue[value];

  const GetTransactionResponse_State._($core.int v, $core.String n) : super(v, n);
}

