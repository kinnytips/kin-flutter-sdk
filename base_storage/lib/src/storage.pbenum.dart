///
//  Generated code. Do not modify.
//  source: storage.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class KinAccount_Status extends $pb.ProtobufEnum {
  static const KinAccount_Status UNREGISTERED = KinAccount_Status._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'UNREGISTERED');
  static const KinAccount_Status REGISTERED = KinAccount_Status._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'REGISTERED');

  static const $core.List<KinAccount_Status> values = <KinAccount_Status>[
    UNREGISTERED,
    REGISTERED,
  ];

  static final $core.Map<$core.int, KinAccount_Status> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static KinAccount_Status? valueOf($core.int value) => _byValue[value];

  const KinAccount_Status._($core.int v, $core.String n) : super(v, n);
}

class KinTransaction_Status extends $pb.ProtobufEnum {
  static const KinTransaction_Status UNKNOWN = KinTransaction_Status._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'UNKNOWN');
  static const KinTransaction_Status INFLIGHT = KinTransaction_Status._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'INFLIGHT');
  static const KinTransaction_Status ACKNOWLEDGED = KinTransaction_Status._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'ACKNOWLEDGED');
  static const KinTransaction_Status HISTORICAL = KinTransaction_Status._(
      3,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'HISTORICAL');

  static const $core.List<KinTransaction_Status> values =
      <KinTransaction_Status>[
    UNKNOWN,
    INFLIGHT,
    ACKNOWLEDGED,
    HISTORICAL,
  ];

  static final $core.Map<$core.int, KinTransaction_Status> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static KinTransaction_Status? valueOf($core.int value) => _byValue[value];

  const KinTransaction_Status._($core.int v, $core.String n) : super(v, n);
}
