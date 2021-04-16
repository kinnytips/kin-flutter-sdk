import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart' show ListEquality;
import 'package:crypto/crypto.dart';
import 'package:kinny/base/models/invoices.dart';
import 'package:kinny/base/models/kin_amount.dart';
import 'package:kinny/base/models/sha_224_hash.dart';
import 'package:kinny/models/agora/protobuf/common/v3/model.pb.dart' as Model;

extension ListTypedExtension<T> on List<T> {
  /// Provide access to the generic type at runtime.
  Type get genericType => T;
}

extension IntExtension on int {
  ByteData toByte() => ByteData(1)..setInt8(0, this);

  ByteData toInt32Bytes() => ByteData(4)..setInt32(0, this);

  ByteData toInt64Bytes() => ByteData(8)..setInt64(0, this);

  Uint8List toInt32Uint8List() => toInt32Bytes().buffer.asUint8List();

  Uint8List toInt64Uint8List() => toInt64Bytes().buffer.asUint8List();

  Uint8List toUint8List() {
    var l = Uint8List(1);
    l[0] = this;
    return l;
  }
}

extension StringExtension on String {
  Uint8List toBytesUTF8() => utf8.encode(this);

  Uint8List toBytesLatin1() => latin1.encode(this);
}

extension ByteDataExtension on ByteData {
  int toInt() => this.getInt8(0);
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

extension ListExtension<T> on List<T> {
  static const ListEquality _listEquality = ListEquality();

  int computeHashCode() => _listEquality.hash(this);

  bool equalsContent(List<T> other) => _listEquality.equals(this, other);
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
    return Invoice.fromListOfLineItem(lineItems);
  }

  SHA224Hash sha224Hash() => SHA224Hash.fromBytes(this.writeToBuffer());
}

extension ModelInvoiceListParser on Model.InvoiceList {
  static Model.InvoiceList parseProtoBuffer(Uint8List bytes) {
    return Model.InvoiceList.fromBuffer(bytes);
  }

  InvoiceList toInvoiceList() {
    var invoices = this.invoices.map((e) => e.toInvoice());
    return InvoiceList.fromListOfInvoice(invoices);
  }

  SHA224Hash sha224Hash() => SHA224Hash.fromBytes(this.writeToBuffer());
}
