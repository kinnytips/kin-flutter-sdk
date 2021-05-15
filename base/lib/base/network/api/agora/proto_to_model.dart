import 'dart:core';

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as model_v3;

extension KinAccountIdToProto on KinAccountId {
  model_v3.StellarAccountId toProtoStellarAccountId() =>
      model_v3.StellarAccountId(value: toKeyPair().accountId);
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
