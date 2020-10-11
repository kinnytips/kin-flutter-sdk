///
//  Generated code. Do not modify.
//  source: account/v3/account_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../common/v3/model.pb.dart' as $3;

import 'account_service.pbenum.dart';

export 'account_service.pbenum.dart';

class AccountInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AccountInfo', package: const $pb.PackageName('kin.agora.account.v3'), createEmptyInstance: create)
    ..aOM<$3.StellarAccountId>(1, 'accountId', subBuilder: $3.StellarAccountId.create)
    ..aInt64(2, 'sequenceNumber')
    ..aInt64(3, 'balance')
    ..hasRequiredFields = false
  ;

  AccountInfo._() : super();
  factory AccountInfo() => create();
  factory AccountInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AccountInfo clone() => AccountInfo()..mergeFromMessage(this);
  AccountInfo copyWith(void Function(AccountInfo) updates) => super.copyWith((message) => updates(message as AccountInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AccountInfo create() => AccountInfo._();
  AccountInfo createEmptyInstance() => create();
  static $pb.PbList<AccountInfo> createRepeated() => $pb.PbList<AccountInfo>();
  @$core.pragma('dart2js:noInline')
  static AccountInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountInfo>(create);
  static AccountInfo _defaultInstance;

  @$pb.TagNumber(1)
  $3.StellarAccountId get accountId => $_getN(0);
  @$pb.TagNumber(1)
  set accountId($3.StellarAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
  @$pb.TagNumber(1)
  $3.StellarAccountId ensureAccountId() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sequenceNumber => $_getI64(1);
  @$pb.TagNumber(2)
  set sequenceNumber($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSequenceNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearSequenceNumber() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get balance => $_getI64(2);
  @$pb.TagNumber(3)
  set balance($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearBalance() => clearField(3);
}

class CreateAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CreateAccountRequest', package: const $pb.PackageName('kin.agora.account.v3'), createEmptyInstance: create)
    ..aOM<$3.StellarAccountId>(1, 'accountId', subBuilder: $3.StellarAccountId.create)
    ..hasRequiredFields = false
  ;

  CreateAccountRequest._() : super();
  factory CreateAccountRequest() => create();
  factory CreateAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CreateAccountRequest clone() => CreateAccountRequest()..mergeFromMessage(this);
  CreateAccountRequest copyWith(void Function(CreateAccountRequest) updates) => super.copyWith((message) => updates(message as CreateAccountRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateAccountRequest create() => CreateAccountRequest._();
  CreateAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAccountRequest> createRepeated() => $pb.PbList<CreateAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAccountRequest>(create);
  static CreateAccountRequest _defaultInstance;

  @$pb.TagNumber(1)
  $3.StellarAccountId get accountId => $_getN(0);
  @$pb.TagNumber(1)
  set accountId($3.StellarAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
  @$pb.TagNumber(1)
  $3.StellarAccountId ensureAccountId() => $_ensure(0);
}

class CreateAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CreateAccountResponse', package: const $pb.PackageName('kin.agora.account.v3'), createEmptyInstance: create)
    ..e<CreateAccountResponse_Result>(1, 'result', $pb.PbFieldType.OE, defaultOrMaker: CreateAccountResponse_Result.OK, valueOf: CreateAccountResponse_Result.valueOf, enumValues: CreateAccountResponse_Result.values)
    ..aOM<AccountInfo>(2, 'accountInfo', subBuilder: AccountInfo.create)
    ..hasRequiredFields = false
  ;

  CreateAccountResponse._() : super();
  factory CreateAccountResponse() => create();
  factory CreateAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CreateAccountResponse clone() => CreateAccountResponse()..mergeFromMessage(this);
  CreateAccountResponse copyWith(void Function(CreateAccountResponse) updates) => super.copyWith((message) => updates(message as CreateAccountResponse));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetAccountInfoRequest', package: const $pb.PackageName('kin.agora.account.v3'), createEmptyInstance: create)
    ..aOM<$3.StellarAccountId>(1, 'accountId', subBuilder: $3.StellarAccountId.create)
    ..hasRequiredFields = false
  ;

  GetAccountInfoRequest._() : super();
  factory GetAccountInfoRequest() => create();
  factory GetAccountInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetAccountInfoRequest clone() => GetAccountInfoRequest()..mergeFromMessage(this);
  GetAccountInfoRequest copyWith(void Function(GetAccountInfoRequest) updates) => super.copyWith((message) => updates(message as GetAccountInfoRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoRequest create() => GetAccountInfoRequest._();
  GetAccountInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountInfoRequest> createRepeated() => $pb.PbList<GetAccountInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountInfoRequest>(create);
  static GetAccountInfoRequest _defaultInstance;

  @$pb.TagNumber(1)
  $3.StellarAccountId get accountId => $_getN(0);
  @$pb.TagNumber(1)
  set accountId($3.StellarAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
  @$pb.TagNumber(1)
  $3.StellarAccountId ensureAccountId() => $_ensure(0);
}

class GetAccountInfoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetAccountInfoResponse', package: const $pb.PackageName('kin.agora.account.v3'), createEmptyInstance: create)
    ..e<GetAccountInfoResponse_Result>(1, 'result', $pb.PbFieldType.OE, defaultOrMaker: GetAccountInfoResponse_Result.OK, valueOf: GetAccountInfoResponse_Result.valueOf, enumValues: GetAccountInfoResponse_Result.values)
    ..aOM<AccountInfo>(2, 'accountInfo', subBuilder: AccountInfo.create)
    ..hasRequiredFields = false
  ;

  GetAccountInfoResponse._() : super();
  factory GetAccountInfoResponse() => create();
  factory GetAccountInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetAccountInfoResponse clone() => GetAccountInfoResponse()..mergeFromMessage(this);
  GetAccountInfoResponse copyWith(void Function(GetAccountInfoResponse) updates) => super.copyWith((message) => updates(message as GetAccountInfoResponse));
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

class GetEventsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetEventsRequest', package: const $pb.PackageName('kin.agora.account.v3'), createEmptyInstance: create)
    ..aOM<$3.StellarAccountId>(1, 'accountId', subBuilder: $3.StellarAccountId.create)
    ..hasRequiredFields = false
  ;

  GetEventsRequest._() : super();
  factory GetEventsRequest() => create();
  factory GetEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetEventsRequest clone() => GetEventsRequest()..mergeFromMessage(this);
  GetEventsRequest copyWith(void Function(GetEventsRequest) updates) => super.copyWith((message) => updates(message as GetEventsRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEventsRequest create() => GetEventsRequest._();
  GetEventsRequest createEmptyInstance() => create();
  static $pb.PbList<GetEventsRequest> createRepeated() => $pb.PbList<GetEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEventsRequest>(create);
  static GetEventsRequest _defaultInstance;

  @$pb.TagNumber(1)
  $3.StellarAccountId get accountId => $_getN(0);
  @$pb.TagNumber(1)
  set accountId($3.StellarAccountId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
  @$pb.TagNumber(1)
  $3.StellarAccountId ensureAccountId() => $_ensure(0);
}

class Events extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Events', package: const $pb.PackageName('kin.agora.account.v3'), createEmptyInstance: create)
    ..e<Events_Result>(1, 'result', $pb.PbFieldType.OE, defaultOrMaker: Events_Result.OK, valueOf: Events_Result.valueOf, enumValues: Events_Result.values)
    ..pc<Event>(2, 'events', $pb.PbFieldType.PM, subBuilder: Event.create)
    ..hasRequiredFields = false
  ;

  Events._() : super();
  factory Events() => create();
  factory Events.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Events.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Events clone() => Events()..mergeFromMessage(this);
  Events copyWith(void Function(Events) updates) => super.copyWith((message) => updates(message as Events));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Event', package: const $pb.PackageName('kin.agora.account.v3'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<AccountUpdateEvent>(1, 'accountUpdateEvent', subBuilder: AccountUpdateEvent.create)
    ..aOM<TransactionEvent>(2, 'transactionEvent', subBuilder: TransactionEvent.create)
    ..hasRequiredFields = false
  ;

  Event._() : super();
  factory Event() => create();
  factory Event.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Event.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Event clone() => Event()..mergeFromMessage(this);
  Event copyWith(void Function(Event) updates) => super.copyWith((message) => updates(message as Event));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AccountUpdateEvent', package: const $pb.PackageName('kin.agora.account.v3'), createEmptyInstance: create)
    ..aOM<AccountInfo>(1, 'accountInfo', subBuilder: AccountInfo.create)
    ..hasRequiredFields = false
  ;

  AccountUpdateEvent._() : super();
  factory AccountUpdateEvent() => create();
  factory AccountUpdateEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountUpdateEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AccountUpdateEvent clone() => AccountUpdateEvent()..mergeFromMessage(this);
  AccountUpdateEvent copyWith(void Function(AccountUpdateEvent) updates) => super.copyWith((message) => updates(message as AccountUpdateEvent));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('TransactionEvent', package: const $pb.PackageName('kin.agora.account.v3'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, 'envelopeXdr', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, 'resultXdr', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  TransactionEvent._() : super();
  factory TransactionEvent() => create();
  factory TransactionEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  TransactionEvent clone() => TransactionEvent()..mergeFromMessage(this);
  TransactionEvent copyWith(void Function(TransactionEvent) updates) => super.copyWith((message) => updates(message as TransactionEvent));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionEvent create() => TransactionEvent._();
  TransactionEvent createEmptyInstance() => create();
  static $pb.PbList<TransactionEvent> createRepeated() => $pb.PbList<TransactionEvent>();
  @$core.pragma('dart2js:noInline')
  static TransactionEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionEvent>(create);
  static TransactionEvent _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get envelopeXdr => $_getN(0);
  @$pb.TagNumber(1)
  set envelopeXdr($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEnvelopeXdr() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnvelopeXdr() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get resultXdr => $_getN(1);
  @$pb.TagNumber(2)
  set resultXdr($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasResultXdr() => $_has(1);
  @$pb.TagNumber(2)
  void clearResultXdr() => clearField(2);
}

