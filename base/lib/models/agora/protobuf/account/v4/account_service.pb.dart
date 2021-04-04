///
//  Generated code. Do not modify.
//  source: account/v4/account_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../common/v4/model.pb.dart' as $3;

import '../../common/v4/model.pbenum.dart' as $3;
import 'account_service.pbenum.dart';

export 'account_service.pbenum.dart';

class AccountInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AccountInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..aOM<$3.SolanaAccountId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', subBuilder: $3.SolanaAccountId.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance')
    ..hasRequiredFields = false
  ;

  AccountInfo._() : super();
  factory AccountInfo({
    $3.SolanaAccountId accountId,
    $fixnum.Int64 balance,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    return _result;
  }
  factory AccountInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountInfo clone() => AccountInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountInfo copyWith(void Function(AccountInfo) updates) => super.copyWith((message) => updates(message as AccountInfo)) as AccountInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AccountInfo create() => AccountInfo._();
  AccountInfo createEmptyInstance() => create();
  static $pb.PbList<AccountInfo> createRepeated() => $pb.PbList<AccountInfo>();
  @$core.pragma('dart2js:noInline')
  static AccountInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountInfo>(create);
  static AccountInfo _defaultInstance;

  @$pb.TagNumber(1)
  $3.SolanaAccountId get accountId => $_getN(0);
  @$pb.TagNumber(1)
  set accountId($3.SolanaAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
  @$pb.TagNumber(1)
  $3.SolanaAccountId ensureAccountId() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get balance => $_getI64(1);
  @$pb.TagNumber(2)
  set balance($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearBalance() => clearField(2);
}

class CreateAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..aOM<$3.Transaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: $3.Transaction.create)
    ..e<$3.Commitment>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commitment', $pb.PbFieldType.OE, defaultOrMaker: $3.Commitment.RECENT, valueOf: $3.Commitment.valueOf, enumValues: $3.Commitment.values)
    ..hasRequiredFields = false
  ;

  CreateAccountRequest._() : super();
  factory CreateAccountRequest({
    $3.Transaction transaction,
    $3.Commitment commitment,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (commitment != null) {
      _result.commitment = commitment;
    }
    return _result;
  }
  factory CreateAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAccountRequest clone() => CreateAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAccountRequest copyWith(void Function(CreateAccountRequest) updates) => super.copyWith((message) => updates(message as CreateAccountRequest)) as CreateAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateAccountRequest create() => CreateAccountRequest._();
  CreateAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAccountRequest> createRepeated() => $pb.PbList<CreateAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAccountRequest>(create);
  static CreateAccountRequest _defaultInstance;

  @$pb.TagNumber(1)
  $3.Transaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($3.Transaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  $3.Transaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $3.Commitment get commitment => $_getN(1);
  @$pb.TagNumber(2)
  set commitment($3.Commitment v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCommitment() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommitment() => clearField(2);
}

class CreateAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..e<CreateAccountResponse_Result>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.OE, defaultOrMaker: CreateAccountResponse_Result.OK, valueOf: CreateAccountResponse_Result.valueOf, enumValues: CreateAccountResponse_Result.values)
    ..aOM<AccountInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountInfo', subBuilder: AccountInfo.create)
    ..hasRequiredFields = false
  ;

  CreateAccountResponse._() : super();
  factory CreateAccountResponse({
    CreateAccountResponse_Result result,
    AccountInfo accountInfo,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (accountInfo != null) {
      _result.accountInfo = accountInfo;
    }
    return _result;
  }
  factory CreateAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAccountResponse clone() => CreateAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAccountResponse copyWith(void Function(CreateAccountResponse) updates) => super.copyWith((message) => updates(message as CreateAccountResponse)) as CreateAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateAccountResponse create() => CreateAccountResponse._();
  CreateAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CreateAccountResponse> createRepeated() => $pb.PbList<CreateAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAccountResponse>(create);
  static CreateAccountResponse _defaultInstance;

  @$pb.TagNumber(1)
  CreateAccountResponse_Result get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(CreateAccountResponse_Result v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(2)
  AccountInfo get accountInfo => $_getN(1);
  @$pb.TagNumber(2)
  set accountInfo(AccountInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountInfo() => clearField(2);
  @$pb.TagNumber(2)
  AccountInfo ensureAccountInfo() => $_ensure(1);
}

class GetAccountInfoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountInfoRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..aOM<$3.SolanaAccountId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', subBuilder: $3.SolanaAccountId.create)
    ..e<$3.Commitment>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commitment', $pb.PbFieldType.OE, defaultOrMaker: $3.Commitment.RECENT, valueOf: $3.Commitment.valueOf, enumValues: $3.Commitment.values)
    ..hasRequiredFields = false
  ;

  GetAccountInfoRequest._() : super();
  factory GetAccountInfoRequest({
    $3.SolanaAccountId accountId,
    $3.Commitment commitment,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (commitment != null) {
      _result.commitment = commitment;
    }
    return _result;
  }
  factory GetAccountInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountInfoRequest clone() => GetAccountInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountInfoRequest copyWith(void Function(GetAccountInfoRequest) updates) => super.copyWith((message) => updates(message as GetAccountInfoRequest)) as GetAccountInfoRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoRequest create() => GetAccountInfoRequest._();
  GetAccountInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountInfoRequest> createRepeated() => $pb.PbList<GetAccountInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountInfoRequest>(create);
  static GetAccountInfoRequest _defaultInstance;

  @$pb.TagNumber(1)
  $3.SolanaAccountId get accountId => $_getN(0);
  @$pb.TagNumber(1)
  set accountId($3.SolanaAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
  @$pb.TagNumber(1)
  $3.SolanaAccountId ensureAccountId() => $_ensure(0);

  @$pb.TagNumber(2)
  $3.Commitment get commitment => $_getN(1);
  @$pb.TagNumber(2)
  set commitment($3.Commitment v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCommitment() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommitment() => clearField(2);
}

class GetAccountInfoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountInfoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..e<GetAccountInfoResponse_Result>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.OE, defaultOrMaker: GetAccountInfoResponse_Result.OK, valueOf: GetAccountInfoResponse_Result.valueOf, enumValues: GetAccountInfoResponse_Result.values)
    ..aOM<AccountInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountInfo', subBuilder: AccountInfo.create)
    ..hasRequiredFields = false
  ;

  GetAccountInfoResponse._() : super();
  factory GetAccountInfoResponse({
    GetAccountInfoResponse_Result result,
    AccountInfo accountInfo,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (accountInfo != null) {
      _result.accountInfo = accountInfo;
    }
    return _result;
  }
  factory GetAccountInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountInfoResponse clone() => GetAccountInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountInfoResponse copyWith(void Function(GetAccountInfoResponse) updates) => super.copyWith((message) => updates(message as GetAccountInfoResponse)) as GetAccountInfoResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoResponse create() => GetAccountInfoResponse._();
  GetAccountInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountInfoResponse> createRepeated() => $pb.PbList<GetAccountInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountInfoResponse>(create);
  static GetAccountInfoResponse _defaultInstance;

  @$pb.TagNumber(1)
  GetAccountInfoResponse_Result get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(GetAccountInfoResponse_Result v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(2)
  AccountInfo get accountInfo => $_getN(1);
  @$pb.TagNumber(2)
  set accountInfo(AccountInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountInfo() => clearField(2);
  @$pb.TagNumber(2)
  AccountInfo ensureAccountInfo() => $_ensure(1);
}

class ResolveTokenAccountsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveTokenAccountsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..aOM<$3.SolanaAccountId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', subBuilder: $3.SolanaAccountId.create)
    ..hasRequiredFields = false
  ;

  ResolveTokenAccountsRequest._() : super();
  factory ResolveTokenAccountsRequest({
    $3.SolanaAccountId accountId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    return _result;
  }
  factory ResolveTokenAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveTokenAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveTokenAccountsRequest clone() => ResolveTokenAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveTokenAccountsRequest copyWith(void Function(ResolveTokenAccountsRequest) updates) => super.copyWith((message) => updates(message as ResolveTokenAccountsRequest)) as ResolveTokenAccountsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveTokenAccountsRequest create() => ResolveTokenAccountsRequest._();
  ResolveTokenAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveTokenAccountsRequest> createRepeated() => $pb.PbList<ResolveTokenAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveTokenAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveTokenAccountsRequest>(create);
  static ResolveTokenAccountsRequest _defaultInstance;

  @$pb.TagNumber(1)
  $3.SolanaAccountId get accountId => $_getN(0);
  @$pb.TagNumber(1)
  set accountId($3.SolanaAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
  @$pb.TagNumber(1)
  $3.SolanaAccountId ensureAccountId() => $_ensure(0);
}

class ResolveTokenAccountsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveTokenAccountsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..pc<$3.SolanaAccountId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tokenAccounts', $pb.PbFieldType.PM, subBuilder: $3.SolanaAccountId.create)
    ..hasRequiredFields = false
  ;

  ResolveTokenAccountsResponse._() : super();
  factory ResolveTokenAccountsResponse({
    $core.Iterable<$3.SolanaAccountId> tokenAccounts,
  }) {
    final _result = create();
    if (tokenAccounts != null) {
      _result.tokenAccounts.addAll(tokenAccounts);
    }
    return _result;
  }
  factory ResolveTokenAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveTokenAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveTokenAccountsResponse clone() => ResolveTokenAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveTokenAccountsResponse copyWith(void Function(ResolveTokenAccountsResponse) updates) => super.copyWith((message) => updates(message as ResolveTokenAccountsResponse)) as ResolveTokenAccountsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveTokenAccountsResponse create() => ResolveTokenAccountsResponse._();
  ResolveTokenAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveTokenAccountsResponse> createRepeated() => $pb.PbList<ResolveTokenAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveTokenAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveTokenAccountsResponse>(create);
  static ResolveTokenAccountsResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$3.SolanaAccountId> get tokenAccounts => $_getList(0);
}

class GetEventsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetEventsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..aOM<$3.SolanaAccountId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', subBuilder: $3.SolanaAccountId.create)
    ..hasRequiredFields = false
  ;

  GetEventsRequest._() : super();
  factory GetEventsRequest({
    $3.SolanaAccountId accountId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    return _result;
  }
  factory GetEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEventsRequest clone() => GetEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEventsRequest copyWith(void Function(GetEventsRequest) updates) => super.copyWith((message) => updates(message as GetEventsRequest)) as GetEventsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEventsRequest create() => GetEventsRequest._();
  GetEventsRequest createEmptyInstance() => create();
  static $pb.PbList<GetEventsRequest> createRepeated() => $pb.PbList<GetEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEventsRequest>(create);
  static GetEventsRequest _defaultInstance;

  @$pb.TagNumber(1)
  $3.SolanaAccountId get accountId => $_getN(0);
  @$pb.TagNumber(1)
  set accountId($3.SolanaAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
  @$pb.TagNumber(1)
  $3.SolanaAccountId ensureAccountId() => $_ensure(0);
}

class Events extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Events', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..e<Events_Result>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.OE, defaultOrMaker: Events_Result.OK, valueOf: Events_Result.valueOf, enumValues: Events_Result.values)
    ..pc<Event>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'events', $pb.PbFieldType.PM, subBuilder: Event.create)
    ..hasRequiredFields = false
  ;

  Events._() : super();
  factory Events({
    Events_Result result,
    $core.Iterable<Event> events,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (events != null) {
      _result.events.addAll(events);
    }
    return _result;
  }
  factory Events.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Events.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Events clone() => Events()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Events copyWith(void Function(Events) updates) => super.copyWith((message) => updates(message as Events)) as Events; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Events create() => Events._();
  Events createEmptyInstance() => create();
  static $pb.PbList<Events> createRepeated() => $pb.PbList<Events>();
  @$core.pragma('dart2js:noInline')
  static Events getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Events>(create);
  static Events _defaultInstance;

  @$pb.TagNumber(1)
  Events_Result get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(Events_Result v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Event> get events => $_getList(1);
}

enum Event_Type {
  accountUpdateEvent, 
  transactionEvent, 
  notSet
}

class Event extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Event_Type> _Event_TypeByTag = {
    1 : Event_Type.accountUpdateEvent,
    2 : Event_Type.transactionEvent,
    0 : Event_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Event', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<AccountUpdateEvent>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountUpdateEvent', subBuilder: AccountUpdateEvent.create)
    ..aOM<TransactionEvent>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionEvent', subBuilder: TransactionEvent.create)
    ..hasRequiredFields = false
  ;

  Event._() : super();
  factory Event({
    AccountUpdateEvent accountUpdateEvent,
    TransactionEvent transactionEvent,
  }) {
    final _result = create();
    if (accountUpdateEvent != null) {
      _result.accountUpdateEvent = accountUpdateEvent;
    }
    if (transactionEvent != null) {
      _result.transactionEvent = transactionEvent;
    }
    return _result;
  }
  factory Event.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Event.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Event clone() => Event()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Event copyWith(void Function(Event) updates) => super.copyWith((message) => updates(message as Event)) as Event; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  Event createEmptyInstance() => create();
  static $pb.PbList<Event> createRepeated() => $pb.PbList<Event>();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event _defaultInstance;

  Event_Type whichType() => _Event_TypeByTag[$_whichOneof(0)];
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  AccountUpdateEvent get accountUpdateEvent => $_getN(0);
  @$pb.TagNumber(1)
  set accountUpdateEvent(AccountUpdateEvent v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountUpdateEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountUpdateEvent() => clearField(1);
  @$pb.TagNumber(1)
  AccountUpdateEvent ensureAccountUpdateEvent() => $_ensure(0);

  @$pb.TagNumber(2)
  TransactionEvent get transactionEvent => $_getN(1);
  @$pb.TagNumber(2)
  set transactionEvent(TransactionEvent v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionEvent() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionEvent() => clearField(2);
  @$pb.TagNumber(2)
  TransactionEvent ensureTransactionEvent() => $_ensure(1);
}

class AccountUpdateEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AccountUpdateEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..aOM<AccountInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountInfo', subBuilder: AccountInfo.create)
    ..hasRequiredFields = false
  ;

  AccountUpdateEvent._() : super();
  factory AccountUpdateEvent({
    AccountInfo accountInfo,
  }) {
    final _result = create();
    if (accountInfo != null) {
      _result.accountInfo = accountInfo;
    }
    return _result;
  }
  factory AccountUpdateEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountUpdateEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountUpdateEvent clone() => AccountUpdateEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountUpdateEvent copyWith(void Function(AccountUpdateEvent) updates) => super.copyWith((message) => updates(message as AccountUpdateEvent)) as AccountUpdateEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AccountUpdateEvent create() => AccountUpdateEvent._();
  AccountUpdateEvent createEmptyInstance() => create();
  static $pb.PbList<AccountUpdateEvent> createRepeated() => $pb.PbList<AccountUpdateEvent>();
  @$core.pragma('dart2js:noInline')
  static AccountUpdateEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountUpdateEvent>(create);
  static AccountUpdateEvent _defaultInstance;

  @$pb.TagNumber(1)
  AccountInfo get accountInfo => $_getN(0);
  @$pb.TagNumber(1)
  set accountInfo(AccountInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountInfo() => clearField(1);
  @$pb.TagNumber(1)
  AccountInfo ensureAccountInfo() => $_ensure(0);
}

class TransactionEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.account.v4'), createEmptyInstance: create)
    ..aOM<$3.Transaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: $3.Transaction.create)
    ..aOM<$3.TransactionError>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionError', subBuilder: $3.TransactionError.create)
    ..hasRequiredFields = false
  ;

  TransactionEvent._() : super();
  factory TransactionEvent({
    $3.Transaction transaction,
    $3.TransactionError transactionError,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (transactionError != null) {
      _result.transactionError = transactionError;
    }
    return _result;
  }
  factory TransactionEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionEvent clone() => TransactionEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionEvent copyWith(void Function(TransactionEvent) updates) => super.copyWith((message) => updates(message as TransactionEvent)) as TransactionEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionEvent create() => TransactionEvent._();
  TransactionEvent createEmptyInstance() => create();
  static $pb.PbList<TransactionEvent> createRepeated() => $pb.PbList<TransactionEvent>();
  @$core.pragma('dart2js:noInline')
  static TransactionEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionEvent>(create);
  static TransactionEvent _defaultInstance;

  @$pb.TagNumber(1)
  $3.Transaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($3.Transaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  $3.Transaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $3.TransactionError get transactionError => $_getN(1);
  @$pb.TagNumber(2)
  set transactionError($3.TransactionError v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionError() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionError() => clearField(2);
  @$pb.TagNumber(2)
  $3.TransactionError ensureTransactionError() => $_ensure(1);
}

