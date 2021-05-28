///
//  Generated code. Do not modify.
//  source: transaction/v4/transaction_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use getServiceConfigRequestDescriptor instead')
const GetServiceConfigRequest$json = const {
  '1': 'GetServiceConfigRequest',
};

/// Descriptor for `GetServiceConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceConfigRequestDescriptor = $convert.base64Decode('ChdHZXRTZXJ2aWNlQ29uZmlnUmVxdWVzdA==');
@$core.Deprecated('Use getServiceConfigResponseDescriptor instead')
const GetServiceConfigResponse$json = const {
  '1': 'GetServiceConfigResponse',
  '2': const [
    const {'1': 'subsidizer_account', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '10': 'subsidizerAccount'},
    const {'1': 'token_program', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '8': const {}, '10': 'tokenProgram'},
    const {'1': 'token', '3': 3, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '8': const {}, '10': 'token'},
  ],
};

/// Descriptor for `GetServiceConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceConfigResponseDescriptor = $convert.base64Decode('ChhHZXRTZXJ2aWNlQ29uZmlnUmVzcG9uc2USUwoSc3Vic2lkaXplcl9hY2NvdW50GAEgASgLMiQua2luLmFnb3JhLmNvbW1vbi52NC5Tb2xhbmFBY2NvdW50SWRSEXN1YnNpZGl6ZXJBY2NvdW50ElMKDXRva2VuX3Byb2dyYW0YAiABKAsyJC5raW4uYWdvcmEuY29tbW9uLnY0LlNvbGFuYUFjY291bnRJZEII+kIFigECEAFSDHRva2VuUHJvZ3JhbRJECgV0b2tlbhgDIAEoCzIkLmtpbi5hZ29yYS5jb21tb24udjQuU29sYW5hQWNjb3VudElkQgj6QgWKAQIQAVIFdG9rZW4=');
@$core.Deprecated('Use getMinimumKinVersionRequestDescriptor instead')
const GetMinimumKinVersionRequest$json = const {
  '1': 'GetMinimumKinVersionRequest',
};

/// Descriptor for `GetMinimumKinVersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMinimumKinVersionRequestDescriptor = $convert.base64Decode('ChtHZXRNaW5pbXVtS2luVmVyc2lvblJlcXVlc3Q=');
@$core.Deprecated('Use getMinimumKinVersionResponseDescriptor instead')
const GetMinimumKinVersionResponse$json = const {
  '1': 'GetMinimumKinVersionResponse',
  '2': const [
    const {'1': 'version', '3': 1, '4': 1, '5': 13, '10': 'version'},
  ],
};

/// Descriptor for `GetMinimumKinVersionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMinimumKinVersionResponseDescriptor = $convert.base64Decode('ChxHZXRNaW5pbXVtS2luVmVyc2lvblJlc3BvbnNlEhgKB3ZlcnNpb24YASABKA1SB3ZlcnNpb24=');
@$core.Deprecated('Use getRecentBlockhashRequestDescriptor instead')
const GetRecentBlockhashRequest$json = const {
  '1': 'GetRecentBlockhashRequest',
};

/// Descriptor for `GetRecentBlockhashRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentBlockhashRequestDescriptor = $convert.base64Decode('ChlHZXRSZWNlbnRCbG9ja2hhc2hSZXF1ZXN0');
@$core.Deprecated('Use getRecentBlockhashResponseDescriptor instead')
const GetRecentBlockhashResponse$json = const {
  '1': 'GetRecentBlockhashResponse',
  '2': const [
    const {'1': 'blockhash', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.Blockhash', '8': const {}, '10': 'blockhash'},
  ],
};

/// Descriptor for `GetRecentBlockhashResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentBlockhashResponseDescriptor = $convert.base64Decode('ChpHZXRSZWNlbnRCbG9ja2hhc2hSZXNwb25zZRJGCglibG9ja2hhc2gYASABKAsyHi5raW4uYWdvcmEuY29tbW9uLnY0LkJsb2NraGFzaEII+kIFigECEAFSCWJsb2NraGFzaA==');
@$core.Deprecated('Use getMinimumBalanceForRentExemptionRequestDescriptor instead')
const GetMinimumBalanceForRentExemptionRequest$json = const {
  '1': 'GetMinimumBalanceForRentExemptionRequest',
  '2': const [
    const {'1': 'size', '3': 1, '4': 1, '5': 4, '10': 'size'},
  ],
};

/// Descriptor for `GetMinimumBalanceForRentExemptionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMinimumBalanceForRentExemptionRequestDescriptor = $convert.base64Decode('CihHZXRNaW5pbXVtQmFsYW5jZUZvclJlbnRFeGVtcHRpb25SZXF1ZXN0EhIKBHNpemUYASABKARSBHNpemU=');
@$core.Deprecated('Use getMinimumBalanceForRentExemptionResponseDescriptor instead')
const GetMinimumBalanceForRentExemptionResponse$json = const {
  '1': 'GetMinimumBalanceForRentExemptionResponse',
  '2': const [
    const {'1': 'lamports', '3': 1, '4': 1, '5': 4, '10': 'lamports'},
  ],
};

/// Descriptor for `GetMinimumBalanceForRentExemptionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMinimumBalanceForRentExemptionResponseDescriptor = $convert.base64Decode('CilHZXRNaW5pbXVtQmFsYW5jZUZvclJlbnRFeGVtcHRpb25SZXNwb25zZRIaCghsYW1wb3J0cxgBIAEoBFIIbGFtcG9ydHM=');
@$core.Deprecated('Use getHistoryRequestDescriptor instead')
const GetHistoryRequest$json = const {
  '1': 'GetHistoryRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '8': const {}, '10': 'accountId'},
    const {'1': 'cursor', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.transaction.v4.Cursor', '10': 'cursor'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 14, '6': '.kin.agora.transaction.v4.GetHistoryRequest.Direction', '10': 'direction'},
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
final $typed_data.Uint8List getHistoryRequestDescriptor = $convert.base64Decode('ChFHZXRIaXN0b3J5UmVxdWVzdBJNCgphY2NvdW50X2lkGAEgASgLMiQua2luLmFnb3JhLmNvbW1vbi52NC5Tb2xhbmFBY2NvdW50SWRCCPpCBYoBAhABUglhY2NvdW50SWQSOAoGY3Vyc29yGAIgASgLMiAua2luLmFnb3JhLnRyYW5zYWN0aW9uLnY0LkN1cnNvclIGY3Vyc29yElMKCWRpcmVjdGlvbhgDIAEoDjI1Lmtpbi5hZ29yYS50cmFuc2FjdGlvbi52NC5HZXRIaXN0b3J5UmVxdWVzdC5EaXJlY3Rpb25SCWRpcmVjdGlvbiIeCglEaXJlY3Rpb24SBwoDQVNDEAASCAoEREVTQxAB');
@$core.Deprecated('Use getHistoryResponseDescriptor instead')
const GetHistoryResponse$json = const {
  '1': 'GetHistoryResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.transaction.v4.GetHistoryResponse.Result', '10': 'result'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.kin.agora.transaction.v4.HistoryItem', '8': const {}, '10': 'items'},
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
final $typed_data.Uint8List getHistoryResponseDescriptor = $convert.base64Decode('ChJHZXRIaXN0b3J5UmVzcG9uc2USSwoGcmVzdWx0GAEgASgOMjMua2luLmFnb3JhLnRyYW5zYWN0aW9uLnY0LkdldEhpc3RvcnlSZXNwb25zZS5SZXN1bHRSBnJlc3VsdBJICgVpdGVtcxgCIAMoCzIlLmtpbi5hZ29yYS50cmFuc2FjdGlvbi52NC5IaXN0b3J5SXRlbUIL+kIIkgEFCAAQgAFSBWl0ZW1zIh8KBlJlc3VsdBIGCgJPSxAAEg0KCU5PVF9GT1VORBAB');
@$core.Deprecated('Use signTransactionRequestDescriptor instead')
const SignTransactionRequest$json = const {
  '1': 'SignTransactionRequest',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.Transaction', '8': const {}, '10': 'transaction'},
    const {'1': 'invoice_list', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v3.InvoiceList', '10': 'invoiceList'},
  ],
};

/// Descriptor for `SignTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signTransactionRequestDescriptor = $convert.base64Decode('ChZTaWduVHJhbnNhY3Rpb25SZXF1ZXN0EkwKC3RyYW5zYWN0aW9uGAEgASgLMiAua2luLmFnb3JhLmNvbW1vbi52NC5UcmFuc2FjdGlvbkII+kIFigECEAFSC3RyYW5zYWN0aW9uEkMKDGludm9pY2VfbGlzdBgCIAEoCzIgLmtpbi5hZ29yYS5jb21tb24udjMuSW52b2ljZUxpc3RSC2ludm9pY2VMaXN0');
@$core.Deprecated('Use signTransactionResponseDescriptor instead')
const SignTransactionResponse$json = const {
  '1': 'SignTransactionResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.transaction.v4.SignTransactionResponse.Result', '10': 'result'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v4.TransactionSignature', '10': 'signature'},
  ],
  '4': const [SignTransactionResponse_Result$json],
};

@$core.Deprecated('Use signTransactionResponseDescriptor instead')
const SignTransactionResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'REJECTED', '2': 3},
    const {'1': 'INVOICE_ERROR', '2': 4},
  ],
};

/// Descriptor for `SignTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signTransactionResponseDescriptor = $convert.base64Decode('ChdTaWduVHJhbnNhY3Rpb25SZXNwb25zZRJQCgZyZXN1bHQYASABKA4yOC5raW4uYWdvcmEudHJhbnNhY3Rpb24udjQuU2lnblRyYW5zYWN0aW9uUmVzcG9uc2UuUmVzdWx0UgZyZXN1bHQSRwoJc2lnbmF0dXJlGAIgASgLMikua2luLmFnb3JhLmNvbW1vbi52NC5UcmFuc2FjdGlvblNpZ25hdHVyZVIJc2lnbmF0dXJlIjEKBlJlc3VsdBIGCgJPSxAAEgwKCFJFSkVDVEVEEAMSEQoNSU5WT0lDRV9FUlJPUhAE');
@$core.Deprecated('Use submitTransactionRequestDescriptor instead')
const SubmitTransactionRequest$json = const {
  '1': 'SubmitTransactionRequest',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.Transaction', '8': const {}, '10': 'transaction'},
    const {'1': 'invoice_list', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v3.InvoiceList', '10': 'invoiceList'},
    const {'1': 'commitment', '3': 3, '4': 1, '5': 14, '6': '.kin.agora.common.v4.Commitment', '10': 'commitment'},
    const {'1': 'dedupe_id', '3': 4, '4': 1, '5': 12, '8': const {}, '10': 'dedupeId'},
  ],
};

/// Descriptor for `SubmitTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitTransactionRequestDescriptor = $convert.base64Decode('ChhTdWJtaXRUcmFuc2FjdGlvblJlcXVlc3QSTAoLdHJhbnNhY3Rpb24YASABKAsyIC5raW4uYWdvcmEuY29tbW9uLnY0LlRyYW5zYWN0aW9uQgj6QgWKAQIQAVILdHJhbnNhY3Rpb24SQwoMaW52b2ljZV9saXN0GAIgASgLMiAua2luLmFnb3JhLmNvbW1vbi52My5JbnZvaWNlTGlzdFILaW52b2ljZUxpc3QSPwoKY29tbWl0bWVudBgDIAEoDjIfLmtpbi5hZ29yYS5jb21tb24udjQuQ29tbWl0bWVudFIKY29tbWl0bWVudBIkCglkZWR1cGVfaWQYBCABKAxCB/pCBHoCGEBSCGRlZHVwZUlk');
@$core.Deprecated('Use submitTransactionResponseDescriptor instead')
const SubmitTransactionResponse$json = const {
  '1': 'SubmitTransactionResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.transaction.v4.SubmitTransactionResponse.Result', '10': 'result'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v4.TransactionSignature', '10': 'signature'},
    const {'1': 'transaction_error', '3': 3, '4': 1, '5': 11, '6': '.kin.agora.common.v4.TransactionError', '10': 'transactionError'},
  ],
  '4': const [SubmitTransactionResponse_Result$json],
};

@$core.Deprecated('Use submitTransactionResponseDescriptor instead')
const SubmitTransactionResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'ALREADY_SUBMITTED', '2': 1},
    const {'1': 'FAILED', '2': 2},
    const {'1': 'REJECTED', '2': 3},
    const {'1': 'INVOICE_ERROR', '2': 4},
    const {'1': 'PAYER_REQUIRED', '2': 5},
  ],
};

/// Descriptor for `SubmitTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitTransactionResponseDescriptor = $convert.base64Decode('ChlTdWJtaXRUcmFuc2FjdGlvblJlc3BvbnNlElIKBnJlc3VsdBgBIAEoDjI6Lmtpbi5hZ29yYS50cmFuc2FjdGlvbi52NC5TdWJtaXRUcmFuc2FjdGlvblJlc3BvbnNlLlJlc3VsdFIGcmVzdWx0EkcKCXNpZ25hdHVyZRgCIAEoCzIpLmtpbi5hZ29yYS5jb21tb24udjQuVHJhbnNhY3Rpb25TaWduYXR1cmVSCXNpZ25hdHVyZRJSChF0cmFuc2FjdGlvbl9lcnJvchgDIAEoCzIlLmtpbi5hZ29yYS5jb21tb24udjQuVHJhbnNhY3Rpb25FcnJvclIQdHJhbnNhY3Rpb25FcnJvciJoCgZSZXN1bHQSBgoCT0sQABIVChFBTFJFQURZX1NVQk1JVFRFRBABEgoKBkZBSUxFRBACEgwKCFJFSkVDVEVEEAMSEQoNSU5WT0lDRV9FUlJPUhAEEhIKDlBBWUVSX1JFUVVJUkVEEAU=');
@$core.Deprecated('Use getTransactionRequestDescriptor instead')
const GetTransactionRequest$json = const {
  '1': 'GetTransactionRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.TransactionId', '8': const {}, '10': 'transactionId'},
    const {'1': 'commitment', '3': 2, '4': 1, '5': 14, '6': '.kin.agora.common.v4.Commitment', '10': 'commitment'},
  ],
};

/// Descriptor for `GetTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionRequestDescriptor = $convert.base64Decode('ChVHZXRUcmFuc2FjdGlvblJlcXVlc3QSUwoOdHJhbnNhY3Rpb25faWQYASABKAsyIi5raW4uYWdvcmEuY29tbW9uLnY0LlRyYW5zYWN0aW9uSWRCCPpCBYoBAhABUg10cmFuc2FjdGlvbklkEj8KCmNvbW1pdG1lbnQYAiABKA4yHy5raW4uYWdvcmEuY29tbW9uLnY0LkNvbW1pdG1lbnRSCmNvbW1pdG1lbnQ=');
@$core.Deprecated('Use getTransactionResponseDescriptor instead')
const GetTransactionResponse$json = const {
  '1': 'GetTransactionResponse',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.transaction.v4.GetTransactionResponse.State', '10': 'state'},
    const {
      '1': 'slot',
      '3': 2,
      '4': 1,
      '5': 4,
      '8': const {'6': 1},
      '10': 'slot',
    },
    const {'1': 'confirmations', '3': 3, '4': 1, '5': 13, '10': 'confirmations'},
    const {'1': 'item', '3': 4, '4': 1, '5': 11, '6': '.kin.agora.transaction.v4.HistoryItem', '10': 'item'},
  ],
  '4': const [GetTransactionResponse_State$json],
};

@$core.Deprecated('Use getTransactionResponseDescriptor instead')
const GetTransactionResponse_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'SUCCESS', '2': 1},
    const {'1': 'FAILED', '2': 2},
    const {'1': 'PENDING', '2': 3},
  ],
};

/// Descriptor for `GetTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionResponseDescriptor = $convert.base64Decode('ChZHZXRUcmFuc2FjdGlvblJlc3BvbnNlEkwKBXN0YXRlGAEgASgOMjYua2luLmFnb3JhLnRyYW5zYWN0aW9uLnY0LkdldFRyYW5zYWN0aW9uUmVzcG9uc2UuU3RhdGVSBXN0YXRlEhYKBHNsb3QYAiABKARCAjABUgRzbG90EiQKDWNvbmZpcm1hdGlvbnMYAyABKA1SDWNvbmZpcm1hdGlvbnMSOQoEaXRlbRgEIAEoCzIlLmtpbi5hZ29yYS50cmFuc2FjdGlvbi52NC5IaXN0b3J5SXRlbVIEaXRlbSI6CgVTdGF0ZRILCgdVTktOT1dOEAASCwoHU1VDQ0VTUxABEgoKBkZBSUxFRBACEgsKB1BFTkRJTkcQAw==');
@$core.Deprecated('Use historyItemDescriptor instead')
const HistoryItem$json = const {
  '1': 'HistoryItem',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.TransactionId', '8': const {}, '10': 'transactionId'},
    const {'1': 'cursor', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.transaction.v4.Cursor', '10': 'cursor'},
    const {'1': 'solana_transaction', '3': 3, '4': 1, '5': 11, '6': '.kin.agora.common.v4.Transaction', '9': 0, '10': 'solanaTransaction'},
    const {'1': 'stellar_transaction', '3': 4, '4': 1, '5': 11, '6': '.kin.agora.common.v4.StellarTransaction', '9': 0, '10': 'stellarTransaction'},
    const {'1': 'transaction_error', '3': 5, '4': 1, '5': 11, '6': '.kin.agora.common.v4.TransactionError', '10': 'transactionError'},
    const {'1': 'payments', '3': 6, '4': 3, '5': 11, '6': '.kin.agora.transaction.v4.HistoryItem.Payment', '10': 'payments'},
    const {'1': 'invoice_list', '3': 7, '4': 1, '5': 11, '6': '.kin.agora.common.v3.InvoiceList', '10': 'invoiceList'},
    const {'1': 'transaction_time', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionTime'},
  ],
  '3': const [HistoryItem_Payment$json],
  '8': const [
    const {'1': 'raw_transaction'},
  ],
};

@$core.Deprecated('Use historyItemDescriptor instead')
const HistoryItem_Payment$json = const {
  '1': 'Payment',
  '2': const [
    const {'1': 'source', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '8': const {}, '10': 'source'},
    const {'1': 'destination', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '8': const {}, '10': 'destination'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'index', '3': 4, '4': 1, '5': 13, '10': 'index'},
  ],
};

/// Descriptor for `HistoryItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyItemDescriptor = $convert.base64Decode('CgtIaXN0b3J5SXRlbRJTCg50cmFuc2FjdGlvbl9pZBgBIAEoCzIiLmtpbi5hZ29yYS5jb21tb24udjQuVHJhbnNhY3Rpb25JZEII+kIFigECEAFSDXRyYW5zYWN0aW9uSWQSOAoGY3Vyc29yGAIgASgLMiAua2luLmFnb3JhLnRyYW5zYWN0aW9uLnY0LkN1cnNvclIGY3Vyc29yElEKEnNvbGFuYV90cmFuc2FjdGlvbhgDIAEoCzIgLmtpbi5hZ29yYS5jb21tb24udjQuVHJhbnNhY3Rpb25IAFIRc29sYW5hVHJhbnNhY3Rpb24SWgoTc3RlbGxhcl90cmFuc2FjdGlvbhgEIAEoCzInLmtpbi5hZ29yYS5jb21tb24udjQuU3RlbGxhclRyYW5zYWN0aW9uSABSEnN0ZWxsYXJUcmFuc2FjdGlvbhJSChF0cmFuc2FjdGlvbl9lcnJvchgFIAEoCzIlLmtpbi5hZ29yYS5jb21tb24udjQuVHJhbnNhY3Rpb25FcnJvclIQdHJhbnNhY3Rpb25FcnJvchJJCghwYXltZW50cxgGIAMoCzItLmtpbi5hZ29yYS50cmFuc2FjdGlvbi52NC5IaXN0b3J5SXRlbS5QYXltZW50UghwYXltZW50cxJDCgxpbnZvaWNlX2xpc3QYByABKAsyIC5raW4uYWdvcmEuY29tbW9uLnYzLkludm9pY2VMaXN0UgtpbnZvaWNlTGlzdBJFChB0cmFuc2FjdGlvbl90aW1lGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIPdHJhbnNhY3Rpb25UaW1lGtEBCgdQYXltZW50EkYKBnNvdXJjZRgBIAEoCzIkLmtpbi5hZ29yYS5jb21tb24udjQuU29sYW5hQWNjb3VudElkQgj6QgWKAQIQAVIGc291cmNlElAKC2Rlc3RpbmF0aW9uGAIgASgLMiQua2luLmFnb3JhLmNvbW1vbi52NC5Tb2xhbmFBY2NvdW50SWRCCPpCBYoBAhABUgtkZXN0aW5hdGlvbhIWCgZhbW91bnQYAyABKANSBmFtb3VudBIUCgVpbmRleBgEIAEoDVIFaW5kZXhCEQoPcmF3X3RyYW5zYWN0aW9u');
@$core.Deprecated('Use cursorDescriptor instead')
const Cursor$json = const {
  '1': 'Cursor',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

/// Descriptor for `Cursor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cursorDescriptor = $convert.base64Decode('CgZDdXJzb3ISIAoFdmFsdWUYASABKAxCCvpCB3oFEAEYgAFSBXZhbHVl');
