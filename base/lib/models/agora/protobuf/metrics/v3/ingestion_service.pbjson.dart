///
//  Generated code. Do not modify.
//  source: metrics/v3/ingestion_service.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use submitRequestDescriptor instead')
const SubmitRequest$json = const {
  '1': 'SubmitRequest',
};

/// Descriptor for `SubmitRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitRequestDescriptor = $convert.base64Decode('Cg1TdWJtaXRSZXF1ZXN0');
@$core.Deprecated('Use submitResponseDescriptor instead')
const SubmitResponse$json = const {
  '1': 'SubmitResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.metrics.v3.SubmitResponse.Result', '10': 'result'},
  ],
  '4': const [SubmitResponse_Result$json],
};

@$core.Deprecated('Use submitResponseDescriptor instead')
const SubmitResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
  ],
};

/// Descriptor for `SubmitResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitResponseDescriptor = $convert.base64Decode('Cg5TdWJtaXRSZXNwb25zZRJDCgZyZXN1bHQYASABKA4yKy5raW4uYWdvcmEubWV0cmljcy52My5TdWJtaXRSZXNwb25zZS5SZXN1bHRSBnJlc3VsdCIQCgZSZXN1bHQSBgoCT0sQAA==');
