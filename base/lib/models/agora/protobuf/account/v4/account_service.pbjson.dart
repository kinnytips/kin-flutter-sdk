///
//  Generated code. Do not modify.
//  source: account/v4/account_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use accountInfoDescriptor instead')
const AccountInfo$json = const {
  '1': 'AccountInfo',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '8': const {}, '10': 'accountId'},
    const {
      '1': 'balance',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'balance',
    },
    const {'1': 'owner', '3': 3, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '10': 'owner'},
    const {'1': 'close_authority', '3': 4, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '10': 'closeAuthority'},
  ],
};

/// Descriptor for `AccountInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountInfoDescriptor = $convert.base64Decode('CgtBY2NvdW50SW5mbxJNCgphY2NvdW50X2lkGAEgASgLMiQua2luLmFnb3JhLmNvbW1vbi52NC5Tb2xhbmFBY2NvdW50SWRCCPpCBYoBAhABUglhY2NvdW50SWQSHAoHYmFsYW5jZRgCIAEoA0ICMAFSB2JhbGFuY2USOgoFb3duZXIYAyABKAsyJC5raW4uYWdvcmEuY29tbW9uLnY0LlNvbGFuYUFjY291bnRJZFIFb3duZXISTQoPY2xvc2VfYXV0aG9yaXR5GAQgASgLMiQua2luLmFnb3JhLmNvbW1vbi52NC5Tb2xhbmFBY2NvdW50SWRSDmNsb3NlQXV0aG9yaXR5');
@$core.Deprecated('Use createAccountRequestDescriptor instead')
const CreateAccountRequest$json = const {
  '1': 'CreateAccountRequest',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.Transaction', '8': const {}, '10': 'transaction'},
    const {'1': 'commitment', '3': 2, '4': 1, '5': 14, '6': '.kin.agora.common.v4.Commitment', '10': 'commitment'},
  ],
};

/// Descriptor for `CreateAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVBY2NvdW50UmVxdWVzdBJMCgt0cmFuc2FjdGlvbhgBIAEoCzIgLmtpbi5hZ29yYS5jb21tb24udjQuVHJhbnNhY3Rpb25CCPpCBYoBAhABUgt0cmFuc2FjdGlvbhI/Cgpjb21taXRtZW50GAIgASgOMh8ua2luLmFnb3JhLmNvbW1vbi52NC5Db21taXRtZW50Ugpjb21taXRtZW50');
@$core.Deprecated('Use createAccountResponseDescriptor instead')
const CreateAccountResponse$json = const {
  '1': 'CreateAccountResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.account.v4.CreateAccountResponse.Result', '10': 'result'},
    const {'1': 'account_info', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.account.v4.AccountInfo', '10': 'accountInfo'},
  ],
  '4': const [CreateAccountResponse_Result$json],
};

@$core.Deprecated('Use createAccountResponseDescriptor instead')
const CreateAccountResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'EXISTS', '2': 1},
    const {'1': 'PAYER_REQUIRED', '2': 2},
    const {'1': 'BAD_NONCE', '2': 3},
  ],
};

/// Descriptor for `CreateAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVBY2NvdW50UmVzcG9uc2USSgoGcmVzdWx0GAEgASgOMjIua2luLmFnb3JhLmFjY291bnQudjQuQ3JlYXRlQWNjb3VudFJlc3BvbnNlLlJlc3VsdFIGcmVzdWx0EkQKDGFjY291bnRfaW5mbxgCIAEoCzIhLmtpbi5hZ29yYS5hY2NvdW50LnY0LkFjY291bnRJbmZvUgthY2NvdW50SW5mbyI/CgZSZXN1bHQSBgoCT0sQABIKCgZFWElTVFMQARISCg5QQVlFUl9SRVFVSVJFRBACEg0KCUJBRF9OT05DRRAD');
@$core.Deprecated('Use getAccountInfoRequestDescriptor instead')
const GetAccountInfoRequest$json = const {
  '1': 'GetAccountInfoRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '8': const {}, '10': 'accountId'},
    const {'1': 'commitment', '3': 2, '4': 1, '5': 14, '6': '.kin.agora.common.v4.Commitment', '10': 'commitment'},
  ],
};

/// Descriptor for `GetAccountInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountInfoRequestDescriptor = $convert.base64Decode('ChVHZXRBY2NvdW50SW5mb1JlcXVlc3QSTQoKYWNjb3VudF9pZBgBIAEoCzIkLmtpbi5hZ29yYS5jb21tb24udjQuU29sYW5hQWNjb3VudElkQgj6QgWKAQIQAVIJYWNjb3VudElkEj8KCmNvbW1pdG1lbnQYAiABKA4yHy5raW4uYWdvcmEuY29tbW9uLnY0LkNvbW1pdG1lbnRSCmNvbW1pdG1lbnQ=');
@$core.Deprecated('Use getAccountInfoResponseDescriptor instead')
const GetAccountInfoResponse$json = const {
  '1': 'GetAccountInfoResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.account.v4.GetAccountInfoResponse.Result', '10': 'result'},
    const {'1': 'account_info', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.account.v4.AccountInfo', '10': 'accountInfo'},
  ],
  '4': const [GetAccountInfoResponse_Result$json],
};

@$core.Deprecated('Use getAccountInfoResponseDescriptor instead')
const GetAccountInfoResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'NOT_FOUND', '2': 1},
  ],
};

/// Descriptor for `GetAccountInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountInfoResponseDescriptor = $convert.base64Decode('ChZHZXRBY2NvdW50SW5mb1Jlc3BvbnNlEksKBnJlc3VsdBgBIAEoDjIzLmtpbi5hZ29yYS5hY2NvdW50LnY0LkdldEFjY291bnRJbmZvUmVzcG9uc2UuUmVzdWx0UgZyZXN1bHQSRAoMYWNjb3VudF9pbmZvGAIgASgLMiEua2luLmFnb3JhLmFjY291bnQudjQuQWNjb3VudEluZm9SC2FjY291bnRJbmZvIh8KBlJlc3VsdBIGCgJPSxAAEg0KCU5PVF9GT1VORBAB');
@$core.Deprecated('Use resolveTokenAccountsRequestDescriptor instead')
const ResolveTokenAccountsRequest$json = const {
  '1': 'ResolveTokenAccountsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '8': const {}, '10': 'accountId'},
    const {'1': 'include_account_info', '3': 2, '4': 1, '5': 8, '10': 'includeAccountInfo'},
  ],
};

/// Descriptor for `ResolveTokenAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveTokenAccountsRequestDescriptor = $convert.base64Decode('ChtSZXNvbHZlVG9rZW5BY2NvdW50c1JlcXVlc3QSTQoKYWNjb3VudF9pZBgBIAEoCzIkLmtpbi5hZ29yYS5jb21tb24udjQuU29sYW5hQWNjb3VudElkQgj6QgWKAQIQAVIJYWNjb3VudElkEjAKFGluY2x1ZGVfYWNjb3VudF9pbmZvGAIgASgIUhJpbmNsdWRlQWNjb3VudEluZm8=');
@$core.Deprecated('Use resolveTokenAccountsResponseDescriptor instead')
const ResolveTokenAccountsResponse$json = const {
  '1': 'ResolveTokenAccountsResponse',
  '2': const [
    const {
      '1': 'token_accounts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.kin.agora.common.v4.SolanaAccountId',
      '8': const {'3': true},
      '10': 'tokenAccounts',
    },
    const {'1': 'token_account_infos', '3': 2, '4': 3, '5': 11, '6': '.kin.agora.account.v4.AccountInfo', '10': 'tokenAccountInfos'},
  ],
};

/// Descriptor for `ResolveTokenAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveTokenAccountsResponseDescriptor = $convert.base64Decode('ChxSZXNvbHZlVG9rZW5BY2NvdW50c1Jlc3BvbnNlEk8KDnRva2VuX2FjY291bnRzGAEgAygLMiQua2luLmFnb3JhLmNvbW1vbi52NC5Tb2xhbmFBY2NvdW50SWRCAhgBUg10b2tlbkFjY291bnRzElEKE3Rva2VuX2FjY291bnRfaW5mb3MYAiADKAsyIS5raW4uYWdvcmEuYWNjb3VudC52NC5BY2NvdW50SW5mb1IRdG9rZW5BY2NvdW50SW5mb3M=');
@$core.Deprecated('Use getEventsRequestDescriptor instead')
const GetEventsRequest$json = const {
  '1': 'GetEventsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.SolanaAccountId', '8': const {}, '10': 'accountId'},
  ],
};

/// Descriptor for `GetEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEventsRequestDescriptor = $convert.base64Decode('ChBHZXRFdmVudHNSZXF1ZXN0Ek0KCmFjY291bnRfaWQYASABKAsyJC5raW4uYWdvcmEuY29tbW9uLnY0LlNvbGFuYUFjY291bnRJZEII+kIFigECEAFSCWFjY291bnRJZA==');
@$core.Deprecated('Use eventsDescriptor instead')
const Events$json = const {
  '1': 'Events',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.account.v4.Events.Result', '10': 'result'},
    const {'1': 'events', '3': 2, '4': 3, '5': 11, '6': '.kin.agora.account.v4.Event', '8': const {}, '10': 'events'},
  ],
  '4': const [Events_Result$json],
};

@$core.Deprecated('Use eventsDescriptor instead')
const Events_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'NOT_FOUND', '2': 1},
  ],
};

/// Descriptor for `Events`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventsDescriptor = $convert.base64Decode('CgZFdmVudHMSOwoGcmVzdWx0GAEgASgOMiMua2luLmFnb3JhLmFjY291bnQudjQuRXZlbnRzLlJlc3VsdFIGcmVzdWx0Ej4KBmV2ZW50cxgCIAMoCzIbLmtpbi5hZ29yYS5hY2NvdW50LnY0LkV2ZW50Qgn6QgaSAQMQgAFSBmV2ZW50cyIfCgZSZXN1bHQSBgoCT0sQABINCglOT1RfRk9VTkQQAQ==');
@$core.Deprecated('Use eventDescriptor instead')
const Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'account_update_event', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.account.v4.AccountUpdateEvent', '9': 0, '10': 'accountUpdateEvent'},
    const {'1': 'transaction_event', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.account.v4.TransactionEvent', '9': 0, '10': 'transactionEvent'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode('CgVFdmVudBJcChRhY2NvdW50X3VwZGF0ZV9ldmVudBgBIAEoCzIoLmtpbi5hZ29yYS5hY2NvdW50LnY0LkFjY291bnRVcGRhdGVFdmVudEgAUhJhY2NvdW50VXBkYXRlRXZlbnQSVQoRdHJhbnNhY3Rpb25fZXZlbnQYAiABKAsyJi5raW4uYWdvcmEuYWNjb3VudC52NC5UcmFuc2FjdGlvbkV2ZW50SABSEHRyYW5zYWN0aW9uRXZlbnRCBgoEdHlwZQ==');
@$core.Deprecated('Use accountUpdateEventDescriptor instead')
const AccountUpdateEvent$json = const {
  '1': 'AccountUpdateEvent',
  '2': const [
    const {'1': 'account_info', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.account.v4.AccountInfo', '8': const {}, '10': 'accountInfo'},
  ],
};

/// Descriptor for `AccountUpdateEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountUpdateEventDescriptor = $convert.base64Decode('ChJBY2NvdW50VXBkYXRlRXZlbnQSTgoMYWNjb3VudF9pbmZvGAEgASgLMiEua2luLmFnb3JhLmFjY291bnQudjQuQWNjb3VudEluZm9CCPpCBYoBAhABUgthY2NvdW50SW5mbw==');
@$core.Deprecated('Use transactionEventDescriptor instead')
const TransactionEvent$json = const {
  '1': 'TransactionEvent',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v4.Transaction', '8': const {}, '10': 'transaction'},
    const {'1': 'transaction_error', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v4.TransactionError', '10': 'transactionError'},
  ],
};

/// Descriptor for `TransactionEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionEventDescriptor = $convert.base64Decode('ChBUcmFuc2FjdGlvbkV2ZW50EkwKC3RyYW5zYWN0aW9uGAEgASgLMiAua2luLmFnb3JhLmNvbW1vbi52NC5UcmFuc2FjdGlvbkII+kIFigECEAFSC3RyYW5zYWN0aW9uElIKEXRyYW5zYWN0aW9uX2Vycm9yGAIgASgLMiUua2luLmFnb3JhLmNvbW1vbi52NC5UcmFuc2FjdGlvbkVycm9yUhB0cmFuc2FjdGlvbkVycm9y');
