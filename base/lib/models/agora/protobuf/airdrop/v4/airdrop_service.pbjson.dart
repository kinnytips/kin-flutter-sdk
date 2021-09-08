///
//  Generated code. Do not modify.
//  source: airdrop/v4/airdrop_service.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use requestAirdropRequestDescriptor instead')
const RequestAirdropRequest$json = const {
  '1': 'RequestAirdropRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '8': const {}, '10': 'accountId'},
    const {'1': 'quarks', '3': 2, '4': 1, '5': 4, '8': const {}, '10': 'quarks'},
    const {'1': 'commitment', '3': 3, '4': 1, '5': 14, '6': '.kin.agora.common.v4.Commitment', '10': 'commitment'},
  ],
};

/// Descriptor for `RequestAirdropRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAirdropRequestDescriptor = $convert.base64Decode('ChVSZXF1ZXN0QWlyZHJvcFJlcXVlc3QSTQoKYWNjb3VudF9pZBgBIAEoCzIkLmtpbi5hZ29yYS5jb21tb24udjQuU29sYW5hQWNjb3VudElkQgj6QgWKAQIQAVIJYWNjb3VudElkEh8KBnF1YXJrcxgCIAEoBEIH+kIEMgIgAVIGcXVhcmtzEj8KCmNvbW1pdG1lbnQYAyABKA4yHy5raW4uYWdvcmEuY29tbW9uLnY0LkNvbW1pdG1lbnRSCmNvbW1pdG1lbnQ=');
@$core.Deprecated('Use requestAirdropResponseDescriptor instead')
const RequestAirdropResponse$json = const {
  '1': 'RequestAirdropResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.airdrop.v4.RequestAirdropResponse.Result', '10': 'result'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v4.TransactionSignature', '10': 'signature'},
  ],
  '4': const [RequestAirdropResponse_Result$json],
};

@$core.Deprecated('Use requestAirdropResponseDescriptor instead')
const RequestAirdropResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'NOT_FOUND', '2': 1},
    const {'1': 'INSUFFICIENT_KIN', '2': 2},
  ],
};

/// Descriptor for `RequestAirdropResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAirdropResponseDescriptor = $convert.base64Decode('ChZSZXF1ZXN0QWlyZHJvcFJlc3BvbnNlEksKBnJlc3VsdBgBIAEoDjIzLmtpbi5hZ29yYS5haXJkcm9wLnY0LlJlcXVlc3RBaXJkcm9wUmVzcG9uc2UuUmVzdWx0UgZyZXN1bHQSRwoJc2lnbmF0dXJlGAIgASgLMikua2luLmFnb3JhLmNvbW1vbi52NC5UcmFuc2FjdGlvblNpZ25hdHVyZVIJc2lnbmF0dXJlIjUKBlJlc3VsdBIGCgJPSxAAEg0KCU5PVF9GT1VORBABEhQKEElOU1VGRklDSUVOVF9LSU4QAg==');
