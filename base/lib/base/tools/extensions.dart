import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart' show ListEquality;
import 'package:crypto/crypto.dart';
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_amount.dart';
import 'package:kin_base/base/models/kin_payment_item.dart';
import 'package:kin_base/base/models/sha_224_hash.dart';
import 'package:kin_base/base/network/api/agora/model_to_proto.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/stellar/models/record_type.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as Model;

extension ListTypedExtension<T> on List<T> {
  /// Provide access to the generic type at runtime.
  Type get genericType => T;
}

extension IntExtension on int {
  ByteData toByte() => ByteData(1)..setInt8(0, this);

  ByteData toInt32Bytes([Endian endian = Endian.little]) => ByteData(4)..setInt32(0, this, endian);

  ByteData toInt64Bytes([Endian endian = Endian.little]) => ByteData(8)..setInt64(0, this, endian);

  Uint8List toInt32Uint8List([Endian endian = Endian.little]) => toInt32Bytes(endian).buffer.asUint8List();

  Uint8List toInt64Uint8List([Endian endian = Endian.little]) => toInt64Bytes(endian).buffer.asUint8List();

  Uint8List toUint8List() {
    var l = Uint8List(1);
    l[0] = this;
    return l;
  }
}

extension StringExtension on String {
  Uint8List toBytesUTF8() => utf8.encode(this) as Uint8List;

  Uint8List toBytesLatin1() => latin1.encode(this);
}

extension ByteDataExtension on ByteData {
  int toInt() => this.getInt8(0);

  Uint8List toUint8List() =>
      Uint8List.fromList(List<int>.generate(lengthInBytes, (i) => getInt8(i)));
}

extension Uint8ListExtension on Uint8List {
  static Uint8List asUint8List(List<int> l) {
    return l is Uint8List ? l : Uint8List.fromList(l);
  }

  String toHexString() =>
      map((e) => e.toRadixString(16).padLeft(2, '0')).join();

  ByteData toByte() => ByteData.sublistView(this);

  Uint8List toSha224() {
    var bytes = sha224.convert(this).bytes;
    return bytes is Uint8List ? bytes : Uint8List.fromList(bytes);
  }
}

extension ListIntExtension on List<int> {

  Uint8List toUint8List() => Uint8List.fromList(this);

}

extension ListExtension<T> on List<T> {
  static const ListEquality _listEquality = ListEquality();

  int computeHashCode() => _listEquality.hash(this);

  bool equalsContent(List<T>? other) => _listEquality.equals(this, other);

  List<T> requireNoNulls() {
    for (var e in this) {
      if (e == null) throw StateError('Null element found in: $this');
    }
    return this ;
  }

  List<T> whereNotNull() => where((e) => e != null).toList();

  T? get firstOrNull => isEmpty ? null : first ;
}


extension IterableExtension<T> on Iterable<T> {
  List<T> requireNoNulls() {
    for (var e in this) {
      if (e == null) throw StateError('Null element found in: $this');
    }
    return this as List<T> ;
  }

  List<T> whereNotNull() => where((e) => e != null).toList();

  T? get firstOrNull => isEmpty ? null : first ;
}

extension ModelInvoice_LineItemParser on Model.Invoice_LineItem {
  static Model.Invoice_LineItem parseProtoBuffer(Uint8List bytes) {
    return Model.Invoice_LineItem.fromBuffer(bytes);
  }

  LineItem toLineItem() {
    var sku = SKU(Uint8List.fromList(this.sku));
    return LineItem(title, description, KinAmount.fromInt(amount.toInt()), sku);
  }
}

extension ModelInvoiceParser on Model.Invoice {
  static Model.Invoice parseProtoBuffer(Uint8List bytes) {
    return Model.Invoice.fromBuffer(bytes);
  }

  Invoice toInvoice() {
    var lineItems = this.items.map((e) => e.toLineItem());
    return Invoice.fromListOfLineItem(lineItems as List<LineItem>);
  }

  SHA224Hash sha224Hash() => SHA224Hash.fromBytes(this.writeToBuffer());
}

extension ModelInvoiceListParser on Model.InvoiceList {
  static Model.InvoiceList parseProtoBuffer(Uint8List bytes) {
    return Model.InvoiceList.fromBuffer(bytes);
  }

  InvoiceList toInvoiceList() {
    var invoices = this.invoices.map((e) => e.toInvoice());
    return InvoiceList.fromListOfInvoice(invoices as List<Invoice>);
  }

  SHA224Hash sha224Hash() => SHA224Hash.fromBytes(this.writeToBuffer());
}

extension ListKinTransactionExtension on List<KinTransaction> {

  PagingToken? findHeadHistoricalTransaction() {
    return findHistoricalTransaction(this);
  }

  PagingToken? findTailHistoricalTransaction() {
    return findHistoricalTransaction(this.reversed.toList());
  }

  static PagingToken? findHistoricalTransaction(List<KinTransaction> transactions) {
    var recordTypes = transactions.map((t) => t.recordType).toList();
    var historicalTransactions = recordTypes.whereType<RecordTypeHistorical>();
    return historicalTransactions.isNotEmpty ? historicalTransactions.first.pagingToken : null ;
  }

}

extension ListKinPaymentItemExtension on List<KinPaymentItem> {

  InvoiceList? toInvoiceList() {
    var list = this.map((e) => e.invoice).whereType<Invoice>().toList() ;
    return list.isNotEmpty
        ? InvoiceList(InvoiceListId(list.toProto().sha224Hash()), list)
        : null;
  }

}

extension StackTraceExtension on StackTrace {

  List<String> get lines => toString().split(RegExp(r'[\r\n]+'));

  String getLine(int index) => lines[index];

  String get firstLine => getLine(0);

}

extension DigestExtension on Digest {
  Uint8List toUint8List() => Uint8List.fromList(bytes);
}