///
//  Generated code. Do not modify.
//  source: metrics/v3/ingestion_service.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'ingestion_service.pbenum.dart';

export 'ingestion_service.pbenum.dart';

class SubmitRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.metrics.v3'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SubmitRequest._() : super();
  factory SubmitRequest() => create();
  factory SubmitRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitRequest clone() => SubmitRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitRequest copyWith(void Function(SubmitRequest) updates) => super.copyWith((message) => updates(message as SubmitRequest)) as SubmitRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubmitRequest create() => SubmitRequest._();
  SubmitRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitRequest> createRepeated() => $pb.PbList<SubmitRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubmitRequest>(create);
  static SubmitRequest? _defaultInstance;
}

class SubmitResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.metrics.v3'), createEmptyInstance: create)
    ..e<SubmitResponse_Result>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.OE, defaultOrMaker: SubmitResponse_Result.OK, valueOf: SubmitResponse_Result.valueOf, enumValues: SubmitResponse_Result.values)
    ..hasRequiredFields = false
  ;

  SubmitResponse._() : super();
  factory SubmitResponse({
    SubmitResponse_Result? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory SubmitResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitResponse clone() => SubmitResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitResponse copyWith(void Function(SubmitResponse) updates) => super.copyWith((message) => updates(message as SubmitResponse)) as SubmitResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubmitResponse create() => SubmitResponse._();
  SubmitResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitResponse> createRepeated() => $pb.PbList<SubmitResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubmitResponse>(create);
  static SubmitResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SubmitResponse_Result get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(SubmitResponse_Result v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
}

