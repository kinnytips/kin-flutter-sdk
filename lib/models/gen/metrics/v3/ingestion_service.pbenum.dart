///
//  Generated code. Do not modify.
//  source: metrics/v3/ingestion_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class SubmitResponse_Result extends $pb.ProtobufEnum {
  static const SubmitResponse_Result OK = SubmitResponse_Result._(0, 'OK');

  static const $core.List<SubmitResponse_Result> values = <SubmitResponse_Result> [
    OK,
  ];

  static final $core.Map<$core.int, SubmitResponse_Result> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SubmitResponse_Result valueOf($core.int value) => _byValue[value];

  const SubmitResponse_Result._($core.int v, $core.String n) : super(v, n);
}

