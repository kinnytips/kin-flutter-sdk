///
//  Generated code. Do not modify.
//  source: storage.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'storage.pbenum.dart';

export 'storage.pbenum.dart';

class PrivateKey extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PrivateKey', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.storage.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  PrivateKey._() : super();
  factory PrivateKey({
    $core.List<$core.int>? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory PrivateKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PrivateKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PrivateKey clone() => PrivateKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PrivateKey copyWith(void Function(PrivateKey) updates) => super.copyWith((message) => updates(message as PrivateKey)) as PrivateKey; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PrivateKey create() => PrivateKey._();
  PrivateKey createEmptyInstance() => create();
  static $pb.PbList<PrivateKey> createRepeated() => $pb.PbList<PrivateKey>();
  @$core.pragma('dart2js:noInline')
  static PrivateKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PrivateKey>(create);
  static PrivateKey? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class PublicKey extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PublicKey', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.storage.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  PublicKey._() : super();
  factory PublicKey({
    $core.List<$core.int>? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory PublicKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PublicKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PublicKey clone() => PublicKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PublicKey copyWith(void Function(PublicKey) updates) => super.copyWith((message) => updates(message as PublicKey)) as PublicKey; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PublicKey create() => PublicKey._();
  PublicKey createEmptyInstance() => create();
  static $pb.PbList<PublicKey> createRepeated() => $pb.PbList<PublicKey>();
  @$core.pragma('dart2js:noInline')
  static PublicKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicKey>(create);
  static PublicKey? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class KinBalance extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KinBalance', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.storage.v1'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quarkAmount')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingQuarkAmount')
    ..hasRequiredFields = false
  ;

  KinBalance._() : super();
  factory KinBalance({
    $fixnum.Int64? quarkAmount,
    $fixnum.Int64? pendingQuarkAmount,
  }) {
    final _result = create();
    if (quarkAmount != null) {
      _result.quarkAmount = quarkAmount;
    }
    if (pendingQuarkAmount != null) {
      _result.pendingQuarkAmount = pendingQuarkAmount;
    }
    return _result;
  }
  factory KinBalance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KinBalance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KinBalance clone() => KinBalance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KinBalance copyWith(void Function(KinBalance) updates) => super.copyWith((message) => updates(message as KinBalance)) as KinBalance; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KinBalance create() => KinBalance._();
  KinBalance createEmptyInstance() => create();
  static $pb.PbList<KinBalance> createRepeated() => $pb.PbList<KinBalance>();
  @$core.pragma('dart2js:noInline')
  static KinBalance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KinBalance>(create);
  static KinBalance? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get quarkAmount => $_getI64(0);
  @$pb.TagNumber(1)
  set quarkAmount($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuarkAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuarkAmount() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pendingQuarkAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set pendingQuarkAmount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPendingQuarkAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingQuarkAmount() => clearField(2);
}

class KinAccount extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KinAccount', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.storage.v1'), createEmptyInstance: create)
    ..aOM<PublicKey>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicKey', subBuilder: PublicKey.create)
    ..aOM<PrivateKey>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'privateKey', subBuilder: PrivateKey.create)
    ..aOM<KinBalance>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', subBuilder: KinBalance.create)
    ..e<KinAccount_Status>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KinAccount_Status.UNREGISTERED, valueOf: KinAccount_Status.valueOf, enumValues: KinAccount_Status.values)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceNumber')
    ..pc<PublicKey>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: PublicKey.create)
    ..hasRequiredFields = false
  ;

  KinAccount._() : super();
  factory KinAccount({
    PublicKey? publicKey,
    PrivateKey? privateKey,
    KinBalance? balance,
    KinAccount_Status? status,
    $fixnum.Int64? sequenceNumber,
    $core.Iterable<PublicKey>? accounts,
  }) {
    final _result = create();
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    if (privateKey != null) {
      _result.privateKey = privateKey;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (status != null) {
      _result.status = status;
    }
    if (sequenceNumber != null) {
      _result.sequenceNumber = sequenceNumber;
    }
    if (accounts != null) {
      _result.accounts.addAll(accounts);
    }
    return _result;
  }
  factory KinAccount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KinAccount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KinAccount clone() => KinAccount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KinAccount copyWith(void Function(KinAccount) updates) => super.copyWith((message) => updates(message as KinAccount)) as KinAccount; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KinAccount create() => KinAccount._();
  KinAccount createEmptyInstance() => create();
  static $pb.PbList<KinAccount> createRepeated() => $pb.PbList<KinAccount>();
  @$core.pragma('dart2js:noInline')
  static KinAccount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KinAccount>(create);
  static KinAccount? _defaultInstance;

  @$pb.TagNumber(1)
  PublicKey get publicKey => $_getN(0);
  @$pb.TagNumber(1)
  set publicKey(PublicKey v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPublicKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicKey() => clearField(1);
  @$pb.TagNumber(1)
  PublicKey ensurePublicKey() => $_ensure(0);

  @$pb.TagNumber(2)
  PrivateKey get privateKey => $_getN(1);
  @$pb.TagNumber(2)
  set privateKey(PrivateKey v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPrivateKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrivateKey() => clearField(2);
  @$pb.TagNumber(2)
  PrivateKey ensurePrivateKey() => $_ensure(1);

  @$pb.TagNumber(3)
  KinBalance get balance => $_getN(2);
  @$pb.TagNumber(3)
  set balance(KinBalance v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearBalance() => clearField(3);
  @$pb.TagNumber(3)
  KinBalance ensureBalance() => $_ensure(2);

  @$pb.TagNumber(4)
  KinAccount_Status get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(KinAccount_Status v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get sequenceNumber => $_getI64(4);
  @$pb.TagNumber(5)
  set sequenceNumber($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSequenceNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearSequenceNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<PublicKey> get accounts => $_getList(5);
}

class KinTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KinTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.storage.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'envelopeXdr', $pb.PbFieldType.OY)
    ..e<KinTransaction_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: KinTransaction_Status.UNKNOWN, valueOf: KinTransaction_Status.valueOf, enumValues: KinTransaction_Status.values)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resultXdr', $pb.PbFieldType.OY)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagingToken')
    ..hasRequiredFields = false
  ;

  KinTransaction._() : super();
  factory KinTransaction({
    $core.List<$core.int>? envelopeXdr,
    KinTransaction_Status? status,
    $fixnum.Int64? timestamp,
    $core.List<$core.int>? resultXdr,
    $core.String? pagingToken,
  }) {
    final _result = create();
    if (envelopeXdr != null) {
      _result.envelopeXdr = envelopeXdr;
    }
    if (status != null) {
      _result.status = status;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (resultXdr != null) {
      _result.resultXdr = resultXdr;
    }
    if (pagingToken != null) {
      _result.pagingToken = pagingToken;
    }
    return _result;
  }
  factory KinTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KinTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KinTransaction clone() => KinTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KinTransaction copyWith(void Function(KinTransaction) updates) => super.copyWith((message) => updates(message as KinTransaction)) as KinTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KinTransaction create() => KinTransaction._();
  KinTransaction createEmptyInstance() => create();
  static $pb.PbList<KinTransaction> createRepeated() => $pb.PbList<KinTransaction>();
  @$core.pragma('dart2js:noInline')
  static KinTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KinTransaction>(create);
  static KinTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get envelopeXdr => $_getN(0);
  @$pb.TagNumber(1)
  set envelopeXdr($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEnvelopeXdr() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnvelopeXdr() => clearField(1);

  @$pb.TagNumber(2)
  KinTransaction_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(KinTransaction_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get timestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set timestamp($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get resultXdr => $_getN(3);
  @$pb.TagNumber(4)
  set resultXdr($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResultXdr() => $_has(3);
  @$pb.TagNumber(4)
  void clearResultXdr() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get pagingToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set pagingToken($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPagingToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearPagingToken() => clearField(5);
}

class KinTransactions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KinTransactions', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.storage.v1'), createEmptyInstance: create)
    ..pc<KinTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: KinTransaction.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'headPagingToken')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tailPagingToken')
    ..hasRequiredFields = false
  ;

  KinTransactions._() : super();
  factory KinTransactions({
    $core.Iterable<KinTransaction>? items,
    $core.String? headPagingToken,
    $core.String? tailPagingToken,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    if (headPagingToken != null) {
      _result.headPagingToken = headPagingToken;
    }
    if (tailPagingToken != null) {
      _result.tailPagingToken = tailPagingToken;
    }
    return _result;
  }
  factory KinTransactions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KinTransactions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KinTransactions clone() => KinTransactions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KinTransactions copyWith(void Function(KinTransactions) updates) => super.copyWith((message) => updates(message as KinTransactions)) as KinTransactions; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KinTransactions create() => KinTransactions._();
  KinTransactions createEmptyInstance() => create();
  static $pb.PbList<KinTransactions> createRepeated() => $pb.PbList<KinTransactions>();
  @$core.pragma('dart2js:noInline')
  static KinTransactions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KinTransactions>(create);
  static KinTransactions? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<KinTransaction> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get headPagingToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set headPagingToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeadPagingToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeadPagingToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get tailPagingToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set tailPagingToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTailPagingToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearTailPagingToken() => clearField(3);
}

class InvoiceListBlob extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvoiceListBlob', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.storage.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'networkInvoiceList', $pb.PbFieldType.OY, protoName: 'networkInvoiceList')
    ..hasRequiredFields = false
  ;

  InvoiceListBlob._() : super();
  factory InvoiceListBlob({
    $core.List<$core.int>? networkInvoiceList,
  }) {
    final _result = create();
    if (networkInvoiceList != null) {
      _result.networkInvoiceList = networkInvoiceList;
    }
    return _result;
  }
  factory InvoiceListBlob.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceListBlob.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceListBlob clone() => InvoiceListBlob()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceListBlob copyWith(void Function(InvoiceListBlob) updates) => super.copyWith((message) => updates(message as InvoiceListBlob)) as InvoiceListBlob; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InvoiceListBlob create() => InvoiceListBlob._();
  InvoiceListBlob createEmptyInstance() => create();
  static $pb.PbList<InvoiceListBlob> createRepeated() => $pb.PbList<InvoiceListBlob>();
  @$core.pragma('dart2js:noInline')
  static InvoiceListBlob getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceListBlob>(create);
  static InvoiceListBlob? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get networkInvoiceList => $_getN(0);
  @$pb.TagNumber(1)
  set networkInvoiceList($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNetworkInvoiceList() => $_has(0);
  @$pb.TagNumber(1)
  void clearNetworkInvoiceList() => clearField(1);
}

class Invoices extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Invoices', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.storage.v1'), createEmptyInstance: create)
    ..m<$core.String, InvoiceListBlob>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceLists', protoName: 'invoiceLists', entryClassName: 'Invoices.InvoiceListsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: InvoiceListBlob.create, packageName: const $pb.PackageName('kin.storage.v1'))
    ..hasRequiredFields = false
  ;

  Invoices._() : super();
  factory Invoices({
    $core.Map<$core.String, InvoiceListBlob>? invoiceLists,
  }) {
    final _result = create();
    if (invoiceLists != null) {
      _result.invoiceLists.addAll(invoiceLists);
    }
    return _result;
  }
  factory Invoices.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Invoices.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Invoices clone() => Invoices()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Invoices copyWith(void Function(Invoices) updates) => super.copyWith((message) => updates(message as Invoices)) as Invoices; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Invoices create() => Invoices._();
  Invoices createEmptyInstance() => create();
  static $pb.PbList<Invoices> createRepeated() => $pb.PbList<Invoices>();
  @$core.pragma('dart2js:noInline')
  static Invoices getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Invoices>(create);
  static Invoices? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, InvoiceListBlob> get invoiceLists => $_getMap(0);
}

class KinConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KinConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.storage.v1'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minFee')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cid')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minApiVersion', protoName: 'minApiVersion')
    ..hasRequiredFields = false
  ;

  KinConfig._() : super();
  factory KinConfig({
    $fixnum.Int64? minFee,
    $core.String? cid,
    $fixnum.Int64? minApiVersion,
  }) {
    final _result = create();
    if (minFee != null) {
      _result.minFee = minFee;
    }
    if (cid != null) {
      _result.cid = cid;
    }
    if (minApiVersion != null) {
      _result.minApiVersion = minApiVersion;
    }
    return _result;
  }
  factory KinConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KinConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KinConfig clone() => KinConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KinConfig copyWith(void Function(KinConfig) updates) => super.copyWith((message) => updates(message as KinConfig)) as KinConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KinConfig create() => KinConfig._();
  KinConfig createEmptyInstance() => create();
  static $pb.PbList<KinConfig> createRepeated() => $pb.PbList<KinConfig>();
  @$core.pragma('dart2js:noInline')
  static KinConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KinConfig>(create);
  static KinConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get minFee => $_getI64(0);
  @$pb.TagNumber(1)
  set minFee($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMinFee() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinFee() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cid => $_getSZ(1);
  @$pb.TagNumber(2)
  set cid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCid() => $_has(1);
  @$pb.TagNumber(2)
  void clearCid() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get minApiVersion => $_getI64(2);
  @$pb.TagNumber(3)
  set minApiVersion($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinApiVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinApiVersion() => clearField(3);
}

