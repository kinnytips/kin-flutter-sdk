import 'dart:async';

import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/kin_payment_item.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/tools/observers.dart';

import 'package:kin_base/models/agora/protobuf/transaction/v3/transaction_service.pbenum.dart';

abstract class KinService {
    Future<KinAccount> createAccount(KinAccountId accountId, PrivateKey signer) ;

    Future<KinAccount> getAccount(KinAccountId accountId) ;

    Future<List<PublicKey>> resolveTokenAccounts(KinAccountId accountId) ;

    Future<List<KinTransaction>> getLatestTransactions(KinAccountId kinAccountId) ;

    Future<List<KinTransaction>> getTransactionPage(
        KinAccountId kinAccountId,
        PagingToken pagingToken,
        KinServiceOrder order
    ) ;

    Future<KinTransaction> getTransaction(TransactionHash transactionHash) ;

    Future<bool> canWhitelistTransactions() ;

    Future<QuarkAmount> getMinFee() ;

    Future<KinTransaction> buildAndSignTransaction(
        PrivateKey ownerKey,
        PublicKey sourceKey,
        int nonce,
        List<KinPaymentItem> paymentItems,
        KinMemo memo,
        QuarkAmount fee
    ) ;

    Future<KinTransaction> submitTransaction(KinTransaction transaction) ;

    Future<KinTransaction> buildSignAndSubmitTransaction(
        Future<KinTransaction> buildAndSignTransaction
    ) ;

    Observer<KinAccount> streamAccount(KinAccountId kinAccountId) ;

    Observer<KinTransaction> streamNewTransactions(KinAccountId kinAccountId) ;

    invalidateBlockhashCache() ;
}

enum KinServiceOrder { ascending, descending }

typedef KinServiceResponseCallback<T> = void Function(KinServiceResponse<T> response) ;

class KinServiceResponse<P> {
    final KinServiceResponseType type;
    final P payload ;
    final dynamic error;

    KinServiceResponse(this.type, [this.payload, this.error]);
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

class KinServiceInvoiceResponse<P> extends KinServiceResponse<P> {
    List<KinServiceInvoiceErrorType> invoiceErrors;

    KinServiceInvoiceResponse(this.invoiceErrors, [P payload, dynamic error])
        : super(KinServiceResponseType.invoiceError, payload, error);

}

enum KinServiceInvoiceErrorType {
    unknown,
    alreadyPaid,
    wrongDestination,
    SkuNotFound
}

class FatalError extends StateError {
    final Error reason ;
    FatalError(String message, [this.reason]) : super(message);
}

class TransientFailure extends FatalError {
    TransientFailure([Error reason]) : super("The request was retried until limit was exceeded", reason);
}

class UnexpectedServiceError extends FatalError {
    UnexpectedServiceError([Error reason]) : super("There was an unexpected service error", reason);
}

class DeniedError extends FatalError {
    DeniedError([Error reason]) : super("This action was not allowed", reason);
}

class IllegalRequestError extends FatalError {
    IllegalRequestError([Error reason]) : super("Malformed request", reason);
}

class IllegalResponseError extends FatalError {
    IllegalResponseError([Error reason]) : super("Malformed response from server", reason);
}

class ItemNotFoundError extends FatalError {
    ItemNotFoundError([Error reason]) : super("The requested item was not found", reason);
}

class PermanentlyUnavailableError extends FatalError {
    PermanentlyUnavailableError([Error reason]) : super("This operation is not supported under this configuration", reason);
}

class UnknownAccountInRequestError extends FatalError {
    UnknownAccountInRequestError([Error reason]) : super("Unknown Account", reason);
}

class BadSequenceNumberInRequestError extends FatalError {
    BadSequenceNumberInRequestError([Error reason]) : super("Bad Sequence Number", reason);
}

class InsufficientFeeInRequestError extends FatalError {
    InsufficientFeeInRequestError([Error reason]) : super("Insufficient Fee", reason);
}

class InsufficientBalanceForSourceAccountInRequestError extends FatalError {
    InsufficientBalanceForSourceAccountInRequestError([Error reason]) : super("Insufficient Balance", reason);
}

class WebhookRejectedTransactionError extends FatalError {
    WebhookRejectedTransactionError([Error reason]) : super("This transaction was rejected by the configured webhook without a reason", reason);
}

class InvoiceErrorsInRequest extends FatalError {
    List<SubmitTransactionResponse_InvoiceError_Reason> invoiceErrors ;

    InvoiceErrorsInRequest(this.invoiceErrors, [Error reason]) : super("Invoice Errors", reason);
}

class SDKUpgradeRequired extends FatalError {
    SDKUpgradeRequired([Error reason]) : super("Please upgrade to a newer version of the SDK", reason);
}

abstract class KinTestService {
    /**
     * Funds an account with a set amount of test Kin.
     */
    Future<KinAccount> fundAccount(KinAccountId accountId) ;
}