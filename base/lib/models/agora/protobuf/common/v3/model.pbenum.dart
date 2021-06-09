///
//  Generated code. Do not modify.
//  source: common/v3/model.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class InvoiceError_Reason extends $pb.ProtobufEnum {
  static const InvoiceError_Reason UNKNOWN = InvoiceError_Reason._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const InvoiceError_Reason ALREADY_PAID = InvoiceError_Reason._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ALREADY_PAID');
  static const InvoiceError_Reason WRONG_DESTINATION = InvoiceError_Reason._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WRONG_DESTINATION');
  static const InvoiceError_Reason SKU_NOT_FOUND = InvoiceError_Reason._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SKU_NOT_FOUND');

  static const $core.List<InvoiceError_Reason> values = <InvoiceError_Reason> [
    UNKNOWN,
    ALREADY_PAID,
    WRONG_DESTINATION,
    SKU_NOT_FOUND,
  ];

  static final $core.Map<$core.int, InvoiceError_Reason> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InvoiceError_Reason valueOf($core.int value) => _byValue[value];

  const InvoiceError_Reason._($core.int v, $core.String n) : super(v, n);
}

