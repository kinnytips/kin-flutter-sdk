///
//  Generated code. Do not modify.
//  source: validate/validate.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class KnownRegex extends $pb.ProtobufEnum {
  static const KnownRegex UNKNOWN = KnownRegex._(0, 'UNKNOWN');
  static const KnownRegex HTTP_HEADER_NAME = KnownRegex._(1, 'HTTP_HEADER_NAME');
  static const KnownRegex HTTP_HEADER_VALUE = KnownRegex._(2, 'HTTP_HEADER_VALUE');

  static const $core.List<KnownRegex> values = <KnownRegex> [
    UNKNOWN,
    HTTP_HEADER_NAME,
    HTTP_HEADER_VALUE,
  ];

  static final $core.Map<$core.int, KnownRegex> _byValue = $pb.ProtobufEnum.initByValue(values);
  static KnownRegex valueOf($core.int value) => _byValue[value];

  const KnownRegex._($core.int v, $core.String n) : super(v, n);
}

