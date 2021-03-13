///
//  Generated code. Do not modify.
//  source: transaction/v3/transaction_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use getHistoryRequestDescriptor instead')
const GetHistoryRequest$json = const {
  '1': 'GetHistoryRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.StellarAccountId', '8': const {}, '10': 'accountId'},
    const {'1': 'cursor', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.transaction.v3.Cursor', '10': 'cursor'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 14, '6': '.kin.agora.transaction.v3.GetHistoryRequest.Direction', '10': 'direction'},
  ],
  '4': const [GetHistoryRequest_Direction$json],
};

@$core.Deprecated('Use getHistoryRequestDescriptor instead')
const GetHistoryRequest_Direction$json = const {
  '1': 'Direction',
  '2': const [
    const {'1': 'ASC', '2': 0},
    const {'1': 'DESC', '2': 1},
  ],
};

/// Descriptor for `GetHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoryRequestDescriptor = $convert.base64Decode('ChFHZXRIaXN0b3J5UmVxdWVzdBJOCgphY2NvdW50X2lkGAEgASgLMiUua2luLmFnb3JhLmNvbW1vbi52My5TdGVsbGFyQWNjb3VudElkQgj6QgWKAQIQAVIJYWNjb3VudElkEjgKBmN1cnNvchgCIAEoCzIgLmtpbi5hZ29yYS50cmFuc2FjdGlvbi52My5DdXJzb3JSBmN1cnNvchJTCglkaXJlY3Rpb24YAyABKA4yNS5raW4uYWdvcmEudHJhbnNhY3Rpb24udjMuR2V0SGlzdG9yeVJlcXVlc3QuRGlyZWN0aW9uUglkaXJlY3Rpb24iHgoJRGlyZWN0aW9uEgcKA0FTQxAAEggKBERFU0MQAQ==');
@$core.Deprecated('Use getHistoryResponseDescriptor instead')
const GetHistoryResponse$json = const {
  '1': 'GetHistoryResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.transaction.v3.GetHistoryResponse.Result', '10': 'result'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.kin.agora.transaction.v3.HistoryItem', '8': const {}, '10': 'items'},
  ],
  '4': const [GetHistoryResponse_Result$json],
};

@$core.Deprecated('Use getHistoryResponseDescriptor instead')
const GetHistoryResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'NOT_FOUND', '2': 1},
  ],
};

/// Descriptor for `GetHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoryResponseDescriptor = $convert.base64Decode('ChJHZXRIaXN0b3J5UmVzcG9uc2USSwoGcmVzdWx0GAEgASgOMjMua2luLmFnb3JhLnRyYW5zYWN0aW9uLnYzLkdldEhpc3RvcnlSZXNwb25zZS5SZXN1bHRSBnJlc3VsdBJICgVpdGVtcxgCIAMoCzIlLmtpbi5hZ29yYS50cmFuc2FjdGlvbi52My5IaXN0b3J5SXRlbUIL+kIIkgEFCAAQgAFSBWl0ZW1zIh8KBlJlc3VsdBIGCgJPSxAAEg0KCU5PVF9GT1VORBAB');
@$core.Deprecated('Use submitTransactionRequestDescriptor instead')
const SubmitTransactionRequest$json = const {
  '1': 'SubmitTransactionRequest',
  '2': const [
    const {'1': 'envelope_xdr', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'envelopeXdr'},
    const {'1': 'invoice_list', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v3.InvoiceList', '10': 'invoiceList'},
  ],
};

/// Descriptor for `SubmitTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitTransactionRequestDescriptor = $convert.base64Decode('ChhTdWJtaXRUcmFuc2FjdGlvblJlcXVlc3QSLQoMZW52ZWxvcGVfeGRyGAEgASgMQgr6Qgd6BRABGIBQUgtlbnZlbG9wZVhkchJDCgxpbnZvaWNlX2xpc3QYAiABKAsyIC5raW4uYWdvcmEuY29tbW9uLnYzLkludm9pY2VMaXN0UgtpbnZvaWNlTGlzdA==');
@$core.Deprecated('Use submitTransactionResponseDescriptor instead')
const SubmitTransactionResponse$json = const {
  '1': 'SubmitTransactionResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.transaction.v3.SubmitTransactionResponse.Result', '10': 'result'},
    const {'1': 'invoice_errors', '3': 2, '4': 3, '5': 11, '6': '.kin.agora.transaction.v3.SubmitTransactionResponse.InvoiceError', '10': 'invoiceErrors'},
    const {'1': 'hash', '3': 3, '4': 1, '5': 11, '6': '.kin.agora.common.v3.TransactionHash', '10': 'hash'},
    const {
      '1': 'ledger',
      '3': 4,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'ledger',
    },
    const {'1': 'result_xdr', '3': 5, '4': 1, '5': 12, '8': const {}, '10': 'resultXdr'},
  ],
  '3': const [SubmitTransactionResponse_InvoiceError$json],
  '4': const [SubmitTransactionResponse_Result$json],
};

@$core.Deprecated('Use submitTransactionResponseDescriptor instead')
const SubmitTransactionResponse_InvoiceError$json = const {
  '1': 'InvoiceError',
  '2': const [
    const {'1': 'op_index', '3': 1, '4': 1, '5': 13, '8': const {}, '10': 'opIndex'},
    const {'1': 'invoice', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v3.Invoice', '8': const {}, '10': 'invoice'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 14, '6': '.kin.agora.transaction.v3.SubmitTransactionResponse.InvoiceError.Reason', '10': 'reason'},
  ],
  '4': const [SubmitTransactionResponse_InvoiceError_Reason$json],
};

@$core.Deprecated('Use submitTransactionResponseDescriptor instead')
const SubmitTransactionResponse_InvoiceError_Reason$json = const {
  '1': 'Reason',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'ALREADY_PAID', '2': 1},
    const {'1': 'WRONG_DESTINATION', '2': 2},
    const {'1': 'SKU_NOT_FOUND', '2': 3},
  ],
};

@$core.Deprecated('Use submitTransactionResponseDescriptor instead')
const SubmitTransactionResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'FAILED', '2': 1},
    const {'1': 'REJECTED', '2': 2},
    const {'1': 'INVOICE_ERROR', '2': 3},
  ],
};

/// Descriptor for `SubmitTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitTransactionResponseDescriptor = $convert.base64Decode('ChlTdWJtaXRUcmFuc2FjdGlvblJlc3BvbnNlElIKBnJlc3VsdBgBIAEoDjI6Lmtpbi5hZ29yYS50cmFuc2FjdGlvbi52My5TdWJtaXRUcmFuc2FjdGlvblJlc3BvbnNlLlJlc3VsdFIGcmVzdWx0EmcKDmludm9pY2VfZXJyb3JzGAIgAygLMkAua2luLmFnb3JhLnRyYW5zYWN0aW9uLnYzLlN1Ym1pdFRyYW5zYWN0aW9uUmVzcG9uc2UuSW52b2ljZUVycm9yUg1pbnZvaWNlRXJyb3JzEjgKBGhhc2gYAyABKAsyJC5raW4uYWdvcmEuY29tbW9uLnYzLlRyYW5zYWN0aW9uSGFzaFIEaGFzaBIaCgZsZWRnZXIYBCABKANCAjABUgZsZWRnZXISKQoKcmVzdWx0X3hkchgFIAEoDEIK+kIHegUQABiAUFIJcmVzdWx0WGRyGqgCCgxJbnZvaWNlRXJyb3ISIgoIb3BfaW5kZXgYASABKA1CB/pCBCoCGGRSB29wSW5kZXgSQAoHaW52b2ljZRgCIAEoCzIcLmtpbi5hZ29yYS5jb21tb24udjMuSW52b2ljZUII+kIFigECEAFSB2ludm9pY2USXwoGcmVhc29uGAMgASgOMkcua2luLmFnb3JhLnRyYW5zYWN0aW9uLnYzLlN1Ym1pdFRyYW5zYWN0aW9uUmVzcG9uc2UuSW52b2ljZUVycm9yLlJlYXNvblIGcmVhc29uIlEKBlJlYXNvbhILCgdVTktOT1dOEAASEAoMQUxSRUFEWV9QQUlEEAESFQoRV1JPTkdfREVTVElOQVRJT04QAhIRCg1TS1VfTk9UX0ZPVU5EEAMiPQoGUmVzdWx0EgYKAk9LEAASCgoGRkFJTEVEEAESDAoIUkVKRUNURUQQAhIRCg1JTlZPSUNFX0VSUk9SEAM=');
@$core.Deprecated('Use getTransactionRequestDescriptor instead')
const GetTransactionRequest$json = const {
  '1': 'GetTransactionRequest',
  '2': const [
    const {'1': 'transaction_hash', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.TransactionHash', '8': const {}, '10': 'transactionHash'},
  ],
};

/// Descriptor for `GetTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionRequestDescriptor = $convert.base64Decode('ChVHZXRUcmFuc2FjdGlvblJlcXVlc3QSWQoQdHJhbnNhY3Rpb25faGFzaBgBIAEoCzIkLmtpbi5hZ29yYS5jb21tb24udjMuVHJhbnNhY3Rpb25IYXNoQgj6QgWKAQIQAVIPdHJhbnNhY3Rpb25IYXNo');
@$core.Deprecated('Use getTransactionResponseDescriptor instead')
const GetTransactionResponse$json = const {
  '1': 'GetTransactionResponse',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.transaction.v3.GetTransactionResponse.State', '10': 'state'},
    const {
      '1': 'ledger',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'ledger',
    },
    const {'1': 'item', '3': 3, '4': 1, '5': 11, '6': '.kin.agora.transaction.v3.HistoryItem', '10': 'item'},
  ],
  '4': const [GetTransactionResponse_State$json],
};

@$core.Deprecated('Use getTransactionResponseDescriptor instead')
const GetTransactionResponse_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'SUCCESS', '2': 1},
  ],
};

/// Descriptor for `GetTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionResponseDescriptor = $convert.base64Decode('ChZHZXRUcmFuc2FjdGlvblJlc3BvbnNlEkwKBXN0YXRlGAEgASgOMjYua2luLmFnb3JhLnRyYW5zYWN0aW9uLnYzLkdldFRyYW5zYWN0aW9uUmVzcG9uc2UuU3RhdGVSBXN0YXRlEhoKBmxlZGdlchgCIAEoA0ICMAFSBmxlZGdlchI5CgRpdGVtGAMgASgLMiUua2luLmFnb3JhLnRyYW5zYWN0aW9uLnYzLkhpc3RvcnlJdGVtUgRpdGVtIiEKBVN0YXRlEgsKB1VOS05PV04QABILCgdTVUNDRVNTEAE=');
@$core.Deprecated('Use historyItemDescriptor instead')
const HistoryItem$json = const {
  '1': 'HistoryItem',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.TransactionHash', '8': const {}, '10': 'hash'},
    const {'1': 'result_xdr', '3': 2, '4': 1, '5': 12, '8': const {}, '10': 'resultXdr'},
    const {'1': 'envelope_xdr', '3': 3, '4': 1, '5': 12, '8': const {}, '10': 'envelopeXdr'},
    const {'1': 'cursor', '3': 4, '4': 1, '5': 11, '6': '.kin.agora.transaction.v3.Cursor', '10': 'cursor'},
    const {'1': 'invoice_list', '3': 5, '4': 1, '5': 11, '6': '.kin.agora.common.v3.InvoiceList', '10': 'invoiceList'},
  ],
};

/// Descriptor for `HistoryItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyItemDescriptor = $convert.base64Decode('CgtIaXN0b3J5SXRlbRJCCgRoYXNoGAEgASgLMiQua2luLmFnb3JhLmNvbW1vbi52My5UcmFuc2FjdGlvbkhhc2hCCPpCBYoBAhABUgRoYXNoEikKCnJlc3VsdF94ZHIYAiABKAxCCvpCB3oFEAEYgFBSCXJlc3VsdFhkchItCgxlbnZlbG9wZV94ZHIYAyABKAxCCvpCB3oFEAEYgFBSC2VudmVsb3BlWGRyEjgKBmN1cnNvchgEIAEoCzIgLmtpbi5hZ29yYS50cmFuc2FjdGlvbi52My5DdXJzb3JSBmN1cnNvchJDCgxpbnZvaWNlX2xpc3QYBSABKAsyIC5raW4uYWdvcmEuY29tbW9uLnYzLkludm9pY2VMaXN0UgtpbnZvaWNlTGlzdA==');
@$core.Deprecated('Use cursorDescriptor instead')
const Cursor$json = const {
  '1': 'Cursor',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

/// Descriptor for `Cursor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cursorDescriptor = $convert.base64Decode('CgZDdXJzb3ISIAoFdmFsdWUYASABKAxCCvpCB3oFEAEYgAFSBXZhbHVl');
