///
//  Generated code. Do not modify.
//  source: transaction/v4/transaction_service.proto
//

// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../common/v4/model.pb.dart' as $8;
import '../../common/v3/model.pb.dart' as $9;
import '../../google/protobuf/timestamp.pb.dart' as $7;

import 'transaction_service.pbenum.dart';
import '../../common/v4/model.pbenum.dart' as $8;

export 'transaction_service.pbenum.dart';

class GetServiceConfigRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetServiceConfigRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetServiceConfigRequest._() : super();
  factory GetServiceConfigRequest() => create();
  factory GetServiceConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetServiceConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetServiceConfigRequest clone() => GetServiceConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetServiceConfigRequest copyWith(void Function(GetServiceConfigRequest) updates) => super.copyWith((message) => updates(message as GetServiceConfigRequest)) as GetServiceConfigRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetServiceConfigRequest create() => GetServiceConfigRequest._();
  GetServiceConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetServiceConfigRequest> createRepeated() => $pb.PbList<GetServiceConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetServiceConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetServiceConfigRequest>(create);
  static GetServiceConfigRequest? _defaultInstance;
}

class GetServiceConfigResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetServiceConfigResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..aOM<$8.SolanaAccountId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subsidizerAccount', subBuilder: $8.SolanaAccountId.create)
    ..aOM<$8.SolanaAccountId>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tokenProgram', subBuilder: $8.SolanaAccountId.create)
    ..aOM<$8.SolanaAccountId>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token', subBuilder: $8.SolanaAccountId.create)
    ..hasRequiredFields = false
  ;

  GetServiceConfigResponse._() : super();
  factory GetServiceConfigResponse({
    $8.SolanaAccountId? subsidizerAccount,
    $8.SolanaAccountId? tokenProgram,
    $8.SolanaAccountId? token,
  }) {
    final _result = create();
    if (subsidizerAccount != null) {
      _result.subsidizerAccount = subsidizerAccount;
    }
    if (tokenProgram != null) {
      _result.tokenProgram = tokenProgram;
    }
    if (token != null) {
      _result.token = token;
    }
    return _result;
  }
  factory GetServiceConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetServiceConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetServiceConfigResponse clone() => GetServiceConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetServiceConfigResponse copyWith(void Function(GetServiceConfigResponse) updates) => super.copyWith((message) => updates(message as GetServiceConfigResponse)) as GetServiceConfigResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetServiceConfigResponse create() => GetServiceConfigResponse._();
  GetServiceConfigResponse createEmptyInstance() => create();
  static $pb.PbList<GetServiceConfigResponse> createRepeated() => $pb.PbList<GetServiceConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static GetServiceConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetServiceConfigResponse>(create);
  static GetServiceConfigResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $8.SolanaAccountId get subsidizerAccount => $_getN(0);
  @$pb.TagNumber(1)
  set subsidizerAccount($8.SolanaAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSubsidizerAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubsidizerAccount() => clearField(1);
  @$pb.TagNumber(1)
  $8.SolanaAccountId ensureSubsidizerAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $8.SolanaAccountId get tokenProgram => $_getN(1);
  @$pb.TagNumber(2)
  set tokenProgram($8.SolanaAccountId v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTokenProgram() => $_has(1);
  @$pb.TagNumber(2)
  void clearTokenProgram() => clearField(2);
  @$pb.TagNumber(2)
  $8.SolanaAccountId ensureTokenProgram() => $_ensure(1);

  @$pb.TagNumber(3)
  $8.SolanaAccountId get token => $_getN(2);
  @$pb.TagNumber(3)
  set token($8.SolanaAccountId v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearToken() => clearField(3);
  @$pb.TagNumber(3)
  $8.SolanaAccountId ensureToken() => $_ensure(2);
}

class GetMinimumKinVersionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMinimumKinVersionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetMinimumKinVersionRequest._() : super();
  factory GetMinimumKinVersionRequest() => create();
  factory GetMinimumKinVersionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMinimumKinVersionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMinimumKinVersionRequest clone() => GetMinimumKinVersionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMinimumKinVersionRequest copyWith(void Function(GetMinimumKinVersionRequest) updates) => super.copyWith((message) => updates(message as GetMinimumKinVersionRequest)) as GetMinimumKinVersionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMinimumKinVersionRequest create() => GetMinimumKinVersionRequest._();
  GetMinimumKinVersionRequest createEmptyInstance() => create();
  static $pb.PbList<GetMinimumKinVersionRequest> createRepeated() => $pb.PbList<GetMinimumKinVersionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMinimumKinVersionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMinimumKinVersionRequest>(create);
  static GetMinimumKinVersionRequest? _defaultInstance;
}

class GetMinimumKinVersionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMinimumKinVersionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'version', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  GetMinimumKinVersionResponse._() : super();
  factory GetMinimumKinVersionResponse({
    $core.int? version,
  }) {
    final _result = create();
    if (version != null) {
      _result.version = version;
    }
    return _result;
  }
  factory GetMinimumKinVersionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMinimumKinVersionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMinimumKinVersionResponse clone() => GetMinimumKinVersionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMinimumKinVersionResponse copyWith(void Function(GetMinimumKinVersionResponse) updates) => super.copyWith((message) => updates(message as GetMinimumKinVersionResponse)) as GetMinimumKinVersionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMinimumKinVersionResponse create() => GetMinimumKinVersionResponse._();
  GetMinimumKinVersionResponse createEmptyInstance() => create();
  static $pb.PbList<GetMinimumKinVersionResponse> createRepeated() => $pb.PbList<GetMinimumKinVersionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMinimumKinVersionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMinimumKinVersionResponse>(create);
  static GetMinimumKinVersionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);
}

class GetRecentBlockhashRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetRecentBlockhashRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetRecentBlockhashRequest._() : super();
  factory GetRecentBlockhashRequest() => create();
  factory GetRecentBlockhashRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentBlockhashRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentBlockhashRequest clone() => GetRecentBlockhashRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentBlockhashRequest copyWith(void Function(GetRecentBlockhashRequest) updates) => super.copyWith((message) => updates(message as GetRecentBlockhashRequest)) as GetRecentBlockhashRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetRecentBlockhashRequest create() => GetRecentBlockhashRequest._();
  GetRecentBlockhashRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecentBlockhashRequest> createRepeated() => $pb.PbList<GetRecentBlockhashRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecentBlockhashRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecentBlockhashRequest>(create);
  static GetRecentBlockhashRequest? _defaultInstance;
}

class GetRecentBlockhashResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetRecentBlockhashResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..aOM<$8.Blockhash>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockhash', subBuilder: $8.Blockhash.create)
    ..hasRequiredFields = false
  ;

  GetRecentBlockhashResponse._() : super();
  factory GetRecentBlockhashResponse({
    $8.Blockhash? blockhash,
  }) {
    final _result = create();
    if (blockhash != null) {
      _result.blockhash = blockhash;
    }
    return _result;
  }
  factory GetRecentBlockhashResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentBlockhashResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentBlockhashResponse clone() => GetRecentBlockhashResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentBlockhashResponse copyWith(void Function(GetRecentBlockhashResponse) updates) => super.copyWith((message) => updates(message as GetRecentBlockhashResponse)) as GetRecentBlockhashResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetRecentBlockhashResponse create() => GetRecentBlockhashResponse._();
  GetRecentBlockhashResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecentBlockhashResponse> createRepeated() => $pb.PbList<GetRecentBlockhashResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecentBlockhashResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecentBlockhashResponse>(create);
  static GetRecentBlockhashResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $8.Blockhash get blockhash => $_getN(0);
  @$pb.TagNumber(1)
  set blockhash($8.Blockhash v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlockhash() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlockhash() => clearField(1);
  @$pb.TagNumber(1)
  $8.Blockhash ensureBlockhash() => $_ensure(0);
}

class GetMinimumBalanceForRentExemptionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMinimumBalanceForRentExemptionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'size', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  GetMinimumBalanceForRentExemptionRequest._() : super();
  factory GetMinimumBalanceForRentExemptionRequest({
    $fixnum.Int64? size,
  }) {
    final _result = create();
    if (size != null) {
      _result.size = size;
    }
    return _result;
  }
  factory GetMinimumBalanceForRentExemptionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMinimumBalanceForRentExemptionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMinimumBalanceForRentExemptionRequest clone() => GetMinimumBalanceForRentExemptionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMinimumBalanceForRentExemptionRequest copyWith(void Function(GetMinimumBalanceForRentExemptionRequest) updates) => super.copyWith((message) => updates(message as GetMinimumBalanceForRentExemptionRequest)) as GetMinimumBalanceForRentExemptionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMinimumBalanceForRentExemptionRequest create() => GetMinimumBalanceForRentExemptionRequest._();
  GetMinimumBalanceForRentExemptionRequest createEmptyInstance() => create();
  static $pb.PbList<GetMinimumBalanceForRentExemptionRequest> createRepeated() => $pb.PbList<GetMinimumBalanceForRentExemptionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMinimumBalanceForRentExemptionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMinimumBalanceForRentExemptionRequest>(create);
  static GetMinimumBalanceForRentExemptionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get size => $_getI64(0);
  @$pb.TagNumber(1)
  set size($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearSize() => clearField(1);
}

class GetMinimumBalanceForRentExemptionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMinimumBalanceForRentExemptionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lamports', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  GetMinimumBalanceForRentExemptionResponse._() : super();
  factory GetMinimumBalanceForRentExemptionResponse({
    $fixnum.Int64? lamports,
  }) {
    final _result = create();
    if (lamports != null) {
      _result.lamports = lamports;
    }
    return _result;
  }
  factory GetMinimumBalanceForRentExemptionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMinimumBalanceForRentExemptionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMinimumBalanceForRentExemptionResponse clone() => GetMinimumBalanceForRentExemptionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMinimumBalanceForRentExemptionResponse copyWith(void Function(GetMinimumBalanceForRentExemptionResponse) updates) => super.copyWith((message) => updates(message as GetMinimumBalanceForRentExemptionResponse)) as GetMinimumBalanceForRentExemptionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMinimumBalanceForRentExemptionResponse create() => GetMinimumBalanceForRentExemptionResponse._();
  GetMinimumBalanceForRentExemptionResponse createEmptyInstance() => create();
  static $pb.PbList<GetMinimumBalanceForRentExemptionResponse> createRepeated() => $pb.PbList<GetMinimumBalanceForRentExemptionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMinimumBalanceForRentExemptionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMinimumBalanceForRentExemptionResponse>(create);
  static GetMinimumBalanceForRentExemptionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get lamports => $_getI64(0);
  @$pb.TagNumber(1)
  set lamports($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLamports() => $_has(0);
  @$pb.TagNumber(1)
  void clearLamports() => clearField(1);
}

class GetHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..aOM<$8.SolanaAccountId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', subBuilder: $8.SolanaAccountId.create)
    ..aOM<Cursor>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cursor', subBuilder: Cursor.create)
    ..e<GetHistoryRequest_Direction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: GetHistoryRequest_Direction.ASC, valueOf: GetHistoryRequest_Direction.valueOf, enumValues: GetHistoryRequest_Direction.values)
    ..hasRequiredFields = false
  ;

  GetHistoryRequest._() : super();
  factory GetHistoryRequest({
    $8.SolanaAccountId? accountId,
    Cursor? cursor,
    GetHistoryRequest_Direction? direction,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (cursor != null) {
      _result.cursor = cursor;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    return _result;
  }
  factory GetHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetHistoryRequest clone() => GetHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetHistoryRequest copyWith(void Function(GetHistoryRequest) updates) => super.copyWith((message) => updates(message as GetHistoryRequest)) as GetHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetHistoryRequest create() => GetHistoryRequest._();
  GetHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetHistoryRequest> createRepeated() => $pb.PbList<GetHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetHistoryRequest>(create);
  static GetHistoryRequest? _defaultInstance;

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
  Cursor get cursor => $_getN(1);
  @$pb.TagNumber(2)
  set cursor(Cursor v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearCursor() => clearField(2);
  @$pb.TagNumber(2)
  Cursor ensureCursor() => $_ensure(1);

  @$pb.TagNumber(3)
  GetHistoryRequest_Direction get direction => $_getN(2);
  @$pb.TagNumber(3)
  set direction(GetHistoryRequest_Direction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => clearField(3);
}

class GetHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..e<GetHistoryResponse_Result>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.OE, defaultOrMaker: GetHistoryResponse_Result.OK, valueOf: GetHistoryResponse_Result.valueOf, enumValues: GetHistoryResponse_Result.values)
    ..pc<HistoryItem>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: HistoryItem.create)
    ..hasRequiredFields = false
  ;

  GetHistoryResponse._() : super();
  factory GetHistoryResponse({
    GetHistoryResponse_Result? result,
    $core.Iterable<HistoryItem>? items,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory GetHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetHistoryResponse clone() => GetHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetHistoryResponse copyWith(void Function(GetHistoryResponse) updates) => super.copyWith((message) => updates(message as GetHistoryResponse)) as GetHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetHistoryResponse create() => GetHistoryResponse._();
  GetHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetHistoryResponse> createRepeated() => $pb.PbList<GetHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetHistoryResponse>(create);
  static GetHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GetHistoryResponse_Result get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(GetHistoryResponse_Result v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<HistoryItem> get items => $_getList(1);
}

class SignTransactionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignTransactionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..aOM<$8.Transaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: $8.Transaction.create)
    ..aOM<$9.InvoiceList>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceList', subBuilder: $9.InvoiceList.create)
    ..hasRequiredFields = false
  ;

  SignTransactionRequest._() : super();
  factory SignTransactionRequest({
    $8.Transaction? transaction,
    $9.InvoiceList? invoiceList,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (invoiceList != null) {
      _result.invoiceList = invoiceList;
    }
    return _result;
  }
  factory SignTransactionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignTransactionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignTransactionRequest clone() => SignTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignTransactionRequest copyWith(void Function(SignTransactionRequest) updates) => super.copyWith((message) => updates(message as SignTransactionRequest)) as SignTransactionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignTransactionRequest create() => SignTransactionRequest._();
  SignTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<SignTransactionRequest> createRepeated() => $pb.PbList<SignTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static SignTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignTransactionRequest>(create);
  static SignTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $8.Transaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($8.Transaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  $8.Transaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $9.InvoiceList get invoiceList => $_getN(1);
  @$pb.TagNumber(2)
  set invoiceList($9.InvoiceList v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvoiceList() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceList() => clearField(2);
  @$pb.TagNumber(2)
  $9.InvoiceList ensureInvoiceList() => $_ensure(1);
}

class SignTransactionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignTransactionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..e<SignTransactionResponse_Result>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.OE, defaultOrMaker: SignTransactionResponse_Result.OK, valueOf: SignTransactionResponse_Result.valueOf, enumValues: SignTransactionResponse_Result.values)
    ..aOM<$8.TransactionSignature>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', subBuilder: $8.TransactionSignature.create)
    ..pc<$9.InvoiceError>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceErrors', $pb.PbFieldType.PM, subBuilder: $9.InvoiceError.create)
    ..hasRequiredFields = false
  ;

  SignTransactionResponse._() : super();
  factory SignTransactionResponse({
    SignTransactionResponse_Result? result,
    $8.TransactionSignature? signature,
    $core.Iterable<$9.InvoiceError>? invoiceErrors,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    if (invoiceErrors != null) {
      _result.invoiceErrors.addAll(invoiceErrors);
    }
    return _result;
  }
  factory SignTransactionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignTransactionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignTransactionResponse clone() => SignTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignTransactionResponse copyWith(void Function(SignTransactionResponse) updates) => super.copyWith((message) => updates(message as SignTransactionResponse)) as SignTransactionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignTransactionResponse create() => SignTransactionResponse._();
  SignTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<SignTransactionResponse> createRepeated() => $pb.PbList<SignTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static SignTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignTransactionResponse>(create);
  static SignTransactionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SignTransactionResponse_Result get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(SignTransactionResponse_Result v) { setField(1, v); }
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

  @$pb.TagNumber(4)
  $core.List<$9.InvoiceError> get invoiceErrors => $_getList(2);
}

class SubmitTransactionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitTransactionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..aOM<$8.Transaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: $8.Transaction.create)
    ..aOM<$9.InvoiceList>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceList', subBuilder: $9.InvoiceList.create)
    ..e<$8.Commitment>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commitment', $pb.PbFieldType.OE, defaultOrMaker: $8.Commitment.RECENT, valueOf: $8.Commitment.valueOf, enumValues: $8.Commitment.values)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dedupeId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  SubmitTransactionRequest._() : super();
  factory SubmitTransactionRequest({
    $8.Transaction? transaction,
    $9.InvoiceList? invoiceList,
    $8.Commitment? commitment,
    $core.List<$core.int>? dedupeId,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (invoiceList != null) {
      _result.invoiceList = invoiceList;
    }
    if (commitment != null) {
      _result.commitment = commitment;
    }
    if (dedupeId != null) {
      _result.dedupeId = dedupeId;
    }
    return _result;
  }
  factory SubmitTransactionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitTransactionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitTransactionRequest clone() => SubmitTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitTransactionRequest copyWith(void Function(SubmitTransactionRequest) updates) => super.copyWith((message) => updates(message as SubmitTransactionRequest)) as SubmitTransactionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubmitTransactionRequest create() => SubmitTransactionRequest._();
  SubmitTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitTransactionRequest> createRepeated() => $pb.PbList<SubmitTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubmitTransactionRequest>(create);
  static SubmitTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $8.Transaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($8.Transaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  $8.Transaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $9.InvoiceList get invoiceList => $_getN(1);
  @$pb.TagNumber(2)
  set invoiceList($9.InvoiceList v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvoiceList() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceList() => clearField(2);
  @$pb.TagNumber(2)
  $9.InvoiceList ensureInvoiceList() => $_ensure(1);

  @$pb.TagNumber(3)
  $8.Commitment get commitment => $_getN(2);
  @$pb.TagNumber(3)
  set commitment($8.Commitment v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCommitment() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommitment() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get dedupeId => $_getN(3);
  @$pb.TagNumber(4)
  set dedupeId($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDedupeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDedupeId() => clearField(4);
}

class SubmitTransactionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitTransactionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..e<SubmitTransactionResponse_Result>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.OE, defaultOrMaker: SubmitTransactionResponse_Result.OK, valueOf: SubmitTransactionResponse_Result.valueOf, enumValues: SubmitTransactionResponse_Result.values)
    ..aOM<$8.TransactionSignature>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', subBuilder: $8.TransactionSignature.create)
    ..aOM<$8.TransactionError>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionError', subBuilder: $8.TransactionError.create)
    ..pc<$9.InvoiceError>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceErrors', $pb.PbFieldType.PM, subBuilder: $9.InvoiceError.create)
    ..hasRequiredFields = false
  ;

  SubmitTransactionResponse._() : super();
  factory SubmitTransactionResponse({
    SubmitTransactionResponse_Result? result,
    $8.TransactionSignature? signature,
    $8.TransactionError? transactionError,
    $core.Iterable<$9.InvoiceError>? invoiceErrors,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    if (transactionError != null) {
      _result.transactionError = transactionError;
    }
    if (invoiceErrors != null) {
      _result.invoiceErrors.addAll(invoiceErrors);
    }
    return _result;
  }
  factory SubmitTransactionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitTransactionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitTransactionResponse clone() => SubmitTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitTransactionResponse copyWith(void Function(SubmitTransactionResponse) updates) => super.copyWith((message) => updates(message as SubmitTransactionResponse)) as SubmitTransactionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubmitTransactionResponse create() => SubmitTransactionResponse._();
  SubmitTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitTransactionResponse> createRepeated() => $pb.PbList<SubmitTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubmitTransactionResponse>(create);
  static SubmitTransactionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SubmitTransactionResponse_Result get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(SubmitTransactionResponse_Result v) { setField(1, v); }
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

  @$pb.TagNumber(3)
  $8.TransactionError get transactionError => $_getN(2);
  @$pb.TagNumber(3)
  set transactionError($8.TransactionError v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionError() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionError() => clearField(3);
  @$pb.TagNumber(3)
  $8.TransactionError ensureTransactionError() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$9.InvoiceError> get invoiceErrors => $_getList(3);
}

class GetTransactionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransactionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..aOM<$8.TransactionId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId', subBuilder: $8.TransactionId.create)
    ..e<$8.Commitment>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commitment', $pb.PbFieldType.OE, defaultOrMaker: $8.Commitment.RECENT, valueOf: $8.Commitment.valueOf, enumValues: $8.Commitment.values)
    ..hasRequiredFields = false
  ;

  GetTransactionRequest._() : super();
  factory GetTransactionRequest({
    $8.TransactionId? transactionId,
    $8.Commitment? commitment,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (commitment != null) {
      _result.commitment = commitment;
    }
    return _result;
  }
  factory GetTransactionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionRequest clone() => GetTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionRequest copyWith(void Function(GetTransactionRequest) updates) => super.copyWith((message) => updates(message as GetTransactionRequest)) as GetTransactionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTransactionRequest create() => GetTransactionRequest._();
  GetTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionRequest> createRepeated() => $pb.PbList<GetTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionRequest>(create);
  static GetTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $8.TransactionId get transactionId => $_getN(0);
  @$pb.TagNumber(1)
  set transactionId($8.TransactionId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);
  @$pb.TagNumber(1)
  $8.TransactionId ensureTransactionId() => $_ensure(0);

  @$pb.TagNumber(2)
  $8.Commitment get commitment => $_getN(1);
  @$pb.TagNumber(2)
  set commitment($8.Commitment v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCommitment() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommitment() => clearField(2);
}

class GetTransactionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransactionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..e<GetTransactionResponse_State>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: GetTransactionResponse_State.UNKNOWN, valueOf: GetTransactionResponse_State.valueOf, enumValues: GetTransactionResponse_State.values)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'slot', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmations', $pb.PbFieldType.OU3)
    ..aOM<HistoryItem>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', subBuilder: HistoryItem.create)
    ..hasRequiredFields = false
  ;

  GetTransactionResponse._() : super();
  factory GetTransactionResponse({
    GetTransactionResponse_State? state,
    $fixnum.Int64? slot,
    $core.int? confirmations,
    HistoryItem? item,
  }) {
    final _result = create();
    if (state != null) {
      _result.state = state;
    }
    if (slot != null) {
      _result.slot = slot;
    }
    if (confirmations != null) {
      _result.confirmations = confirmations;
    }
    if (item != null) {
      _result.item = item;
    }
    return _result;
  }
  factory GetTransactionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionResponse clone() => GetTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionResponse copyWith(void Function(GetTransactionResponse) updates) => super.copyWith((message) => updates(message as GetTransactionResponse)) as GetTransactionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTransactionResponse create() => GetTransactionResponse._();
  GetTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionResponse> createRepeated() => $pb.PbList<GetTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionResponse>(create);
  static GetTransactionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GetTransactionResponse_State get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(GetTransactionResponse_State v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get slot => $_getI64(1);
  @$pb.TagNumber(2)
  set slot($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSlot() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlot() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get confirmations => $_getIZ(2);
  @$pb.TagNumber(3)
  set confirmations($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfirmations() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfirmations() => clearField(3);

  @$pb.TagNumber(4)
  HistoryItem get item => $_getN(3);
  @$pb.TagNumber(4)
  set item(HistoryItem v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasItem() => $_has(3);
  @$pb.TagNumber(4)
  void clearItem() => clearField(4);
  @$pb.TagNumber(4)
  HistoryItem ensureItem() => $_ensure(3);
}

class HistoryItem_Payment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HistoryItem.Payment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..aOM<$8.SolanaAccountId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source', subBuilder: $8.SolanaAccountId.create)
    ..aOM<$8.SolanaAccountId>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destination', subBuilder: $8.SolanaAccountId.create)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'index', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  HistoryItem_Payment._() : super();
  factory HistoryItem_Payment({
    $8.SolanaAccountId? source,
    $8.SolanaAccountId? destination,
    $fixnum.Int64? amount,
    $core.int? index,
  }) {
    final _result = create();
    if (source != null) {
      _result.source = source;
    }
    if (destination != null) {
      _result.destination = destination;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (index != null) {
      _result.index = index;
    }
    return _result;
  }
  factory HistoryItem_Payment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HistoryItem_Payment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HistoryItem_Payment clone() => HistoryItem_Payment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HistoryItem_Payment copyWith(void Function(HistoryItem_Payment) updates) => super.copyWith((message) => updates(message as HistoryItem_Payment)) as HistoryItem_Payment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HistoryItem_Payment create() => HistoryItem_Payment._();
  HistoryItem_Payment createEmptyInstance() => create();
  static $pb.PbList<HistoryItem_Payment> createRepeated() => $pb.PbList<HistoryItem_Payment>();
  @$core.pragma('dart2js:noInline')
  static HistoryItem_Payment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HistoryItem_Payment>(create);
  static HistoryItem_Payment? _defaultInstance;

  @$pb.TagNumber(1)
  $8.SolanaAccountId get source => $_getN(0);
  @$pb.TagNumber(1)
  set source($8.SolanaAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSource() => clearField(1);
  @$pb.TagNumber(1)
  $8.SolanaAccountId ensureSource() => $_ensure(0);

  @$pb.TagNumber(2)
  $8.SolanaAccountId get destination => $_getN(1);
  @$pb.TagNumber(2)
  set destination($8.SolanaAccountId v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDestination() => $_has(1);
  @$pb.TagNumber(2)
  void clearDestination() => clearField(2);
  @$pb.TagNumber(2)
  $8.SolanaAccountId ensureDestination() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get index => $_getIZ(3);
  @$pb.TagNumber(4)
  set index($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearIndex() => clearField(4);
}

enum HistoryItem_RawTransaction {
  solanaTransaction, 
  stellarTransaction, 
  notSet
}

class HistoryItem extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, HistoryItem_RawTransaction> _HistoryItem_RawTransactionByTag = {
    3 : HistoryItem_RawTransaction.solanaTransaction,
    4 : HistoryItem_RawTransaction.stellarTransaction,
    0 : HistoryItem_RawTransaction.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HistoryItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..aOM<$8.TransactionId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId', subBuilder: $8.TransactionId.create)
    ..aOM<Cursor>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cursor', subBuilder: Cursor.create)
    ..aOM<$8.Transaction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'solanaTransaction', subBuilder: $8.Transaction.create)
    ..aOM<$8.StellarTransaction>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stellarTransaction', subBuilder: $8.StellarTransaction.create)
    ..aOM<$8.TransactionError>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionError', subBuilder: $8.TransactionError.create)
    ..pc<HistoryItem_Payment>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: HistoryItem_Payment.create)
    ..aOM<$9.InvoiceList>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceList', subBuilder: $9.InvoiceList.create)
    ..aOM<$7.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionTime', subBuilder: $7.Timestamp.create)
    ..hasRequiredFields = false
  ;

  HistoryItem._() : super();
  factory HistoryItem({
    $8.TransactionId? transactionId,
    Cursor? cursor,
    $8.Transaction? solanaTransaction,
    $8.StellarTransaction? stellarTransaction,
    $8.TransactionError? transactionError,
    $core.Iterable<HistoryItem_Payment>? payments,
    $9.InvoiceList? invoiceList,
    $7.Timestamp? transactionTime,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (cursor != null) {
      _result.cursor = cursor;
    }
    if (solanaTransaction != null) {
      _result.solanaTransaction = solanaTransaction;
    }
    if (stellarTransaction != null) {
      _result.stellarTransaction = stellarTransaction;
    }
    if (transactionError != null) {
      _result.transactionError = transactionError;
    }
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    if (invoiceList != null) {
      _result.invoiceList = invoiceList;
    }
    if (transactionTime != null) {
      _result.transactionTime = transactionTime;
    }
    return _result;
  }
  factory HistoryItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HistoryItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HistoryItem clone() => HistoryItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HistoryItem copyWith(void Function(HistoryItem) updates) => super.copyWith((message) => updates(message as HistoryItem)) as HistoryItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HistoryItem create() => HistoryItem._();
  HistoryItem createEmptyInstance() => create();
  static $pb.PbList<HistoryItem> createRepeated() => $pb.PbList<HistoryItem>();
  @$core.pragma('dart2js:noInline')
  static HistoryItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HistoryItem>(create);
  static HistoryItem? _defaultInstance;

  HistoryItem_RawTransaction? whichRawTransaction() => _HistoryItem_RawTransactionByTag[$_whichOneof(0)];
  void clearRawTransaction() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $8.TransactionId get transactionId => $_getN(0);
  @$pb.TagNumber(1)
  set transactionId($8.TransactionId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);
  @$pb.TagNumber(1)
  $8.TransactionId ensureTransactionId() => $_ensure(0);

  @$pb.TagNumber(2)
  Cursor get cursor => $_getN(1);
  @$pb.TagNumber(2)
  set cursor(Cursor v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearCursor() => clearField(2);
  @$pb.TagNumber(2)
  Cursor ensureCursor() => $_ensure(1);

  @$pb.TagNumber(3)
  $8.Transaction get solanaTransaction => $_getN(2);
  @$pb.TagNumber(3)
  set solanaTransaction($8.Transaction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSolanaTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearSolanaTransaction() => clearField(3);
  @$pb.TagNumber(3)
  $8.Transaction ensureSolanaTransaction() => $_ensure(2);

  @$pb.TagNumber(4)
  $8.StellarTransaction get stellarTransaction => $_getN(3);
  @$pb.TagNumber(4)
  set stellarTransaction($8.StellarTransaction v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStellarTransaction() => $_has(3);
  @$pb.TagNumber(4)
  void clearStellarTransaction() => clearField(4);
  @$pb.TagNumber(4)
  $8.StellarTransaction ensureStellarTransaction() => $_ensure(3);

  @$pb.TagNumber(5)
  $8.TransactionError get transactionError => $_getN(4);
  @$pb.TagNumber(5)
  set transactionError($8.TransactionError v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionError() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionError() => clearField(5);
  @$pb.TagNumber(5)
  $8.TransactionError ensureTransactionError() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.List<HistoryItem_Payment> get payments => $_getList(5);

  @$pb.TagNumber(7)
  $9.InvoiceList get invoiceList => $_getN(6);
  @$pb.TagNumber(7)
  set invoiceList($9.InvoiceList v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasInvoiceList() => $_has(6);
  @$pb.TagNumber(7)
  void clearInvoiceList() => clearField(7);
  @$pb.TagNumber(7)
  $9.InvoiceList ensureInvoiceList() => $_ensure(6);

  @$pb.TagNumber(8)
  $7.Timestamp get transactionTime => $_getN(7);
  @$pb.TagNumber(8)
  set transactionTime($7.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasTransactionTime() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransactionTime() => clearField(8);
  @$pb.TagNumber(8)
  $7.Timestamp ensureTransactionTime() => $_ensure(7);
}

class Cursor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Cursor', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v4'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Cursor._() : super();
  factory Cursor({
    $core.List<$core.int>? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory Cursor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Cursor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Cursor clone() => Cursor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Cursor copyWith(void Function(Cursor) updates) => super.copyWith((message) => updates(message as Cursor)) as Cursor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Cursor create() => Cursor._();
  Cursor createEmptyInstance() => create();
  static $pb.PbList<Cursor> createRepeated() => $pb.PbList<Cursor>();
  @$core.pragma('dart2js:noInline')
  static Cursor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Cursor>(create);
  static Cursor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

