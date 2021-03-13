///
//  Generated code. Do not modify.
//  source: transaction/v3/transaction_service.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../common/v3/model.pb.dart' as $3;

import 'transaction_service.pbenum.dart';

export 'transaction_service.pbenum.dart';

class GetHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v3'), createEmptyInstance: create)
    ..aOM<$3.StellarAccountId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', subBuilder: $3.StellarAccountId.create)
    ..aOM<Cursor>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cursor', subBuilder: Cursor.create)
    ..e<GetHistoryRequest_Direction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: GetHistoryRequest_Direction.ASC, valueOf: GetHistoryRequest_Direction.valueOf, enumValues: GetHistoryRequest_Direction.values)
    ..hasRequiredFields = false
  ;

  GetHistoryRequest._() : super();
  factory GetHistoryRequest({
    $3.StellarAccountId accountId,
    Cursor cursor,
    GetHistoryRequest_Direction direction,
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
  static GetHistoryRequest _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v3'), createEmptyInstance: create)
    ..e<GetHistoryResponse_Result>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.OE, defaultOrMaker: GetHistoryResponse_Result.OK, valueOf: GetHistoryResponse_Result.valueOf, enumValues: GetHistoryResponse_Result.values)
    ..pc<HistoryItem>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: HistoryItem.create)
    ..hasRequiredFields = false
  ;

  GetHistoryResponse._() : super();
  factory GetHistoryResponse({
    GetHistoryResponse_Result result,
    $core.Iterable<HistoryItem> items,
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
  static GetHistoryResponse _defaultInstance;

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

class SubmitTransactionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitTransactionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v3'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'envelopeXdr', $pb.PbFieldType.OY)
    ..aOM<$3.InvoiceList>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceList', subBuilder: $3.InvoiceList.create)
    ..hasRequiredFields = false
  ;

  SubmitTransactionRequest._() : super();
  factory SubmitTransactionRequest({
    $core.List<$core.int> envelopeXdr,
    $3.InvoiceList invoiceList,
  }) {
    final _result = create();
    if (envelopeXdr != null) {
      _result.envelopeXdr = envelopeXdr;
    }
    if (invoiceList != null) {
      _result.invoiceList = invoiceList;
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
  static SubmitTransactionRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get envelopeXdr => $_getN(0);
  @$pb.TagNumber(1)
  set envelopeXdr($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEnvelopeXdr() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnvelopeXdr() => clearField(1);

  @$pb.TagNumber(2)
  $3.InvoiceList get invoiceList => $_getN(1);
  @$pb.TagNumber(2)
  set invoiceList($3.InvoiceList v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvoiceList() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceList() => clearField(2);
  @$pb.TagNumber(2)
  $3.InvoiceList ensureInvoiceList() => $_ensure(1);
}

class SubmitTransactionResponse_InvoiceError extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitTransactionResponse.InvoiceError', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v3'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'opIndex', $pb.PbFieldType.OU3)
    ..aOM<$3.Invoice>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: $3.Invoice.create)
    ..e<SubmitTransactionResponse_InvoiceError_Reason>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason', $pb.PbFieldType.OE, defaultOrMaker: SubmitTransactionResponse_InvoiceError_Reason.UNKNOWN, valueOf: SubmitTransactionResponse_InvoiceError_Reason.valueOf, enumValues: SubmitTransactionResponse_InvoiceError_Reason.values)
    ..hasRequiredFields = false
  ;

  SubmitTransactionResponse_InvoiceError._() : super();
  factory SubmitTransactionResponse_InvoiceError({
    $core.int opIndex,
    $3.Invoice invoice,
    SubmitTransactionResponse_InvoiceError_Reason reason,
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
  factory SubmitTransactionResponse_InvoiceError.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitTransactionResponse_InvoiceError.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitTransactionResponse_InvoiceError clone() => SubmitTransactionResponse_InvoiceError()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitTransactionResponse_InvoiceError copyWith(void Function(SubmitTransactionResponse_InvoiceError) updates) => super.copyWith((message) => updates(message as SubmitTransactionResponse_InvoiceError)) as SubmitTransactionResponse_InvoiceError; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubmitTransactionResponse_InvoiceError create() => SubmitTransactionResponse_InvoiceError._();
  SubmitTransactionResponse_InvoiceError createEmptyInstance() => create();
  static $pb.PbList<SubmitTransactionResponse_InvoiceError> createRepeated() => $pb.PbList<SubmitTransactionResponse_InvoiceError>();
  @$core.pragma('dart2js:noInline')
  static SubmitTransactionResponse_InvoiceError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubmitTransactionResponse_InvoiceError>(create);
  static SubmitTransactionResponse_InvoiceError _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get opIndex => $_getIZ(0);
  @$pb.TagNumber(1)
  set opIndex($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOpIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearOpIndex() => clearField(1);

  @$pb.TagNumber(2)
  $3.Invoice get invoice => $_getN(1);
  @$pb.TagNumber(2)
  set invoice($3.Invoice v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvoice() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoice() => clearField(2);
  @$pb.TagNumber(2)
  $3.Invoice ensureInvoice() => $_ensure(1);

  @$pb.TagNumber(3)
  SubmitTransactionResponse_InvoiceError_Reason get reason => $_getN(2);
  @$pb.TagNumber(3)
  set reason(SubmitTransactionResponse_InvoiceError_Reason v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}

class SubmitTransactionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitTransactionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v3'), createEmptyInstance: create)
    ..e<SubmitTransactionResponse_Result>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.OE, defaultOrMaker: SubmitTransactionResponse_Result.OK, valueOf: SubmitTransactionResponse_Result.valueOf, enumValues: SubmitTransactionResponse_Result.values)
    ..pc<SubmitTransactionResponse_InvoiceError>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceErrors', $pb.PbFieldType.PM, subBuilder: SubmitTransactionResponse_InvoiceError.create)
    ..aOM<$3.TransactionHash>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hash', subBuilder: $3.TransactionHash.create)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ledger')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resultXdr', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  SubmitTransactionResponse._() : super();
  factory SubmitTransactionResponse({
    SubmitTransactionResponse_Result result,
    $core.Iterable<SubmitTransactionResponse_InvoiceError> invoiceErrors,
    $3.TransactionHash hash,
    $fixnum.Int64 ledger,
    $core.List<$core.int> resultXdr,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (invoiceErrors != null) {
      _result.invoiceErrors.addAll(invoiceErrors);
    }
    if (hash != null) {
      _result.hash = hash;
    }
    if (ledger != null) {
      _result.ledger = ledger;
    }
    if (resultXdr != null) {
      _result.resultXdr = resultXdr;
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
  static SubmitTransactionResponse _defaultInstance;

  @$pb.TagNumber(1)
  SubmitTransactionResponse_Result get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(SubmitTransactionResponse_Result v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<SubmitTransactionResponse_InvoiceError> get invoiceErrors => $_getList(1);

  @$pb.TagNumber(3)
  $3.TransactionHash get hash => $_getN(2);
  @$pb.TagNumber(3)
  set hash($3.TransactionHash v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearHash() => clearField(3);
  @$pb.TagNumber(3)
  $3.TransactionHash ensureHash() => $_ensure(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get ledger => $_getI64(3);
  @$pb.TagNumber(4)
  set ledger($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLedger() => $_has(3);
  @$pb.TagNumber(4)
  void clearLedger() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get resultXdr => $_getN(4);
  @$pb.TagNumber(5)
  set resultXdr($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasResultXdr() => $_has(4);
  @$pb.TagNumber(5)
  void clearResultXdr() => clearField(5);
}

class GetTransactionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransactionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v3'), createEmptyInstance: create)
    ..aOM<$3.TransactionHash>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionHash', subBuilder: $3.TransactionHash.create)
    ..hasRequiredFields = false
  ;

  GetTransactionRequest._() : super();
  factory GetTransactionRequest({
    $3.TransactionHash transactionHash,
  }) {
    final _result = create();
    if (transactionHash != null) {
      _result.transactionHash = transactionHash;
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
  static GetTransactionRequest _defaultInstance;

  @$pb.TagNumber(1)
  $3.TransactionHash get transactionHash => $_getN(0);
  @$pb.TagNumber(1)
  set transactionHash($3.TransactionHash v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionHash() => clearField(1);
  @$pb.TagNumber(1)
  $3.TransactionHash ensureTransactionHash() => $_ensure(0);
}

class GetTransactionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransactionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v3'), createEmptyInstance: create)
    ..e<GetTransactionResponse_State>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: GetTransactionResponse_State.UNKNOWN, valueOf: GetTransactionResponse_State.valueOf, enumValues: GetTransactionResponse_State.values)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ledger')
    ..aOM<HistoryItem>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', subBuilder: HistoryItem.create)
    ..hasRequiredFields = false
  ;

  GetTransactionResponse._() : super();
  factory GetTransactionResponse({
    GetTransactionResponse_State state,
    $fixnum.Int64 ledger,
    HistoryItem item,
  }) {
    final _result = create();
    if (state != null) {
      _result.state = state;
    }
    if (ledger != null) {
      _result.ledger = ledger;
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
  static GetTransactionResponse _defaultInstance;

  @$pb.TagNumber(1)
  GetTransactionResponse_State get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(GetTransactionResponse_State v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get ledger => $_getI64(1);
  @$pb.TagNumber(2)
  set ledger($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLedger() => $_has(1);
  @$pb.TagNumber(2)
  void clearLedger() => clearField(2);

  @$pb.TagNumber(3)
  HistoryItem get item => $_getN(2);
  @$pb.TagNumber(3)
  set item(HistoryItem v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasItem() => $_has(2);
  @$pb.TagNumber(3)
  void clearItem() => clearField(3);
  @$pb.TagNumber(3)
  HistoryItem ensureItem() => $_ensure(2);
}

class HistoryItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HistoryItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v3'), createEmptyInstance: create)
    ..aOM<$3.TransactionHash>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hash', subBuilder: $3.TransactionHash.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resultXdr', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'envelopeXdr', $pb.PbFieldType.OY)
    ..aOM<Cursor>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cursor', subBuilder: Cursor.create)
    ..aOM<$3.InvoiceList>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceList', subBuilder: $3.InvoiceList.create)
    ..hasRequiredFields = false
  ;

  HistoryItem._() : super();
  factory HistoryItem({
    $3.TransactionHash hash,
    $core.List<$core.int> resultXdr,
    $core.List<$core.int> envelopeXdr,
    Cursor cursor,
    $3.InvoiceList invoiceList,
  }) {
    final _result = create();
    if (hash != null) {
      _result.hash = hash;
    }
    if (resultXdr != null) {
      _result.resultXdr = resultXdr;
    }
    if (envelopeXdr != null) {
      _result.envelopeXdr = envelopeXdr;
    }
    if (cursor != null) {
      _result.cursor = cursor;
    }
    if (invoiceList != null) {
      _result.invoiceList = invoiceList;
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
  static HistoryItem _defaultInstance;

  @$pb.TagNumber(1)
  $3.TransactionHash get hash => $_getN(0);
  @$pb.TagNumber(1)
  set hash($3.TransactionHash v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => clearField(1);
  @$pb.TagNumber(1)
  $3.TransactionHash ensureHash() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get resultXdr => $_getN(1);
  @$pb.TagNumber(2)
  set resultXdr($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasResultXdr() => $_has(1);
  @$pb.TagNumber(2)
  void clearResultXdr() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get envelopeXdr => $_getN(2);
  @$pb.TagNumber(3)
  set envelopeXdr($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEnvelopeXdr() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnvelopeXdr() => clearField(3);

  @$pb.TagNumber(4)
  Cursor get cursor => $_getN(3);
  @$pb.TagNumber(4)
  set cursor(Cursor v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCursor() => $_has(3);
  @$pb.TagNumber(4)
  void clearCursor() => clearField(4);
  @$pb.TagNumber(4)
  Cursor ensureCursor() => $_ensure(3);

  @$pb.TagNumber(5)
  $3.InvoiceList get invoiceList => $_getN(4);
  @$pb.TagNumber(5)
  set invoiceList($3.InvoiceList v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasInvoiceList() => $_has(4);
  @$pb.TagNumber(5)
  void clearInvoiceList() => clearField(5);
  @$pb.TagNumber(5)
  $3.InvoiceList ensureInvoiceList() => $_ensure(4);
}

class Cursor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Cursor', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'kin.agora.transaction.v3'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Cursor._() : super();
  factory Cursor({
    $core.List<$core.int> value,
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
  static Cursor _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

