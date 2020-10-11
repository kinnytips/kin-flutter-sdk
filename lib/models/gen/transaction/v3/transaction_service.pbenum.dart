///
//  Generated code. Do not modify.
//  source: transaction/v3/transaction_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class GetHistoryRequest_Direction extends $pb.ProtobufEnum {
  static const GetHistoryRequest_Direction ASC = GetHistoryRequest_Direction._(0, 'ASC');
  static const GetHistoryRequest_Direction DESC = GetHistoryRequest_Direction._(1, 'DESC');

  static const $core.List<GetHistoryRequest_Direction> values = <GetHistoryRequest_Direction> [
    ASC,
    DESC,
  ];

  static final $core.Map<$core.int, GetHistoryRequest_Direction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetHistoryRequest_Direction valueOf($core.int value) => _byValue[value];

  const GetHistoryRequest_Direction._($core.int v, $core.String n) : super(v, n);
}

class GetHistoryResponse_Result extends $pb.ProtobufEnum {
  static const GetHistoryResponse_Result OK = GetHistoryResponse_Result._(0, 'OK');
  static const GetHistoryResponse_Result NOT_FOUND = GetHistoryResponse_Result._(1, 'NOT_FOUND');

  static const $core.List<GetHistoryResponse_Result> values = <GetHistoryResponse_Result> [
    OK,
    NOT_FOUND,
  ];

  static final $core.Map<$core.int, GetHistoryResponse_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetHistoryResponse_Result valueOf($core.int value) => _byValue[value];

  const GetHistoryResponse_Result._($core.int v, $core.String n) : super(v, n);
}

class SubmitTransactionResponse_Result extends $pb.ProtobufEnum {
  static const SubmitTransactionResponse_Result OK = SubmitTransactionResponse_Result._(0, 'OK');
  static const SubmitTransactionResponse_Result FAILED = SubmitTransactionResponse_Result._(1, 'FAILED');
  static const SubmitTransactionResponse_Result REJECTED = SubmitTransactionResponse_Result._(2, 'REJECTED');
  static const SubmitTransactionResponse_Result INVOICE_ERROR = SubmitTransactionResponse_Result._(3, 'INVOICE_ERROR');

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

class SubmitTransactionResponse_InvoiceError_Reason extends $pb.ProtobufEnum {
  static const SubmitTransactionResponse_InvoiceError_Reason UNKNOWN = SubmitTransactionResponse_InvoiceError_Reason._(0, 'UNKNOWN');
  static const SubmitTransactionResponse_InvoiceError_Reason ALREADY_PAID = SubmitTransactionResponse_InvoiceError_Reason._(1, 'ALREADY_PAID');
  static const SubmitTransactionResponse_InvoiceError_Reason WRONG_DESTINATION = SubmitTransactionResponse_InvoiceError_Reason._(2, 'WRONG_DESTINATION');
  static const SubmitTransactionResponse_InvoiceError_Reason SKU_NOT_FOUND = SubmitTransactionResponse_InvoiceError_Reason._(3, 'SKU_NOT_FOUND');

  static const $core.List<SubmitTransactionResponse_InvoiceError_Reason> values = <SubmitTransactionResponse_InvoiceError_Reason> [
    UNKNOWN,
    ALREADY_PAID,
    WRONG_DESTINATION,
    SKU_NOT_FOUND,
  ];

  static final $core.Map<$core.int, SubmitTransactionResponse_InvoiceError_Reason> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SubmitTransactionResponse_InvoiceError_Reason valueOf($core.int value) => _byValue[value];

  const SubmitTransactionResponse_InvoiceError_Reason._($core.int v, $core.String n) : super(v, n);
}

class GetTransactionResponse_State extends $pb.ProtobufEnum {
  static const GetTransactionResponse_State UNKNOWN = GetTransactionResponse_State._(0, 'UNKNOWN');
  static const GetTransactionResponse_State SUCCESS = GetTransactionResponse_State._(1, 'SUCCESS');

  static const $core.List<GetTransactionResponse_State> values = <GetTransactionResponse_State> [
    UNKNOWN,
    SUCCESS,
  ];

  static final $core.Map<$core.int, GetTransactionResponse_State> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetTransactionResponse_State valueOf($core.int value) => _byValue[value];

  const GetTransactionResponse_State._($core.int v, $core.String n) : super(v, n);
}

