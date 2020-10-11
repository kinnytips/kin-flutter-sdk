///
//  Generated code. Do not modify.
//  source: validate/validate.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const KnownRegex$json = const {
  '1': 'KnownRegex',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'HTTP_HEADER_NAME', '2': 1},
    const {'1': 'HTTP_HEADER_VALUE', '2': 2},
  ],
};

const FieldRules$json = const {
  '1': 'FieldRules',
  '2': const [
    const {'1': 'message', '3': 17, '4': 1, '5': 11, '6': '.validate.MessageRules', '10': 'message'},
    const {'1': 'float', '3': 1, '4': 1, '5': 11, '6': '.validate.FloatRules', '9': 0, '10': 'float'},
    const {'1': 'double', '3': 2, '4': 1, '5': 11, '6': '.validate.DoubleRules', '9': 0, '10': 'double'},
    const {'1': 'int32', '3': 3, '4': 1, '5': 11, '6': '.validate.Int32Rules', '9': 0, '10': 'int32'},
    const {'1': 'int64', '3': 4, '4': 1, '5': 11, '6': '.validate.Int64Rules', '9': 0, '10': 'int64'},
    const {'1': 'uint32', '3': 5, '4': 1, '5': 11, '6': '.validate.UInt32Rules', '9': 0, '10': 'uint32'},
    const {'1': 'uint64', '3': 6, '4': 1, '5': 11, '6': '.validate.UInt64Rules', '9': 0, '10': 'uint64'},
    const {'1': 'sint32', '3': 7, '4': 1, '5': 11, '6': '.validate.SInt32Rules', '9': 0, '10': 'sint32'},
    const {'1': 'sint64', '3': 8, '4': 1, '5': 11, '6': '.validate.SInt64Rules', '9': 0, '10': 'sint64'},
    const {'1': 'fixed32', '3': 9, '4': 1, '5': 11, '6': '.validate.Fixed32Rules', '9': 0, '10': 'fixed32'},
    const {'1': 'fixed64', '3': 10, '4': 1, '5': 11, '6': '.validate.Fixed64Rules', '9': 0, '10': 'fixed64'},
    const {'1': 'sfixed32', '3': 11, '4': 1, '5': 11, '6': '.validate.SFixed32Rules', '9': 0, '10': 'sfixed32'},
    const {'1': 'sfixed64', '3': 12, '4': 1, '5': 11, '6': '.validate.SFixed64Rules', '9': 0, '10': 'sfixed64'},
    const {'1': 'bool', '3': 13, '4': 1, '5': 11, '6': '.validate.BoolRules', '9': 0, '10': 'bool'},
    const {'1': 'string', '3': 14, '4': 1, '5': 11, '6': '.validate.StringRules', '9': 0, '10': 'string'},
    const {'1': 'bytes', '3': 15, '4': 1, '5': 11, '6': '.validate.BytesRules', '9': 0, '10': 'bytes'},
    const {'1': 'enum', '3': 16, '4': 1, '5': 11, '6': '.validate.EnumRules', '9': 0, '10': 'enum'},
    const {'1': 'repeated', '3': 18, '4': 1, '5': 11, '6': '.validate.RepeatedRules', '9': 0, '10': 'repeated'},
    const {'1': 'map', '3': 19, '4': 1, '5': 11, '6': '.validate.MapRules', '9': 0, '10': 'map'},
    const {'1': 'any', '3': 20, '4': 1, '5': 11, '6': '.validate.AnyRules', '9': 0, '10': 'any'},
    const {'1': 'duration', '3': 21, '4': 1, '5': 11, '6': '.validate.DurationRules', '9': 0, '10': 'duration'},
    const {'1': 'timestamp', '3': 22, '4': 1, '5': 11, '6': '.validate.TimestampRules', '9': 0, '10': 'timestamp'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

const FloatRules$json = const {
  '1': 'FloatRules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 2, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 2, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 2, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 2, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 2, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 2, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 2, '10': 'notIn'},
  ],
};

const DoubleRules$json = const {
  '1': 'DoubleRules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 1, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 1, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 1, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 1, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 1, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 1, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 1, '10': 'notIn'},
  ],
};

const Int32Rules$json = const {
  '1': 'Int32Rules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 5, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 5, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 5, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 5, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 5, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 5, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 5, '10': 'notIn'},
  ],
};

const Int64Rules$json = const {
  '1': 'Int64Rules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 3, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 3, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 3, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 3, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 3, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 3, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 3, '10': 'notIn'},
  ],
};

const UInt32Rules$json = const {
  '1': 'UInt32Rules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 13, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 13, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 13, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 13, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 13, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 13, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 13, '10': 'notIn'},
  ],
};

const UInt64Rules$json = const {
  '1': 'UInt64Rules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 4, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 4, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 4, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 4, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 4, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 4, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 4, '10': 'notIn'},
  ],
};

const SInt32Rules$json = const {
  '1': 'SInt32Rules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 17, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 17, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 17, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 17, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 17, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 17, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 17, '10': 'notIn'},
  ],
};

const SInt64Rules$json = const {
  '1': 'SInt64Rules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 18, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 18, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 18, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 18, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 18, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 18, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 18, '10': 'notIn'},
  ],
};

const Fixed32Rules$json = const {
  '1': 'Fixed32Rules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 7, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 7, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 7, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 7, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 7, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 7, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 7, '10': 'notIn'},
  ],
};

const Fixed64Rules$json = const {
  '1': 'Fixed64Rules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 6, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 6, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 6, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 6, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 6, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 6, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 6, '10': 'notIn'},
  ],
};

const SFixed32Rules$json = const {
  '1': 'SFixed32Rules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 15, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 15, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 15, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 15, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 15, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 15, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 15, '10': 'notIn'},
  ],
};

const SFixed64Rules$json = const {
  '1': 'SFixed64Rules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 16, '10': 'const'},
    const {'1': 'lt', '3': 2, '4': 1, '5': 16, '10': 'lt'},
    const {'1': 'lte', '3': 3, '4': 1, '5': 16, '10': 'lte'},
    const {'1': 'gt', '3': 4, '4': 1, '5': 16, '10': 'gt'},
    const {'1': 'gte', '3': 5, '4': 1, '5': 16, '10': 'gte'},
    const {'1': 'in', '3': 6, '4': 3, '5': 16, '10': 'in'},
    const {'1': 'not_in', '3': 7, '4': 3, '5': 16, '10': 'notIn'},
  ],
};

const BoolRules$json = const {
  '1': 'BoolRules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 8, '10': 'const'},
  ],
};

const StringRules$json = const {
  '1': 'StringRules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 9, '10': 'const'},
    const {'1': 'len', '3': 19, '4': 1, '5': 4, '10': 'len'},
    const {'1': 'min_len', '3': 2, '4': 1, '5': 4, '10': 'minLen'},
    const {'1': 'max_len', '3': 3, '4': 1, '5': 4, '10': 'maxLen'},
    const {'1': 'len_bytes', '3': 20, '4': 1, '5': 4, '10': 'lenBytes'},
    const {'1': 'min_bytes', '3': 4, '4': 1, '5': 4, '10': 'minBytes'},
    const {'1': 'max_bytes', '3': 5, '4': 1, '5': 4, '10': 'maxBytes'},
    const {'1': 'pattern', '3': 6, '4': 1, '5': 9, '10': 'pattern'},
    const {'1': 'prefix', '3': 7, '4': 1, '5': 9, '10': 'prefix'},
    const {'1': 'suffix', '3': 8, '4': 1, '5': 9, '10': 'suffix'},
    const {'1': 'contains', '3': 9, '4': 1, '5': 9, '10': 'contains'},
    const {'1': 'not_contains', '3': 23, '4': 1, '5': 9, '10': 'notContains'},
    const {'1': 'in', '3': 10, '4': 3, '5': 9, '10': 'in'},
    const {'1': 'not_in', '3': 11, '4': 3, '5': 9, '10': 'notIn'},
    const {'1': 'email', '3': 12, '4': 1, '5': 8, '9': 0, '10': 'email'},
    const {'1': 'hostname', '3': 13, '4': 1, '5': 8, '9': 0, '10': 'hostname'},
    const {'1': 'ip', '3': 14, '4': 1, '5': 8, '9': 0, '10': 'ip'},
    const {'1': 'ipv4', '3': 15, '4': 1, '5': 8, '9': 0, '10': 'ipv4'},
    const {'1': 'ipv6', '3': 16, '4': 1, '5': 8, '9': 0, '10': 'ipv6'},
    const {'1': 'uri', '3': 17, '4': 1, '5': 8, '9': 0, '10': 'uri'},
    const {'1': 'uri_ref', '3': 18, '4': 1, '5': 8, '9': 0, '10': 'uriRef'},
    const {'1': 'address', '3': 21, '4': 1, '5': 8, '9': 0, '10': 'address'},
    const {'1': 'uuid', '3': 22, '4': 1, '5': 8, '9': 0, '10': 'uuid'},
    const {'1': 'well_known_regex', '3': 24, '4': 1, '5': 14, '6': '.validate.KnownRegex', '9': 0, '10': 'wellKnownRegex'},
    const {'1': 'strict', '3': 25, '4': 1, '5': 8, '7': 'true', '10': 'strict'},
  ],
  '8': const [
    const {'1': 'well_known'},
  ],
};

const BytesRules$json = const {
  '1': 'BytesRules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 12, '10': 'const'},
    const {'1': 'len', '3': 13, '4': 1, '5': 4, '10': 'len'},
    const {'1': 'min_len', '3': 2, '4': 1, '5': 4, '10': 'minLen'},
    const {'1': 'max_len', '3': 3, '4': 1, '5': 4, '10': 'maxLen'},
    const {'1': 'pattern', '3': 4, '4': 1, '5': 9, '10': 'pattern'},
    const {'1': 'prefix', '3': 5, '4': 1, '5': 12, '10': 'prefix'},
    const {'1': 'suffix', '3': 6, '4': 1, '5': 12, '10': 'suffix'},
    const {'1': 'contains', '3': 7, '4': 1, '5': 12, '10': 'contains'},
    const {'1': 'in', '3': 8, '4': 3, '5': 12, '10': 'in'},
    const {'1': 'not_in', '3': 9, '4': 3, '5': 12, '10': 'notIn'},
    const {'1': 'ip', '3': 10, '4': 1, '5': 8, '9': 0, '10': 'ip'},
    const {'1': 'ipv4', '3': 11, '4': 1, '5': 8, '9': 0, '10': 'ipv4'},
    const {'1': 'ipv6', '3': 12, '4': 1, '5': 8, '9': 0, '10': 'ipv6'},
  ],
  '8': const [
    const {'1': 'well_known'},
  ],
};

const EnumRules$json = const {
  '1': 'EnumRules',
  '2': const [
    const {'1': 'const', '3': 1, '4': 1, '5': 5, '10': 'const'},
    const {'1': 'defined_only', '3': 2, '4': 1, '5': 8, '10': 'definedOnly'},
    const {'1': 'in', '3': 3, '4': 3, '5': 5, '10': 'in'},
    const {'1': 'not_in', '3': 4, '4': 3, '5': 5, '10': 'notIn'},
  ],
};

const MessageRules$json = const {
  '1': 'MessageRules',
  '2': const [
    const {'1': 'skip', '3': 1, '4': 1, '5': 8, '10': 'skip'},
    const {'1': 'required', '3': 2, '4': 1, '5': 8, '10': 'required'},
  ],
};

const RepeatedRules$json = const {
  '1': 'RepeatedRules',
  '2': const [
    const {'1': 'min_items', '3': 1, '4': 1, '5': 4, '10': 'minItems'},
    const {'1': 'max_items', '3': 2, '4': 1, '5': 4, '10': 'maxItems'},
    const {'1': 'unique', '3': 3, '4': 1, '5': 8, '10': 'unique'},
    const {'1': 'items', '3': 4, '4': 1, '5': 11, '6': '.validate.FieldRules', '10': 'items'},
  ],
};

const MapRules$json = const {
  '1': 'MapRules',
  '2': const [
    const {'1': 'min_pairs', '3': 1, '4': 1, '5': 4, '10': 'minPairs'},
    const {'1': 'max_pairs', '3': 2, '4': 1, '5': 4, '10': 'maxPairs'},
    const {'1': 'no_sparse', '3': 3, '4': 1, '5': 8, '10': 'noSparse'},
    const {'1': 'keys', '3': 4, '4': 1, '5': 11, '6': '.validate.FieldRules', '10': 'keys'},
    const {'1': 'values', '3': 5, '4': 1, '5': 11, '6': '.validate.FieldRules', '10': 'values'},
  ],
};

const AnyRules$json = const {
  '1': 'AnyRules',
  '2': const [
    const {'1': 'required', '3': 1, '4': 1, '5': 8, '10': 'required'},
    const {'1': 'in', '3': 2, '4': 3, '5': 9, '10': 'in'},
    const {'1': 'not_in', '3': 3, '4': 3, '5': 9, '10': 'notIn'},
  ],
};

const DurationRules$json = const {
  '1': 'DurationRules',
  '2': const [
    const {'1': 'required', '3': 1, '4': 1, '5': 8, '10': 'required'},
    const {'1': 'const', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'const'},
    const {'1': 'lt', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'lt'},
    const {'1': 'lte', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'lte'},
    const {'1': 'gt', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'gt'},
    const {'1': 'gte', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'gte'},
    const {'1': 'in', '3': 7, '4': 3, '5': 11, '6': '.google.protobuf.Duration', '10': 'in'},
    const {'1': 'not_in', '3': 8, '4': 3, '5': 11, '6': '.google.protobuf.Duration', '10': 'notIn'},
  ],
};

const TimestampRules$json = const {
  '1': 'TimestampRules',
  '2': const [
    const {'1': 'required', '3': 1, '4': 1, '5': 8, '10': 'required'},
    const {'1': 'const', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'const'},
    const {'1': 'lt', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lt'},
    const {'1': 'lte', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lte'},
    const {'1': 'gt', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'gt'},
    const {'1': 'gte', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'gte'},
    const {'1': 'lt_now', '3': 7, '4': 1, '5': 8, '10': 'ltNow'},
    const {'1': 'gt_now', '3': 8, '4': 1, '5': 8, '10': 'gtNow'},
    const {'1': 'within', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'within'},
  ],
};

