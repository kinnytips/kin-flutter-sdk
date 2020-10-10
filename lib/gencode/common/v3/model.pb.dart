///
//  Generated code. Do not modify.
//  source: common/v3/model.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class StellarAccountId extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StellarAccountId', package: const $pb.PackageName('kin.agora.common.v3'), createEmptyInstance: create)
    ..aOS(1, 'value')
    ..hasRequiredFields = false
  ;

  StellarAccountId._() : super();
  factory StellarAccountId() => create();
  factory StellarAccountId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StellarAccountId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  StellarAccountId clone() => StellarAccountId()..mergeFromMessage(this);
  StellarAccountId copyWith(void Function(StellarAccountId) updates) => super.copyWith((message) => updates(message as StellarAccountId));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('TransactionHash', package: const $pb.PackageName('kin.agora.common.v3'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  TransactionHash._() : super();
  factory TransactionHash() => create();
  factory TransactionHash.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionHash.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  TransactionHash clone() => TransactionHash()..mergeFromMessage(this);
  TransactionHash copyWith(void Function(TransactionHash) updates) => super.copyWith((message) => updates(message as TransactionHash));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InvoiceHash', package: const $pb.PackageName('kin.agora.common.v3'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  InvoiceHash._() : super();
  factory InvoiceHash() => create();
  factory InvoiceHash.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceHash.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InvoiceHash clone() => InvoiceHash()..mergeFromMessage(this);
  InvoiceHash copyWith(void Function(InvoiceHash) updates) => super.copyWith((message) => updates(message as InvoiceHash));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Invoice.LineItem', package: const $pb.PackageName('kin.agora.common.v3'), createEmptyInstance: create)
    ..aOS(1, 'title')
    ..aOS(2, 'description')
    ..aInt64(3, 'amount')
    ..a<$core.List<$core.int>>(4, 'sku', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Invoice_LineItem._() : super();
  factory Invoice_LineItem() => create();
  factory Invoice_LineItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Invoice_LineItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Invoice_LineItem clone() => Invoice_LineItem()..mergeFromMessage(this);
  Invoice_LineItem copyWith(void Function(Invoice_LineItem) updates) => super.copyWith((message) => updates(message as Invoice_LineItem));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Invoice', package: const $pb.PackageName('kin.agora.common.v3'), createEmptyInstance: create)
    ..pc<Invoice_LineItem>(1, 'items', $pb.PbFieldType.PM, subBuilder: Invoice_LineItem.create)
    ..hasRequiredFields = false
  ;

  Invoice._() : super();
  factory Invoice() => create();
  factory Invoice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Invoice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Invoice clone() => Invoice()..mergeFromMessage(this);
  Invoice copyWith(void Function(Invoice) updates) => super.copyWith((message) => updates(message as Invoice));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InvoiceList', package: const $pb.PackageName('kin.agora.common.v3'), createEmptyInstance: create)
    ..pc<Invoice>(1, 'invoices', $pb.PbFieldType.PM, subBuilder: Invoice.create)
    ..hasRequiredFields = false
  ;

  InvoiceList._() : super();
  factory InvoiceList() => create();
  factory InvoiceList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InvoiceList clone() => InvoiceList()..mergeFromMessage(this);
  InvoiceList copyWith(void Function(InvoiceList) updates) => super.copyWith((message) => updates(message as InvoiceList));
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

