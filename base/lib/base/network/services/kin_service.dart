import 'dart:async';

import 'package:kin_base/base/models/appidx.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/kin_payment_item.dart';
import 'package:kin_base/base/models/solana/instruction.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/tools/observers.dart';

abstract class KinService {
    Future<KinAccount?> createAccount(KinAccountId accountId, PrivateKey signer);

    Future<KinAccount?> getAccount(KinAccountId accountId);

    Future<List<KinTokenAccountInfo>> resolveTokenAccounts(KinAccountId accountId);

    Future<List<KinTokenAccountInfo>> mergeTokenAccounts(
      KinAccountId accountId, 
      PrivateKey signer, 
      AppIdx appIdx,
      [bool shouldCreateAssociatedAccount = true]
    );

    Future<List<KinTransaction>?> getLatestTransactions(KinAccountId kinAccountId);

    Future<List<KinTransaction>?> getTransactionPage(
        KinAccountId kinAccountId,
        PagingToken? pagingToken,
        KinServiceOrder order
    );

    Future<KinTransaction?> getTransaction(TransactionHash transactionHash);

    FutureOr<bool> canWhitelistTransactions();

    Future<KinTransaction> buildAndSignTransaction(
        PrivateKey ownerKey,
        PublicKey sourceKey,
        int nonce,
        List<KinPaymentItem> paymentItems,
        KinMemo? memo,
        List<Instruction> createAccountInstructions,
        List<PrivateKey> signers
    );

    Future<KinTransaction?> submitTransaction(KinTransaction transaction);

    Future<KinTransaction> buildSignAndSubmitTransaction(
        Future<KinTransaction> Function() buildAndSignTransaction
    );

    Observer<KinAccount> streamAccount(KinAccountId kinAccountId);

    Observer<KinTransaction> streamNewTransactions(KinAccountId kinAccountId);

    void invalidateBlockhashCache();
}

enum KinServiceOrder { ascending, descending }

typedef KinServiceResponseCallback<T> = void Function(KinServiceResponse<T> response);

class KinServiceResponse<P> {
    final KinServiceResponseType type;
    final P? payload ;
    final dynamic error;

    KinServiceResponse(this.type, [this.payload, this.error]);

    @override
    String toString() {
      return 'KinServiceResponse{type: $type, payload: ${ payload?.runtimeType }, error: $error}';
    }
}

enum KinServiceResponseType {
    ok,
    notFound,
    transientFailure,
    undefinedError,
    upgradeRequiredError,
    insufficientBalance,
    insufficientFee,
    badSequenceNumber,
    noAccount,
    webhookRejected,
    invoiceError,
    exists,
    payerRequired,
    badNonce,
    unavailable,
}

// Maybe this should be removed and use only `KinServiceResponse`:
class KinServiceInvoiceResponse<P> extends KinServiceResponse<P> {
    List<KinServiceInvoiceErrorType>? invoiceErrors;

    KinServiceInvoiceResponse(KinServiceResponseType type, [P? payload, dynamic error, this.invoiceErrors])
        : super(type, payload, error);

}

enum KinServiceInvoiceErrorType {
    unknown,
    alreadyPaid,
    wrongDestination,
    SkuNotFound
}

class FatalError extends StateError {
    final Object? reason ;
    FatalError(String message, [this.reason]) : super(message);
}

class TransientFailure extends FatalError {
    TransientFailure([Object? reason]) : super("The request was retried until limit was exceeded", reason);
}

class UnexpectedServiceError extends FatalError {
    UnexpectedServiceError([Object? reason]) : super("There was an unexpected service error", reason);
}

class DeniedError extends FatalError {
    DeniedError([Object? reason]) : super("This action was not allowed", reason);
}

class IllegalRequestError extends FatalError {
    IllegalRequestError([Object? reason]) : super("Malformed request", reason);
}

class IllegalResponseError extends FatalError {
    IllegalResponseError([Object? reason]) : super("Malformed response from server", reason);
}

class ItemNotFoundError extends FatalError {
    ItemNotFoundError([Object? reason]) : super("The requested item was not found", reason);
}

class PermanentlyUnavailableError extends FatalError {
    PermanentlyUnavailableError([Object? reason]) : super("This operation is not supported under this configuration", reason);
}

class UnknownAccountInRequestError extends FatalError {
    UnknownAccountInRequestError([Object? reason]) : super("Unknown Account", reason);
}

class BadSequenceNumberInRequestError extends FatalError {
    BadSequenceNumberInRequestError([Object? reason]) : super("Bad Sequence Number", reason);
}

class InsufficientFeeInRequestError extends FatalError {
    InsufficientFeeInRequestError([Object? reason]) : super("Insufficient Fee", reason);
}

class InsufficientBalanceForSourceAccountInRequestError extends FatalError {
    InsufficientBalanceForSourceAccountInRequestError([Object? reason]) : super("Insufficient Balance", reason);
}

class WebhookRejectedTransactionError extends FatalError {
    WebhookRejectedTransactionError([Object? reason]) : super("This transaction was rejected by the configured webhook without a reason", reason);
}

class InvoiceErrorsInRequest extends FatalError {
    // No SubmitTransactionResponse_InvoiceError_Reason
    //List<SubmitTransactionResponse_InvoiceError_Reason> invoiceErrors ;

    InvoiceErrorsInRequest(
        //this.invoiceErrors,
        [Error? reason]) : super("Invoice Errors", reason);
}

class SDKUpgradeRequired extends FatalError {
    SDKUpgradeRequired([Error? reason]) : super("Please upgrade to a newer version of the SDK", reason);
}

abstract class KinTestService {
    /**
     * Funds an account with a set amount of test Kin.
     */
    Future<KinAccount> fundAccount(KinAccountId accountId) ;
}