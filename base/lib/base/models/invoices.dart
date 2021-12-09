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
  final SKU? sku;

  LineItem(this.title, this.description, this.amount, this.sku) {
    if (title.isEmpty || title.length > 128)
      throw LineItemFormatException(
          "title too short. Must be > 1 and < 128 characters");
    if (description.length > 256)
      throw LineItemFormatException(
          "title too short. Must be > 1 and < 128 characters");
    if ((sku?.bytes.length ?? 0) > 128)
      throw LineItemFormatException("SKU cannot exceed 128 bytes");
  }
}

class LineItemBuilder {
  String title;
  KinAmount amount;
  SKU? _sku = null;
  String _description = "";

  LineItemBuilder(this.title, this.amount);

  void setDescription(String description) {
    this._description = description;
  }

  void setSku(SKU sku) {
    this._sku = sku;
  }

  LineItem build() {
    return LineItem(title, _description, amount, _sku);
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceId &&
          runtimeType == other.runtimeType &&
          invoiceHash == other.invoiceHash;

  @override
  int get hashCode => invoiceHash.hashCode;

  @override
  String toString() {
    return 'InvoiceId{invoiceHash: $invoiceHash}';
  }
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

  KinAmount? _total;

  KinAmount? get total {
    if (_total == null) {
      _total = lineItems
          .map((e) => e.amount)
          .reduce((total, elemAmount) => total + elemAmount);
    }
    return _total;
  }

  Uint8List toProtoBytes() => toProto().writeToBuffer();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Invoice && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Invoice{id: $id, lineItems: $lineItems}';
  }
}

class InvoiceBuilder {
  List<LineItem>? _lineItems;

  InvoiceBuilder() {
    _lineItems = new List.empty(growable: true);
  }

  void addLineItem(LineItem lineItem) {
    this._lineItems!.add(lineItem);
  } 

  void addLineItems(List<LineItem> lineItems) {
    this._lineItems!.addAll(lineItems);
  }

  Invoice build() {
    if(_lineItems == null || _lineItems!.isEmpty){
      throw InvoiceFormatException("Must have at least one LineItem");
    }
    else if (_lineItems!.length > 1024) {
      throw InvoiceFormatException("Maximum of 1024 LineItem's allowed");
    }
    else {
      return Invoice(InvoiceId.fromListOfLineItem(_lineItems!), _lineItems!);
    }
  }
}

class InvoiceListId {
  final SHA224Hash invoiceHash;

  InvoiceListId(this.invoiceHash);

  InvoiceListId.fromListOfInvoice(List<Invoice> invoices)
      : this(Model.InvoiceList(invoices: invoices.toProto().invoices)
            .sha224Hash());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceListId &&
          runtimeType == other.runtimeType &&
          invoiceHash == other.invoiceHash;

  @override
  int get hashCode => invoiceHash.hashCode;

  @override
  String toString() {
    return 'InvoiceListId{invoiceHash: $invoiceHash}';
  }
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceList &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          invoices.equalsContent(other.invoices) ;

  @override
  int get hashCode => id.hashCode ^ invoices.hashCode;

  @override
  String toString() {
    return 'InvoiceList{id: $id, invoices: $invoices}';
  }
}
