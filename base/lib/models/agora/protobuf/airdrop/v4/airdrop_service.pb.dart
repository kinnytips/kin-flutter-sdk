///
//  Generated code. Do not modify.
//  source: airdrop/v4/airdrop_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../common/v4/model.pb.dart' as $8;

import '../../common/v4/model.pbenum.dart' as $8;
import 'airdrop_service.pbenum.dart';

export 'airdrop_service.pbenum.dart';

class RequestAirdropRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestAirdropRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.airdrop.v4'), createEmptyInstance: create)
    ..aOM<$8.SolanaAccountId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', subBuilder: $8.SolanaAccountId.create)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quarks', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<$8.Commitment>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commitment', $pb.PbFieldType.OE, defaultOrMaker: $8.Commitment.RECENT, valueOf: $8.Commitment.valueOf, enumValues: $8.Commitment.values)
    ..hasRequiredFields = false
  ;

  RequestAirdropRequest._() : super();
  factory RequestAirdropRequest({
    $8.SolanaAccountId accountId,
    $fixnum.Int64 quarks,
    $8.Commitment commitment,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (quarks != null) {
      _result.quarks = quarks;
    }
    if (commitment != null) {
      _result.commitment = commitment;
    }
    return _result;
  }
  factory RequestAirdropRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestAirdropRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestAirdropRequest clone() => RequestAirdropRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestAirdropRequest copyWith(void Function(RequestAirdropRequest) updates) => super.copyWith((message) => updates(message as RequestAirdropRequest)) as RequestAirdropRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestAirdropRequest create() => RequestAirdropRequest._();
  RequestAirdropRequest createEmptyInstance() => create();
  static $pb.PbList<RequestAirdropRequest> createRepeated() => $pb.PbList<RequestAirdropRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestAirdropRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestAirdropRequest>(create);
  static RequestAirdropRequest _defaultInstance;

  @$pb.TagNumber(1)
  $8.SolanaAccountId get accountId => $_getN(0);
  @$pb.TagNumber(1)
  set accountId($8.SolanaAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
  @$pb.TagNumber(1)
  $8.SolanaAccountId ensureAccountId() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get quarks => $_getI64(1);
  @$pb.TagNumber(2)
  set quarks($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuarks() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuarks() => clearField(2);

  @$pb.TagNumber(3)
  $8.Commitment get commitment => $_getN(2);
  @$pb.TagNumber(3)
  set commitment($8.Commitment v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCommitment() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommitment() => clearField(3);
}

class RequestAirdropResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestAirdropResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.airdrop.v4'), createEmptyInstance: create)
    ..e<RequestAirdropResponse_Result>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.OE, defaultOrMaker: RequestAirdropResponse_Result.OK, valueOf: RequestAirdropResponse_Result.valueOf, enumValues: RequestAirdropResponse_Result.values)
    ..aOM<$8.TransactionSignature>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', subBuilder: $8.TransactionSignature.create)
    ..hasRequiredFields = false
  ;

  RequestAirdropResponse._() : super();
  factory RequestAirdropResponse({
    RequestAirdropResponse_Result result,
    $8.TransactionSignature signature,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }
  factory RequestAirdropResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestAirdropResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestAirdropResponse clone() => RequestAirdropResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestAirdropResponse copyWith(void Function(RequestAirdropResponse) updates) => super.copyWith((message) => updates(message as RequestAirdropResponse)) as RequestAirdropResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestAirdropResponse create() => RequestAirdropResponse._();
  RequestAirdropResponse createEmptyInstance() => create();
  static $pb.PbList<RequestAirdropResponse> createRepeated() => $pb.PbList<RequestAirdropResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestAirdropResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestAirdropResponse>(create);
  static RequestAirdropResponse _defaultInstance;

  @$pb.TagNumber(1)
  RequestAirdropResponse_Result get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(RequestAirdropResponse_Result v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(2)
  $8.TransactionSignature get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($8.TransactionSignature v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => clearField(2);
  @$pb.TagNumber(2)
  $8.TransactionSignature ensureSignature() => $_ensure(1);
}

