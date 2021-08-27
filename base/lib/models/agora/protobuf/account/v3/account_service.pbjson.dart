///
//  Generated code. Do not modify.
//  source: account/v3/account_service.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use accountInfoDescriptor instead')
const AccountInfo$json = const {
  '1': 'AccountInfo',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.StellarAccountId', '8': const {}, '10': 'accountId'},
    const {
      '1': 'sequence_number',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'sequenceNumber',
    },
    const {
      '1': 'balance',
      '3': 3,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'balance',
    },
  ],
};

/// Descriptor for `AccountInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountInfoDescriptor = $convert.base64Decode('CgtBY2NvdW50SW5mbxJOCgphY2NvdW50X2lkGAEgASgLMiUua2luLmFnb3JhLmNvbW1vbi52My5TdGVsbGFyQWNjb3VudElkQgj6QgWKAQIQAVIJYWNjb3VudElkEisKD3NlcXVlbmNlX251bWJlchgCIAEoA0ICMAFSDnNlcXVlbmNlTnVtYmVyEhwKB2JhbGFuY2UYAyABKANCAjABUgdiYWxhbmNl');
@$core.Deprecated('Use createAccountRequestDescriptor instead')
const CreateAccountRequest$json = const {
  '1': 'CreateAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.StellarAccountId', '8': const {}, '10': 'accountId'},
  ],
};

/// Descriptor for `CreateAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVBY2NvdW50UmVxdWVzdBJOCgphY2NvdW50X2lkGAEgASgLMiUua2luLmFnb3JhLmNvbW1vbi52My5TdGVsbGFyQWNjb3VudElkQgj6QgWKAQIQAVIJYWNjb3VudElk');
@$core.Deprecated('Use createAccountResponseDescriptor instead')
const CreateAccountResponse$json = const {
  '1': 'CreateAccountResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.account.v3.CreateAccountResponse.Result', '10': 'result'},
    const {'1': 'account_info', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.account.v3.AccountInfo', '10': 'accountInfo'},
  ],
  '4': const [CreateAccountResponse_Result$json],
};

@$core.Deprecated('Use createAccountResponseDescriptor instead')
const CreateAccountResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'EXISTS', '2': 1},
  ],
};

/// Descriptor for `CreateAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVBY2NvdW50UmVzcG9uc2USSgoGcmVzdWx0GAEgASgOMjIua2luLmFnb3JhLmFjY291bnQudjMuQ3JlYXRlQWNjb3VudFJlc3BvbnNlLlJlc3VsdFIGcmVzdWx0EkQKDGFjY291bnRfaW5mbxgCIAEoCzIhLmtpbi5hZ29yYS5hY2NvdW50LnYzLkFjY291bnRJbmZvUgthY2NvdW50SW5mbyIcCgZSZXN1bHQSBgoCT0sQABIKCgZFWElTVFMQAQ==');
@$core.Deprecated('Use getAccountInfoRequestDescriptor instead')
const GetAccountInfoRequest$json = const {
  '1': 'GetAccountInfoRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.StellarAccountId', '8': const {}, '10': 'accountId'},
  ],
};

/// Descriptor for `GetAccountInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountInfoRequestDescriptor = $convert.base64Decode('ChVHZXRBY2NvdW50SW5mb1JlcXVlc3QSTgoKYWNjb3VudF9pZBgBIAEoCzIlLmtpbi5hZ29yYS5jb21tb24udjMuU3RlbGxhckFjY291bnRJZEII+kIFigECEAFSCWFjY291bnRJZA==');
@$core.Deprecated('Use getAccountInfoResponseDescriptor instead')
const GetAccountInfoResponse$json = const {
  '1': 'GetAccountInfoResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.account.v3.GetAccountInfoResponse.Result', '10': 'result'},
    const {'1': 'account_info', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.account.v3.AccountInfo', '10': 'accountInfo'},
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
final $typed_data.Uint8List getAccountInfoResponseDescriptor = $convert.base64Decode('ChZHZXRBY2NvdW50SW5mb1Jlc3BvbnNlEksKBnJlc3VsdBgBIAEoDjIzLmtpbi5hZ29yYS5hY2NvdW50LnYzLkdldEFjY291bnRJbmZvUmVzcG9uc2UuUmVzdWx0UgZyZXN1bHQSRAoMYWNjb3VudF9pbmZvGAIgASgLMiEua2luLmFnb3JhLmFjY291bnQudjMuQWNjb3VudEluZm9SC2FjY291bnRJbmZvIh8KBlJlc3VsdBIGCgJPSxAAEg0KCU5PVF9GT1VORBAB');
@$core.Deprecated('Use getEventsRequestDescriptor instead')
const GetEventsRequest$json = const {
  '1': 'GetEventsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.StellarAccountId', '8': const {}, '10': 'accountId'},
  ],
};

/// Descriptor for `GetEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEventsRequestDescriptor = $convert.base64Decode('ChBHZXRFdmVudHNSZXF1ZXN0Ek4KCmFjY291bnRfaWQYASABKAsyJS5raW4uYWdvcmEuY29tbW9uLnYzLlN0ZWxsYXJBY2NvdW50SWRCCPpCBYoBAhABUglhY2NvdW50SWQ=');
@$core.Deprecated('Use eventsDescriptor instead')
const Events$json = const {
  '1': 'Events',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.account.v3.Events.Result', '10': 'result'},
    const {'1': 'events', '3': 2, '4': 3, '5': 11, '6': '.kin.agora.account.v3.Event', '8': const {}, '10': 'events'},
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
final $typed_data.Uint8List eventsDescriptor = $convert.base64Decode('CgZFdmVudHMSOwoGcmVzdWx0GAEgASgOMiMua2luLmFnb3JhLmFjY291bnQudjMuRXZlbnRzLlJlc3VsdFIGcmVzdWx0Ej4KBmV2ZW50cxgCIAMoCzIbLmtpbi5hZ29yYS5hY2NvdW50LnYzLkV2ZW50Qgn6QgaSAQMQgAFSBmV2ZW50cyIfCgZSZXN1bHQSBgoCT0sQABINCglOT1RfRk9VTkQQAQ==');
@$core.Deprecated('Use eventDescriptor instead')
const Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'account_update_event', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.account.v3.AccountUpdateEvent', '9': 0, '10': 'accountUpdateEvent'},
    const {'1': 'transaction_event', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.account.v3.TransactionEvent', '9': 0, '10': 'transactionEvent'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode('CgVFdmVudBJcChRhY2NvdW50X3VwZGF0ZV9ldmVudBgBIAEoCzIoLmtpbi5hZ29yYS5hY2NvdW50LnYzLkFjY291bnRVcGRhdGVFdmVudEgAUhJhY2NvdW50VXBkYXRlRXZlbnQSVQoRdHJhbnNhY3Rpb25fZXZlbnQYAiABKAsyJi5raW4uYWdvcmEuYWNjb3VudC52My5UcmFuc2FjdGlvbkV2ZW50SABSEHRyYW5zYWN0aW9uRXZlbnRCBgoEdHlwZQ==');
@$core.Deprecated('Use accountUpdateEventDescriptor instead')
const AccountUpdateEvent$json = const {
  '1': 'AccountUpdateEvent',
  '2': const [
    const {'1': 'account_info', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.account.v3.AccountInfo', '8': const {}, '10': 'accountInfo'},
  ],
};

/// Descriptor for `AccountUpdateEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountUpdateEventDescriptor = $convert.base64Decode('ChJBY2NvdW50VXBkYXRlRXZlbnQSTgoMYWNjb3VudF9pbmZvGAEgASgLMiEua2luLmFnb3JhLmFjY291bnQudjMuQWNjb3VudEluZm9CCPpCBYoBAhABUgthY2NvdW50SW5mbw==');
@$core.Deprecated('Use transactionEventDescriptor instead')
const TransactionEvent$json = const {
  '1': 'TransactionEvent',
  '2': const [
    const {'1': 'envelope_xdr', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'envelopeXdr'},
    const {'1': 'result_xdr', '3': 2, '4': 1, '5': 12, '8': const {}, '10': 'resultXdr'},
  ],
};

/// Descriptor for `TransactionEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionEventDescriptor = $convert.base64Decode('ChBUcmFuc2FjdGlvbkV2ZW50Ei0KDGVudmVsb3BlX3hkchgBIAEoDEIK+kIHegUQARiAUFILZW52ZWxvcGVYZHISKQoKcmVzdWx0X3hkchgCIAEoDEIK+kIHegUQABiAUFIJcmVzdWx0WGRy');
