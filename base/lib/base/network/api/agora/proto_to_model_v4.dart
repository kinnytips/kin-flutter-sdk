

import 'dart:convert';
import 'dart:typed_data';

import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/sha_224_hash.dart';
import 'package:kin_base/base/models/solana/fixed_byte_array.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/stellar_base_type_conversions.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/stellar/models/record_type.dart';
import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pb.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as model_v3 ;
import 'package:kin_base/models/agora/protobuf/common/v4/model.pb.dart' as model_v4 ;
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pb.dart';
import 'package:kin_base/stellarfork/key_pair.dart';
import 'package:kin_base/stellarfork/xdr/xdr_data_io.dart';
import 'package:kin_base/stellarfork/xdr/xdr_transaction.dart';
import 'package:kin_base/stellarfork/xdr/xdr_type.dart';


extension AccountInfoExtension on AccountInfo {

  KinAccount toKinAccount() {
    var key = PublicKey.fromBytes( this.accountId.value as Uint8List? );
    var amount = QuarkAmount(this.balance.toInt()).toKin() ;
    var balance = KinBalance(amount);
    var kinAccount = KinAccount(key, balance: balance, status:  KinAccountStatusRegistered(0) );
    return kinAccount;
  }

}

extension ModelInvoiceListExtension on model_v3.InvoiceList {
  InvoiceList toInvoiceList() {
    return InvoiceList(
        InvoiceListId( this.sha224Hash() ) ,
        this.invoices.map((e) => e.toInvoice() ) as List<Invoice>
    );
  }

  SHA224Hash sha224Hash() => SHA224Hash.fromBytes(this.writeToBuffer()) ;
}

extension ModelInvoiceExtension on model_v3.Invoice {
  Invoice toInvoice() {
    return Invoice(InvoiceId(sha224Hash()), this.items.map((e) => e.toLineItem()) as List<LineItem> );
  }

  SHA224Hash sha224Hash() => SHA224Hash.fromBytes( this.writeToBuffer() );
}


extension ModelInvoiceLineItemExtension on model_v3.Invoice_LineItem {

  LineItem toLineItem() {
    return LineItem(
        this.title,
        this.description,
        QuarkAmount(this.amount.toInt()).toKin(),
        sku.isEmpty ? null : SKU(this.sku as Uint8List)
    );
  }

}

extension ModelTransactionErrorExtension on model_v4.TransactionError {

  XdrTransactionResultCode? toXdrTransactionResultCode() {
    if (!this.hasReason()) {
      return null ;
    }

    var reason = this.reason;
    switch(reason) {
      case model_v4.TransactionError_Reason.NONE: {
        return XdrTransactionResultCode.txSUCCESS ;
      }
      case model_v4.TransactionError_Reason.UNAUTHORIZED: {
        return XdrTransactionResultCode.txBAD_AUTH ;
      }
      case model_v4.TransactionError_Reason.BAD_NONCE: {
        return XdrTransactionResultCode.txBAD_SEQ ;
      }
      case model_v4.TransactionError_Reason.INSUFFICIENT_FUNDS: {
        return XdrTransactionResultCode.txINSUFFICIENT_BALANCE ;
      }
      case model_v4.TransactionError_Reason.INVALID_ACCOUNT: {
        return XdrTransactionResultCode.txNO_ACCOUNT ;
      }
      case model_v4.TransactionError_Reason.UNKNOWN: {
        return XdrTransactionResultCode.txFAILED ;
      }
      default : throw StateError('Unknown reason: $reason');
      /* UNRECOGNIZED non-existent
      case model_v4.TransactionError_Reason.UNRECOGNIZED: {
        return XdrTransactionResultCode.txINTERNAL_ERROR ;
      }
       */
    }
  }

  Uint8List? toResultXdr() => toXdrTransactionResultCode()?.toResultXdr();

}

extension XdrTransactionResultCodeExtension on XdrTransactionResultCode {

  Uint8List toResultXdr() {
    var transactionResult = XdrTransactionResult() ;

    transactionResult.result = XdrTransactionResultResult()
    //..discriminant = XdrTransactionResultCode.decode( XdrDataInputStream(this.toResultXdr()) )
      ..discriminant = this ;
    ;

    transactionResult.feeCharged = XdrInt64(0);

    transactionResult.ext = XdrTransactionResultExt()..discriminant = 0 ;

    var out = XdrDataOutputStream();
    XdrTransactionResult.encode(out, transactionResult) ;
    return Uint8List.fromList(out.bytes);
  }
}

extension HistoryItemExtension on HistoryItem {
  KinTransaction toHistoricalKinTransaction(NetworkEnvironment networkEnvironment) {
    if (this.hasSolanaTransaction()) {
      return SolanaKinTransaction(
        Uint8List.fromList(solanaTransaction.value),
        RecordTypeHistorical(
            DateTime.now().millisecondsSinceEpoch,
            transactionError.toResultXdr(),
            PagingToken(base64.encode(cursor.value))),
        networkEnvironment,
        this.hasInvoiceList() ? this.invoiceList.toInvoiceList() : null,
      );
    } else {
      return StellarKinTransaction(
        Uint8List.fromList(stellarTransaction.envelopeXdr),
        RecordTypeHistorical(
            DateTime.now().millisecondsSinceEpoch,
            transactionError.toResultXdr(),
            PagingToken(base64.encode(cursor.value))),
        networkEnvironment,
        this.hasInvoiceList() ? this.invoiceList.toInvoiceList() : null,
      );
    }
  }

  KinTransaction toAcknowledgedKinTransaction(NetworkEnvironment networkEnvironment) {
    if (this.hasSolanaTransaction()) {
      return SolanaKinTransaction(
        Uint8List.fromList(solanaTransaction.value),
        RecordTypeAcknowledged(
          DateTime.now().millisecondsSinceEpoch,
          transactionError.toResultXdr(),
        ),
        networkEnvironment,
        this.hasInvoiceList() ? this.invoiceList.toInvoiceList() : null,
      );
    } else {
      return StellarKinTransaction(
        Uint8List.fromList(stellarTransaction.envelopeXdr),
        RecordTypeAcknowledged(
            DateTime.now().millisecondsSinceEpoch,
            transactionError.toResultXdr(),
        ),
        networkEnvironment,
        this.hasInvoiceList() ? this.invoiceList.toInvoiceList() : null,
      );
    }
  }
}

extension TransactionSignatureExtension on model_v4.TransactionSignature {

  Signature toModel() {
    return Signature(value: FixedByteArray64( this.value as Uint8List? ));
  }

}

extension ModelBlockhashExtension on model_v4.Blockhash {
  Hash toModel() => Hash( FixedByteArray32( this.value as Uint8List? ) );
}

extension SolanaAccountIdExtension on model_v4.SolanaAccountId {

  PublicKey toPublicKey() => KeyPair.fromPublicKey(value as Uint8List?).asPublicKey() ;

}
