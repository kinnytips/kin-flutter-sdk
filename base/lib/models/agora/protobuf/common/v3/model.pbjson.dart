///
//  Generated code. Do not modify.
//  source: common/v3/model.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use stellarAccountIdDescriptor instead')
const StellarAccountId$json = const {
  '1': 'StellarAccountId',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'value'},
  ],
};

/// Descriptor for `StellarAccountId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stellarAccountIdDescriptor = $convert.base64Decode('ChBTdGVsbGFyQWNjb3VudElkEjAKBXZhbHVlGAEgASgJQhr6QhdyFSA4KDgyD15HW2EtekEtWjAtOV0qJFIFdmFsdWU=');
@$core.Deprecated('Use transactionHashDescriptor instead')
const TransactionHash$json = const {
  '1': 'TransactionHash',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

/// Descriptor for `TransactionHash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionHashDescriptor = $convert.base64Decode('Cg9UcmFuc2FjdGlvbkhhc2gSHwoFdmFsdWUYASABKAxCCfpCBnoEECAYIFIFdmFsdWU=');
@$core.Deprecated('Use invoiceHashDescriptor instead')
const InvoiceHash$json = const {
  '1': 'InvoiceHash',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

/// Descriptor for `InvoiceHash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceHashDescriptor = $convert.base64Decode('CgtJbnZvaWNlSGFzaBIfCgV2YWx1ZRgBIAEoDEIJ+kIGegQQHBgcUgV2YWx1ZQ==');
@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice$json = const {
  '1': 'Invoice',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.kin.agora.common.v3.Invoice.LineItem', '8': const {}, '10': 'items'},
  ],
  '3': const [Invoice_LineItem$json],
};

@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice_LineItem$json = const {
  '1': 'LineItem',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'title'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'description'},
    const {
      '1': 'amount',
      '3': 3,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'amount',
    },
    const {'1': 'sku', '3': 4, '4': 1, '5': 12, '8': const {}, '10': 'sku'},
  ],
};

/// Descriptor for `Invoice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceDescriptor = $convert.base64Decode('CgdJbnZvaWNlEkgKBWl0ZW1zGAEgAygLMiUua2luLmFnb3JhLmNvbW1vbi52My5JbnZvaWNlLkxpbmVJdGVtQgv6QgiSAQUIARCACFIFaXRlbXMakgEKCExpbmVJdGVtEiAKBXRpdGxlGAEgASgJQgr6QgdyBRABGIABUgV0aXRsZRIsCgtkZXNjcmlwdGlvbhgCIAEoCUIK+kIHcgUQABiAAlILZGVzY3JpcHRpb24SGgoGYW1vdW50GAMgASgDQgIwAVIGYW1vdW50EhoKA3NrdRgEIAEoDEII+kIFegMYgAFSA3NrdQ==');
@$core.Deprecated('Use invoiceListDescriptor instead')
const InvoiceList$json = const {
  '1': 'InvoiceList',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.kin.agora.common.v3.Invoice', '8': const {}, '10': 'invoices'},
  ],
};

/// Descriptor for `InvoiceList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceListDescriptor = $convert.base64Decode('CgtJbnZvaWNlTGlzdBJECghpbnZvaWNlcxgBIAMoCzIcLmtpbi5hZ29yYS5jb21tb24udjMuSW52b2ljZUIK+kIHkgEECAEQZFIIaW52b2ljZXM=');
