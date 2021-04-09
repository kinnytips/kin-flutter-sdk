import 'dart:core';

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:kinny/base/models/invoices.dart';
import 'package:kinny/base/models/kin_account.dart';
import 'package:kinny/base/models/quark_amount.dart';
import 'package:kinny/base/models/transaction_hash.dart';
import 'package:kinny/models/agora/protobuf/common/v3/model.pb.dart' as Model;

extension KinAccountIdToProto on KinAccountId {
  Model.StellarAccountId toProtoStellarAccountId() =>
      Model.StellarAccountId(value: toKeyPair().accountId);
}

extension TransactionHashToProto on TransactionHash {
  Model.TransactionHash toProtoTransactionHash() =>
      Model.TransactionHash.fromBuffer(rawValue);
}

extension LineItemToProto on LineItem {
  Model.Invoice_LineItem toProto() => Model.Invoice_LineItem(
      title: title,
      description: description,
      amount: $fixnum.Int64(amount.toQuarks().value),
      sku: sku?.bytes);
}

extension ListLineItemToProto on List<LineItem> {
  List<Model.Invoice_LineItem> toProto() => map((e) => e.toProto()).toList();
}

extension InvoiceToProto on Invoice {
  Model.Invoice toProto() => Model.Invoice(items: lineItems.toProto());
}

extension ListInvoiceToProto on List<Invoice> {
  Model.InvoiceList toProto() =>
      Model.InvoiceList(invoices: this.map((e) => e.toProto()));
}

extension InvoiceListToProto on InvoiceList {
  toProto() =>
      Model.InvoiceList(invoices: this.invoices.map((e) => e.toProto()));
}

//
// The other not implemented extensions:
//

/*

fun KinAccountCreationApi.CreateAccountRequest.toGrpcRequest(): AccountService.CreateAccountRequest =
AccountService.CreateAccountRequest.newBuilder()
.setAccountId(
StellarAccountId.newBuilder()
.setValue(accountId.toKeyPair().accountId)
)
.build()

fun KinAccountApi.GetAccountRequest.toGrpcRequest(): AccountService.GetAccountInfoRequest =
AccountService.GetAccountInfoRequest.newBuilder()
.setAccountId(
StellarAccountId.newBuilder()
.setValue(accountId.toKeyPair().accountId)
).build()

fun KinTransactionApi.GetTransactionHistoryRequest.toGrpcRequest(): TransactionService.GetHistoryRequest =
TransactionService.GetHistoryRequest.newBuilder()
.setAccountId(accountId.toProtoStellarAccountId())
.apply {
if (pagingToken != null && pagingToken.value.isNotEmpty()) {
cursor =  TransactionService.Cursor.newBuilder()
    .setValue(ByteString.copyFrom(Base64.decodeBase64(pagingToken.value)))
    .build()
}
direction = when (order) {
Order.Ascending -> Direction.ASC
Order.Descending -> Direction.DESC
}
}
.build()

fun KinTransactionApi.GetTransactionRequest.toGrpcRequest(): TransactionService.GetTransactionRequest =
TransactionService.GetTransactionRequest.newBuilder()
.setTransactionHash(transactionHash.toProtoTransactionHash())
.build()

fun KinTransactionApi.SubmitTransactionRequest.toGrpcRequest(): TransactionService.SubmitTransactionRequest? {
val builder = TransactionService.SubmitTransactionRequest.newBuilder()
    .setEnvelopeXdr(ByteString.copyFrom(transactionEnvelopeXdr))
invoiceList?.let {
builder.setInvoiceList(it.invoices.toProto())
}
return builder.build()
}

 */
