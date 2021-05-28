import 'dart:typed_data';

import 'package:kin_base/base/network/api/agora/model_to_proto.dart';
import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as Model;

import 'kin_amount.dart';
import 'sha_224_hash.dart';

class SKU {
  Uint8List bytes;

  SKU(this.bytes);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SKU &&
          runtimeType == other.runtimeType &&
          bytes.equalsContent(other.bytes);

  @override
  int get hashCode => bytes.computeHashCode();
}

class LineItem {
  final String title;
  final String description;
  final KinAmount amount;
  final SKU sku;

  LineItem(this.title, this.description, this.amount, this.sku) {
    if (title.isEmpty || title.length > 128)
      throw LineItemFormatException(
          "title too short. Must be > 1 and < 128 characters");
    if (description.length > 256)
      throw LineItemFormatException(
          "title too short. Must be > 1 and < 128 characters");
    if ((sku?.bytes?.length ?? 0) > 128)
      throw LineItemFormatException("SKU cannot exceed 128 bytes");
  }
}

class LineItemFormatException implements Exception {
  String message;

  LineItemFormatException(this.message);

  @override
  String toString() {
    return 'LineItemFormatException{message: $message}';
  }
}

class InvoiceId {
  final SHA224Hash invoiceHash;

  InvoiceId(this.invoiceHash);

  InvoiceId.fromListOfLineItem(List<LineItem> lineItems)
      : this(Model.Invoice(items: lineItems.toProto()).sha224Hash());
}

class InvoiceFormatException implements Exception {
  String message;

  InvoiceFormatException(this.message);

  @override
  String toString() {
    return 'InvoiceFormatException{message: $message}';
  }
}

class Invoice {
  final InvoiceId id;

  final List<LineItem> lineItems;

  Invoice(this.id, this.lineItems) {
    if (lineItems.isEmpty)
      throw InvoiceFormatException("Must have at least one LineItem");
    if (lineItems.length > 1024)
      throw InvoiceFormatException("Maximum of 1024 LineItem's allowed");
  }

  factory Invoice.fromListOfLineItem(List<LineItem> lineItems) =>
      Invoice(InvoiceId.fromListOfLineItem(lineItems), lineItems);

  factory Invoice.parseProtoBuffer(Uint8List bytes) =>
      ModelInvoiceParser.parseProtoBuffer(bytes).toInvoice();

  KinAmount _total;

  KinAmount get total {
    if (_total == null) {
      _total = lineItems
          .map((e) => e.amount)
          .reduce((total, elemAmount) => total + elemAmount);
    }
    return _total;
  }

  Uint8List toProtoBytes() => toProto().writeToBuffer();
}

class InvoiceListId {
  final SHA224Hash invoiceHash;

  InvoiceListId(this.invoiceHash);

  InvoiceListId.fromListOfInvoice(List<Invoice> invoices)
      : this(Model.InvoiceList(invoices: invoices.toProto().invoices)
            .sha224Hash());
}

class InvoiceListFormatException implements Exception {
  String message;

  InvoiceListFormatException(this.message);

  @override
  String toString() {
    return 'InvoiceListFormatException{message: $message}';
  }
}

class InvoiceList {
  final InvoiceListId id;
  final List<Invoice> invoices;

  InvoiceList(this.id, this.invoices) {
    if (invoices.isEmpty)
      throw InvoiceListFormatException("Must have at least one Invoice");
    if (invoices.length > 100)
      throw InvoiceListFormatException("Maximum of 100 invoices allowed");
  }

  factory InvoiceList.fromListOfInvoice(List<Invoice> invoices) =>
      InvoiceList(InvoiceListId.fromListOfInvoice(invoices), invoices);
}
