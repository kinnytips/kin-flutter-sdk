///
//  Generated code. Do not modify.
//  source: common/v4/model.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Commitment extends $pb.ProtobufEnum {
  static const Commitment RECENT = Commitment._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECENT');
  static const Commitment SINGLE = Commitment._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SINGLE');
  static const Commitment ROOT = Commitment._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROOT');
  static const Commitment MAX = Commitment._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MAX');

  static const $core.List<Commitment> values = <Commitment> [
    RECENT,
    SINGLE,
    ROOT,
    MAX,
  ];

  static final $core.Map<$core.int, Commitment> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Commitment? valueOf($core.int value) => _byValue[value];

  const Commitment._($core.int v, $core.String n) : super(v, n);
}

class TransactionError_Reason extends $pb.ProtobufEnum {
  static const TransactionError_Reason NONE = TransactionError_Reason._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NONE');
  static const TransactionError_Reason UNKNOWN = TransactionError_Reason._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const TransactionError_Reason UNAUTHORIZED = TransactionError_Reason._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNAUTHORIZED');
  static const TransactionError_Reason BAD_NONCE = TransactionError_Reason._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BAD_NONCE');
  static const TransactionError_Reason INSUFFICIENT_FUNDS = TransactionError_Reason._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INSUFFICIENT_FUNDS');
  static const TransactionError_Reason INVALID_ACCOUNT = TransactionError_Reason._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVALID_ACCOUNT');

  static const $core.List<TransactionError_Reason> values = <TransactionError_Reason> [
    NONE,
    UNKNOWN,
    UNAUTHORIZED,
    BAD_NONCE,
    INSUFFICIENT_FUNDS,
    INVALID_ACCOUNT,
  ];

  static final $core.Map<$core.int, TransactionError_Reason> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TransactionError_Reason? valueOf($core.int value) => _byValue[value];

  const TransactionError_Reason._($core.int v, $core.String n) : super(v, n);
}

