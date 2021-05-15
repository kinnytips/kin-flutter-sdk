import 'dart:convert';
import 'dart:core';

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as model_v3;
import 'package:kin_base/models/agora/protobuf/transaction/v3/transaction_service.pb.dart';

extension KinAccountIdToProto on KinAccountId {
  model_v3.StellarAccountId toProtoStellarAccountId() =>
      model_v3.StellarAccountId(value: toKeyPair().accountId);
}

extension PagingTokenToProto on PagingToken {
  Cursor toProtoCursor() {
    var cursor = Cursor.create();
    if (this.value.isNotEmpty) {
      cursor.value = base64.decode(this.value);
    }
    return cursor;
  }
}

extension TransactionHashToProto on TransactionHash {
  model_v3.TransactionHash toProtoTransactionHash() =>
      model_v3.TransactionHash.fromBuffer(rawValue);
}

extension LineItemToProto on LineItem {
  model_v3.Invoice_LineItem toProto() => model_v3.Invoice_LineItem(
      title: title,
      description: description,
      amount: $fixnum.Int64(amount.toQuarks().value),
      sku: sku?.bytes);
}

extension ListLineItemToProto on List<LineItem> {
  List<model_v3.Invoice_LineItem> toProto() => map((e) => e.toProto()).toList();
}

extension InvoiceToProto on Invoice {
  model_v3.Invoice toProto() => model_v3.Invoice(items: lineItems.toProto());
}

extension ListInvoiceToProto on List<Invoice> {
  model_v3.InvoiceList toProto() =>
      model_v3.InvoiceList(invoices: this.map((e) => e.toProto()));
}

extension InvoiceListToProto on InvoiceList {
  toProto() =>
      model_v3.InvoiceList(invoices: this.invoices.map((e) => e.toProto()));
}
