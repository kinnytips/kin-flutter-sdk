///
//  Generated code. Do not modify.
//  source: storage.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use privateKeyDescriptor instead')
const PrivateKey$json = const {
  '1': 'PrivateKey',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `PrivateKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List privateKeyDescriptor = $convert.base64Decode('CgpQcml2YXRlS2V5EhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');
@$core.Deprecated('Use publicKeyDescriptor instead')
const PublicKey$json = const {
  '1': 'PublicKey',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `PublicKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeyDescriptor = $convert.base64Decode('CglQdWJsaWNLZXkSFAoFdmFsdWUYASABKAxSBXZhbHVl');
@$core.Deprecated('Use kinBalanceDescriptor instead')
const KinBalance$json = const {
  '1': 'KinBalance',
  '2': const [
    const {'1': 'quark_amount', '3': 1, '4': 1, '5': 3, '10': 'quarkAmount'},
    const {'1': 'pending_quark_amount', '3': 2, '4': 1, '5': 3, '10': 'pendingQuarkAmount'},
  ],
};

/// Descriptor for `KinBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kinBalanceDescriptor = $convert.base64Decode('CgpLaW5CYWxhbmNlEiEKDHF1YXJrX2Ftb3VudBgBIAEoA1ILcXVhcmtBbW91bnQSMAoUcGVuZGluZ19xdWFya19hbW91bnQYAiABKANSEnBlbmRpbmdRdWFya0Ftb3VudA==');
@$core.Deprecated('Use kinAccountDescriptor instead')
const KinAccount$json = const {
  '1': 'KinAccount',
  '2': const [
    const {'1': 'public_key', '3': 1, '4': 1, '5': 11, '6': '.kin.storage.v1.PublicKey', '10': 'publicKey'},
    const {'1': 'private_key', '3': 2, '4': 1, '5': 11, '6': '.kin.storage.v1.PrivateKey', '10': 'privateKey'},
    const {'1': 'balance', '3': 3, '4': 1, '5': 11, '6': '.kin.storage.v1.KinBalance', '10': 'balance'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.kin.storage.v1.KinAccount.Status', '10': 'status'},
    const {'1': 'sequence_number', '3': 5, '4': 1, '5': 3, '10': 'sequenceNumber'},
    const {'1': 'accounts', '3': 6, '4': 3, '5': 11, '6': '.kin.storage.v1.PublicKey', '10': 'accounts'},
  ],
  '4': const [KinAccount_Status$json],
};

@$core.Deprecated('Use kinAccountDescriptor instead')
const KinAccount_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'UNREGISTERED', '2': 0},
    const {'1': 'REGISTERED', '2': 1},
  ],
};

/// Descriptor for `KinAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kinAccountDescriptor = $convert.base64Decode('CgpLaW5BY2NvdW50EjgKCnB1YmxpY19rZXkYASABKAsyGS5raW4uc3RvcmFnZS52MS5QdWJsaWNLZXlSCXB1YmxpY0tleRI7Cgtwcml2YXRlX2tleRgCIAEoCzIaLmtpbi5zdG9yYWdlLnYxLlByaXZhdGVLZXlSCnByaXZhdGVLZXkSNAoHYmFsYW5jZRgDIAEoCzIaLmtpbi5zdG9yYWdlLnYxLktpbkJhbGFuY2VSB2JhbGFuY2USOQoGc3RhdHVzGAQgASgOMiEua2luLnN0b3JhZ2UudjEuS2luQWNjb3VudC5TdGF0dXNSBnN0YXR1cxInCg9zZXF1ZW5jZV9udW1iZXIYBSABKANSDnNlcXVlbmNlTnVtYmVyEjUKCGFjY291bnRzGAYgAygLMhkua2luLnN0b3JhZ2UudjEuUHVibGljS2V5UghhY2NvdW50cyIqCgZTdGF0dXMSEAoMVU5SRUdJU1RFUkVEEAASDgoKUkVHSVNURVJFRBAB');
@$core.Deprecated('Use kinTransactionDescriptor instead')
const KinTransaction$json = const {
  '1': 'KinTransaction',
  '2': const [
    const {'1': 'envelope_xdr', '3': 1, '4': 1, '5': 12, '10': 'envelopeXdr'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.kin.storage.v1.KinTransaction.Status', '10': 'status'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'result_xdr', '3': 4, '4': 1, '5': 12, '10': 'resultXdr'},
    const {'1': 'paging_token', '3': 5, '4': 1, '5': 9, '10': 'pagingToken'},
  ],
  '4': const [KinTransaction_Status$json],
};

@$core.Deprecated('Use kinTransactionDescriptor instead')
const KinTransaction_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'INFLIGHT', '2': 1},
    const {'1': 'ACKNOWLEDGED', '2': 2},
    const {'1': 'HISTORICAL', '2': 3},
  ],
};

/// Descriptor for `KinTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kinTransactionDescriptor = $convert.base64Decode('Cg5LaW5UcmFuc2FjdGlvbhIhCgxlbnZlbG9wZV94ZHIYASABKAxSC2VudmVsb3BlWGRyEj0KBnN0YXR1cxgCIAEoDjIlLmtpbi5zdG9yYWdlLnYxLktpblRyYW5zYWN0aW9uLlN0YXR1c1IGc3RhdHVzEhwKCXRpbWVzdGFtcBgDIAEoA1IJdGltZXN0YW1wEh0KCnJlc3VsdF94ZHIYBCABKAxSCXJlc3VsdFhkchIhCgxwYWdpbmdfdG9rZW4YBSABKAlSC3BhZ2luZ1Rva2VuIkUKBlN0YXR1cxILCgdVTktOT1dOEAASDAoISU5GTElHSFQQARIQCgxBQ0tOT1dMRURHRUQQAhIOCgpISVNUT1JJQ0FMEAM=');
@$core.Deprecated('Use kinTransactionsDescriptor instead')
const KinTransactions$json = const {
  '1': 'KinTransactions',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.kin.storage.v1.KinTransaction', '10': 'items'},
    const {'1': 'head_paging_token', '3': 2, '4': 1, '5': 9, '10': 'headPagingToken'},
    const {'1': 'tail_paging_token', '3': 3, '4': 1, '5': 9, '10': 'tailPagingToken'},
  ],
};

/// Descriptor for `KinTransactions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kinTransactionsDescriptor = $convert.base64Decode('Cg9LaW5UcmFuc2FjdGlvbnMSNAoFaXRlbXMYASADKAsyHi5raW4uc3RvcmFnZS52MS5LaW5UcmFuc2FjdGlvblIFaXRlbXMSKgoRaGVhZF9wYWdpbmdfdG9rZW4YAiABKAlSD2hlYWRQYWdpbmdUb2tlbhIqChF0YWlsX3BhZ2luZ190b2tlbhgDIAEoCVIPdGFpbFBhZ2luZ1Rva2Vu');
@$core.Deprecated('Use invoiceListBlobDescriptor instead')
const InvoiceListBlob$json = const {
  '1': 'InvoiceListBlob',
  '2': const [
    const {'1': 'networkInvoiceList', '3': 1, '4': 1, '5': 12, '10': 'networkInvoiceList'},
  ],
};

/// Descriptor for `InvoiceListBlob`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceListBlobDescriptor = $convert.base64Decode('Cg9JbnZvaWNlTGlzdEJsb2ISLgoSbmV0d29ya0ludm9pY2VMaXN0GAEgASgMUhJuZXR3b3JrSW52b2ljZUxpc3Q=');
@$core.Deprecated('Use invoicesDescriptor instead')
const Invoices$json = const {
  '1': 'Invoices',
  '2': const [
    const {'1': 'invoiceLists', '3': 1, '4': 3, '5': 11, '6': '.kin.storage.v1.Invoices.InvoiceListsEntry', '10': 'invoiceLists'},
  ],
  '3': const [Invoices_InvoiceListsEntry$json],
};

@$core.Deprecated('Use invoicesDescriptor instead')
const Invoices_InvoiceListsEntry$json = const {
  '1': 'InvoiceListsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.kin.storage.v1.InvoiceListBlob', '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Invoices`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoicesDescriptor = $convert.base64Decode('CghJbnZvaWNlcxJOCgxpbnZvaWNlTGlzdHMYASADKAsyKi5raW4uc3RvcmFnZS52MS5JbnZvaWNlcy5JbnZvaWNlTGlzdHNFbnRyeVIMaW52b2ljZUxpc3RzGmAKEUludm9pY2VMaXN0c0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EjUKBXZhbHVlGAIgASgLMh8ua2luLnN0b3JhZ2UudjEuSW52b2ljZUxpc3RCbG9iUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use kinConfigDescriptor instead')
const KinConfig$json = const {
  '1': 'KinConfig',
  '2': const [
    const {'1': 'min_fee', '3': 1, '4': 1, '5': 3, '10': 'minFee'},
    const {'1': 'cid', '3': 2, '4': 1, '5': 9, '10': 'cid'},
    const {'1': 'minApiVersion', '3': 3, '4': 1, '5': 3, '10': 'minApiVersion'},
  ],
};

/// Descriptor for `KinConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kinConfigDescriptor = $convert.base64Decode('CglLaW5Db25maWcSFwoHbWluX2ZlZRgBIAEoA1IGbWluRmVlEhAKA2NpZBgCIAEoCVIDY2lkEiQKDW1pbkFwaVZlcnNpb24YAyABKANSDW1pbkFwaVZlcnNpb24=');
