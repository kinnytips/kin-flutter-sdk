///
//  Generated code. Do not modify.
//  source: common/v3/model.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'model.pbenum.dart';

export 'model.pbenum.dart';

class StellarAccountId extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StellarAccountId', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.common.v3'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..hasRequiredFields = false
  ;

  StellarAccountId._() : super();
  factory StellarAccountId({
    $core.String value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory StellarAccountId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StellarAccountId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StellarAccountId clone() => StellarAccountId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StellarAccountId copyWith(void Function(StellarAccountId) updates) => super.copyWith((message) => updates(message as StellarAccountId)) as StellarAccountId; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StellarAccountId create() => StellarAccountId._();
  StellarAccountId createEmptyInstance() => create();
  static $pb.PbList<StellarAccountId> createRepeated() => $pb.PbList<StellarAccountId>();
  @$core.pragma('dart2js:noInline')
  static StellarAccountId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StellarAccountId>(create);
  static StellarAccountId _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class TransactionHash extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionHash', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.common.v3'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  TransactionHash._() : super();
  factory TransactionHash({
    $core.List<$core.int> value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory TransactionHash.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionHash.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionHash clone() => TransactionHash()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionHash copyWith(void Function(TransactionHash) updates) => super.copyWith((message) => updates(message as TransactionHash)) as TransactionHash; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionHash create() => TransactionHash._();
  TransactionHash createEmptyInstance() => create();
  static $pb.PbList<TransactionHash> createRepeated() => $pb.PbList<TransactionHash>();
  @$core.pragma('dart2js:noInline')
  static TransactionHash getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionHash>(create);
  static TransactionHash _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class InvoiceHash extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvoiceHash', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.common.v3'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  InvoiceHash._() : super();
  factory InvoiceHash({
    $core.List<$core.int> value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory InvoiceHash.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceHash.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceHash clone() => InvoiceHash()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceHash copyWith(void Function(InvoiceHash) updates) => super.copyWith((message) => updates(message as InvoiceHash)) as InvoiceHash; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InvoiceHash create() => InvoiceHash._();
  InvoiceHash createEmptyInstance() => create();
  static $pb.PbList<InvoiceHash> createRepeated() => $pb.PbList<InvoiceHash>();
  @$core.pragma('dart2js:noInline')
  static InvoiceHash getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceHash>(create);
  static InvoiceHash _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class Invoice_LineItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Invoice.LineItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.common.v3'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sku', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Invoice_LineItem._() : super();
  factory Invoice_LineItem({
    $core.String title,
    $core.String description,
    $fixnum.Int64 amount,
    $core.List<$core.int> sku,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (sku != null) {
      _result.sku = sku;
    }
    return _result;
  }
  factory Invoice_LineItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Invoice_LineItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Invoice_LineItem clone() => Invoice_LineItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Invoice_LineItem copyWith(void Function(Invoice_LineItem) updates) => super.copyWith((message) => updates(message as Invoice_LineItem)) as Invoice_LineItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Invoice_LineItem create() => Invoice_LineItem._();
  Invoice_LineItem createEmptyInstance() => create();
  static $pb.PbList<Invoice_LineItem> createRepeated() => $pb.PbList<Invoice_LineItem>();
  @$core.pragma('dart2js:noInline')
  static Invoice_LineItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Invoice_LineItem>(create);
  static Invoice_LineItem _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get sku => $_getN(3);
  @$pb.TagNumber(4)
  set sku($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSku() => $_has(3);
  @$pb.TagNumber(4)
  void clearSku() => clearField(4);
}

class Invoice extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Invoice', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.common.v3'), createEmptyInstance: create)
    ..pc<Invoice_LineItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: Invoice_LineItem.create)
    ..hasRequiredFields = false
  ;

  Invoice._() : super();
  factory Invoice({
    $core.Iterable<Invoice_LineItem> items,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory Invoice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Invoice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Invoice clone() => Invoice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Invoice copyWith(void Function(Invoice) updates) => super.copyWith((message) => updates(message as Invoice)) as Invoice; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Invoice create() => Invoice._();
  Invoice createEmptyInstance() => create();
  static $pb.PbList<Invoice> createRepeated() => $pb.PbList<Invoice>();
  @$core.pragma('dart2js:noInline')
  static Invoice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Invoice>(create);
  static Invoice _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Invoice_LineItem> get items => $_getList(0);
}

class InvoiceList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvoiceList', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.common.v3'), createEmptyInstance: create)
    ..pc<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: Invoice.create)
    ..hasRequiredFields = false
  ;

  InvoiceList._() : super();
  factory InvoiceList({
    $core.Iterable<Invoice> invoices,
  }) {
    final _result = create();
    if (invoices != null) {
      _result.invoices.addAll(invoices);
    }
    return _result;
  }
  factory InvoiceList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceList clone() => InvoiceList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceList copyWith(void Function(InvoiceList) updates) => super.copyWith((message) => updates(message as InvoiceList)) as InvoiceList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InvoiceList create() => InvoiceList._();
  InvoiceList createEmptyInstance() => create();
  static $pb.PbList<InvoiceList> createRepeated() => $pb.PbList<InvoiceList>();
  @$core.pragma('dart2js:noInline')
  static InvoiceList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceList>(create);
  static InvoiceList _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Invoice> get invoices => $_getList(0);
}

class InvoiceError extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvoiceError', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.common.v3'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'opIndex', $pb.PbFieldType.OU3)
    ..aOM<Invoice>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: Invoice.create)
    ..e<InvoiceError_Reason>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason', $pb.PbFieldType.OE, defaultOrMaker: InvoiceError_Reason.UNKNOWN, valueOf: InvoiceError_Reason.valueOf, enumValues: InvoiceError_Reason.values)
    ..hasRequiredFields = false
  ;

  InvoiceError._() : super();
  factory InvoiceError({
    $core.int opIndex,
    Invoice invoice,
    InvoiceError_Reason reason,
  }) {
    final _result = create();
    if (opIndex != null) {
      _result.opIndex = opIndex;
    }
    if (invoice != null) {
      _result.invoice = invoice;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory InvoiceError.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceError.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceError clone() => InvoiceError()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceError copyWith(void Function(InvoiceError) updates) => super.copyWith((message) => updates(message as InvoiceError)) as InvoiceError; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InvoiceError create() => InvoiceError._();
  InvoiceError createEmptyInstance() => create();
  static $pb.PbList<InvoiceError> createRepeated() => $pb.PbList<InvoiceError>();
  @$core.pragma('dart2js:noInline')
  static InvoiceError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceError>(create);
  static InvoiceError _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get opIndex => $_getIZ(0);
  @$pb.TagNumber(1)
  set opIndex($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOpIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearOpIndex() => clearField(1);

  @$pb.TagNumber(2)
  Invoice get invoice => $_getN(1);
  @$pb.TagNumber(2)
  set invoice(Invoice v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvoice() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoice() => clearField(2);
  @$pb.TagNumber(2)
  Invoice ensureInvoice() => $_ensure(1);

  @$pb.TagNumber(3)
  InvoiceError_Reason get reason => $_getN(2);
  @$pb.TagNumber(3)
  set reason(InvoiceError_Reason v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}

