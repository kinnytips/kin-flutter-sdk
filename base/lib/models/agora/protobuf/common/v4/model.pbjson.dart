///
//  Generated code. Do not modify.
//  source: common/v4/model.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use commitmentDescriptor instead')
const Commitment$json = const {
  '1': 'Commitment',
  '2': const [
    const {'1': 'RECENT', '2': 0},
    const {'1': 'SINGLE', '2': 1},
    const {'1': 'ROOT', '2': 2},
    const {'1': 'MAX', '2': 3},
  ],
};

/// Descriptor for `Commitment`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List commitmentDescriptor = $convert.base64Decode('CgpDb21taXRtZW50EgoKBlJFQ0VOVBAAEgoKBlNJTkdMRRABEggKBFJPT1QQAhIHCgNNQVgQAw==');
@$core.Deprecated('Use solanaAccountIdDescriptor instead')
const SolanaAccountId$json = const {
  '1': 'SolanaAccountId',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

/// Descriptor for `SolanaAccountId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List solanaAccountIdDescriptor = $convert.base64Decode('Cg9Tb2xhbmFBY2NvdW50SWQSHwoFdmFsdWUYASABKAxCCfpCBnoEECAYIFIFdmFsdWU=');
@$core.Deprecated('Use transactionIdDescriptor instead')
const TransactionId$json = const {
  '1': 'TransactionId',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

/// Descriptor for `TransactionId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionIdDescriptor = $convert.base64Decode('Cg1UcmFuc2FjdGlvbklkEh8KBXZhbHVlGAEgASgMQgn6QgZ6BBAgGEBSBXZhbHVl');
@$core.Deprecated('Use blockhashDescriptor instead')
const Blockhash$json = const {
  '1': 'Blockhash',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

/// Descriptor for `Blockhash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockhashDescriptor = $convert.base64Decode('CglCbG9ja2hhc2gSHwoFdmFsdWUYASABKAxCCfpCBnoEECAYIFIFdmFsdWU=');
@$core.Deprecated('Use transactionSignatureDescriptor instead')
const TransactionSignature$json = const {
  '1': 'TransactionSignature',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

/// Descriptor for `TransactionSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionSignatureDescriptor = $convert.base64Decode('ChRUcmFuc2FjdGlvblNpZ25hdHVyZRIfCgV2YWx1ZRgBIAEoDEIJ+kIGegQQQBhAUgV2YWx1ZQ==');
@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = const {
  '1': 'Transaction',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode('CgtUcmFuc2FjdGlvbhIgCgV2YWx1ZRgBIAEoDEIK+kIHegUQARjQCVIFdmFsdWU=');
@$core.Deprecated('Use transactionErrorDescriptor instead')
const TransactionError$json = const {
  '1': 'TransactionError',
  '2': const [
    const {'1': 'reason', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.common.v4.TransactionError.Reason', '10': 'reason'},
    const {'1': 'instruction_index', '3': 2, '4': 1, '5': 5, '10': 'instructionIndex'},
    const {'1': 'raw', '3': 3, '4': 1, '5': 12, '8': const {}, '10': 'raw'},
  ],
  '4': const [TransactionError_Reason$json],
};

@$core.Deprecated('Use transactionErrorDescriptor instead')
const TransactionError_Reason$json = const {
  '1': 'Reason',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'UNKNOWN', '2': 1},
    const {'1': 'UNAUTHORIZED', '2': 2},
    const {'1': 'BAD_NONCE', '2': 3},
    const {'1': 'INSUFFICIENT_FUNDS', '2': 4},
    const {'1': 'INVALID_ACCOUNT', '2': 5},
  ],
};

/// Descriptor for `TransactionError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionErrorDescriptor = $convert.base64Decode('ChBUcmFuc2FjdGlvbkVycm9yEkQKBnJlYXNvbhgBIAEoDjIsLmtpbi5hZ29yYS5jb21tb24udjQuVHJhbnNhY3Rpb25FcnJvci5SZWFzb25SBnJlYXNvbhIrChFpbnN0cnVjdGlvbl9pbmRleBgCIAEoBVIQaW5zdHJ1Y3Rpb25JbmRleBIcCgNyYXcYAyABKAxCCvpCB3oFEAEYgFBSA3JhdyJtCgZSZWFzb24SCAoETk9ORRAAEgsKB1VOS05PV04QARIQCgxVTkFVVEhPUklaRUQQAhINCglCQURfTk9OQ0UQAxIWChJJTlNVRkZJQ0lFTlRfRlVORFMQBBITCg9JTlZBTElEX0FDQ09VTlQQBQ==');
@$core.Deprecated('Use stellarTransactionDescriptor instead')
const StellarTransaction$json = const {
  '1': 'StellarTransaction',
  '2': const [
    const {'1': 'result_xdr', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'resultXdr'},
    const {'1': 'envelope_xdr', '3': 2, '4': 1, '5': 12, '8': const {}, '10': 'envelopeXdr'},
  ],
};

/// Descriptor for `StellarTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stellarTransactionDescriptor = $convert.base64Decode('ChJTdGVsbGFyVHJhbnNhY3Rpb24SKQoKcmVzdWx0X3hkchgBIAEoDEIK+kIHegUQARiAUFIJcmVzdWx0WGRyEi0KDGVudmVsb3BlX3hkchgCIAEoDEIK+kIHegUQARiAUFILZW52ZWxvcGVYZHI=');
