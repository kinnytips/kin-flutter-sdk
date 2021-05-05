import 'package:kin_base/base/kin_environment.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/tools/kin_logger.dart';
import 'package:kin_base/base/tools/observers.dart';
import 'package:kin_base/services/kin_services.dart';
import 'package:kin_base/stellarfork/key_pair.dart';
import 'package:kin_base/stellarfork/xdr/xdr_signing.dart';

import 'models/account_spec.dart';
import 'models/appidx.dart';
import 'models/invoices.dart';
import 'models/key.dart';
import 'models/kin_account.dart';
import 'models/kin_amount.dart';
import 'models/kin_binary_memo.dart';
import 'models/kin_memo.dart';
import 'models/kin_payment.dart';
import 'models/kin_payment_item.dart';
import 'models/quark_amount.dart';
import 'models/transaction_hash.dart';
import 'network/services/app_info_providers.dart';
import 'storage/storage.dart';
import 'tools/executor_service.dart';

enum ObservationMode {
  Passive,
  Active,
  ActiveNewOnly,
}

extension ObservationModeExtension on ObservationMode {
  int get value => this.index ;
}

abstract class KinAccountReadOperationsAltIdioms {

  void getAccount({ bool forceUpdate = false , Callback<KinAccount> accountCallback }) ;

  Observer<KinBalance> observeBalance(ValueListener<KinBalance> balanceListener, { ObservationMode mode = ObservationMode.Passive });

  void clearStorage(Callback<bool> clearCompleteCallback);
}

abstract class KinAccountReadOperations extends KinAccountReadOperationsAltIdioms {

  Future<KinAccount> getAccountAsFutureMayForceUpdate({ bool forceUpdate = false }) ;

  Future<KinAccount> getAccountAsFuture() ;

  Observer<KinBalance> observeBalanceNoBalanceListener( { ObservationMode mode = ObservationMode.Passive }) ;

  Future<bool> clearStorageNoCallback();

}

abstract class KinPaymentReadOperationsAltIdioms {

  ListObserver<KinPayment> observePayments(ValueListener<List<KinPayment>> paymentsListener, { ObservationMode mode = ObservationMode.Passive });

  void getPaymentsForTransactionHash(TransactionHash transactionHash, Callback<List<KinPayment>> paymentsCallback);

}


abstract class  KinPaymentReadOperations implements KinPaymentReadOperationsAltIdioms {

  Future<QuarkAmount> calculateFee(int numberOfOperations);

  ListObserver<KinPayment> observePaymentsNoPaymentsListener({ObservationMode mode = ObservationMode.Passive});

  Future<List<KinPayment>> getPaymentsForTransactionHashNoCallback(TransactionHash transactionHash);
}

abstract class KinPaymentWriteOperationsAltIdioms {
  void sendKinPayment(
      KinAmount amount,
      KinAccountId destinationAccount,
      KinMemo memo /* = KinMemo.none */,
      Invoice invoice,
      Callback<KinPayment> paymentCallback);

  void sendKinPayments(
      List<KinPaymentItem> payments,
      KinMemo memo /* = KinMemo.none */,
      Callback<List<KinPayment>> paymentsCallback);
}


abstract class KinPaymentWriteOperations implements KinPaymentWriteOperationsAltIdioms {

  AppInfoProvider appInfoProvider ;

  Future<KinPayment> payInvoice(Invoice invoice,
      KinAccountId destinationAccount,
      AppIdx processingAppIdx
      /* = appInfoProvider?.appInfo?.appIndex?: throw RuntimeException("Need to specify an AppIdx") */,
      TransferType type /* = TransferType.spend */);

  Future<KinPayment> sendKinPaymentToAccount(KinAmount amount,
      KinAccountId destinationAccount,
      KinMemo memo /* = KinMemo.NONE */,
      Invoice invoice);

  Future<List<KinPayment>> sendKinPaymentsByAccountSpec(
      List<KinPaymentItem>payments,
      KinMemo memo /*= KinMemo.NONE */,
      AccountSpec sourceAccountSpec /* = AccountSpec.Preferred*/,
      AccountSpec destinationAccountSpec /*= AccountSpec.Preferred */,);

  @Deprecated("Don't use this version of sendKinPayments")
  Future<List<KinPayment>> sendKinPaymentsWithAdditionalSignatures(
    List<KinPaymentItem> payments,
    KinMemo memo,
    AccountSpec sourceAccountSpec,
    AccountSpec destinationAccountSpec,
    List<XdrDecoratedSignature> additionalSignatures,
    QuarkAmount feeOverride,
  );

  Future<List<KinPayment>> sendKinTransaction(
      Future<KinTransaction> Function() buildTransaction);
}


abstract class  KinAccountContextReadOnly extends KinAccountReadOperations implements KinPaymentReadOperations {
  KinAccountId get accountId ;
}


abstract class KinAccountContext implements KinAccountContextReadOnly , KinPaymentWriteOperations {

}

class KinAccountContextBuilder {
  KinEnvironment environment ;

  KinAccountContextBuilder(this.environment);

  KinAccountContext createNewAccount() => KinAccountContextImpl.newAccount(environment);

}

class KinAccountContextReadOnlyImpl extends KinAccountContextBase implements KinAccountContextReadOnly {
  KinAccountContextReadOnlyImpl(ExecutorServices executors, KinService service,
      Storage storage, KinAccountId accountId, KinLoggerFactory logger) :
        super(executors, service, storage, accountId, logger);


  Future<KinAccount> getAccount({ bool forceUpdate = false , Callback<KinAccount> accountCallback }) async {
    log.log("getAccount");

    var storedAccount = storage.getStoredAccount(accountId);
    if (forceUpdate) {
      return storedAccount;
    }

    return storedAccount;
  }

  /*

    override fun getAccount(forceUpdate: Boolean): Promise<KinAccount> {
        log.log("getAccount")
        return storage.getStoredAccount(accountId)
            .flatMap {
                it.map { storedAccount ->
                    if (!forceUpdate) Promise.of(storedAccount)
                    else maybeFetchAccountDetails()
                }.orElse {
                    maybeFetchAccountDetails()
                }
            }
    }
   */
}


class KinAccountContextBase implements KinAccountReadOperations , KinPaymentReadOperations {

  ExecutorServices executors;
  KinService service;
  Storage storage;
  KinAccountId accountId;
  KinLoggerFactory logger;

  KinAccountContextBase(this.executors, this.service, this.storage, this.accountId, this.logger);

  KinLogger _log ;
  KinLogger get log {
    _log ??= logger.getLogger('$runtimeType') ;
    return _log ;
  }

  @override
  Future<QuarkAmount> calculateFee(int numberOfOperations) {
    // TODO: implement calculateFee
    throw UnimplementedError();
  }

  @override
  void clearStorage(clearCompleteCallback) {
    // TODO: implement clearStorage
  }

  @override
  Future<bool> clearStorageNoCallback() {
    // TODO: implement clearStorageNoCallback
    throw UnimplementedError();
  }


  @override
  Future<KinAccount> getAccountAsFuture() {
    // TODO: implement getAccountAsFuture
    throw UnimplementedError();
  }

  @override
  Future<KinAccount> getAccountAsFutureMayForceUpdate({bool forceUpdate = false}) {
    // TODO: implement getAccountAsFutureMayForceUpdate
    throw UnimplementedError();
  }

  @override
  void getPaymentsForTransactionHash(TransactionHash transactionHash, paymentsCallback) {
    // TODO: implement getPaymentsForTransactionHash
  }

  @override
  Future<List<KinPayment>> getPaymentsForTransactionHashNoCallback(TransactionHash transactionHash) {
    // TODO: implement getPaymentsForTransactionHashNoCallback
    throw UnimplementedError();
  }

  @override
  Observer<KinBalance> observeBalance(ValueListener<KinBalance> balanceListener, {ObservationMode mode = ObservationMode.Passive}) {
    // TODO: implement observeBalance
    throw UnimplementedError();
  }

  @override
  Observer<KinBalance> observeBalanceNoBalanceListener({ObservationMode mode = ObservationMode.Passive}) {
    // TODO: implement observeBalanceNoBalanceListener
    throw UnimplementedError();
  }

  @override
  ListObserver<KinPayment> observePayments(ValueListener<List<KinPayment>> paymentsListener, {ObservationMode mode = ObservationMode.Passive}) {
    // TODO: implement observePayments
    throw UnimplementedError();
  }

  @override
  ListObserver<KinPayment> observePaymentsNoPaymentsListener({ObservationMode mode = ObservationMode.Passive}) {
    // TODO: implement observePaymentsNoPaymentsListener
    throw UnimplementedError();
  }

  @override
  void getAccount({ bool forceUpdate = false , Callback<KinAccount> accountCallback }) {
    // TODO: implement getAccount
  }

  Future<KinAccount> maybeFetchAccountDetails() async {
    var response = await service.retrieveAccount(accountId.stellarBase32Encode()) ;

    KinAccount();
    storage.updateAccountInStorage( response.accountInfo.accountId ) ;
  }

  /*
fun maybeFetchAccountDetails(): Promise<KinAccount> =
        service.getAccount(accountId)
            .flatMap { storage.updateAccountInStorage(it) }
            .onErrorResumeNext(KinService.FatalError.ItemNotFound.javaClass) {
                service.resolveTokenAccounts(accountId)
                    .flatMap { accounts ->
                        val maybeResolvedAccountId =
                            accounts.firstOrNull()?.asKinAccountId() ?: accountId
                        service.getAccount(maybeResolvedAccountId)
                            .map {
                                if (maybeResolvedAccountId != accountId) {
                                    // b/c we want to update our on hand account with the resolved accountInfo details on solana
                                    it.copy(
                                        id = accountId,
                                        key = Key.PublicKey(accountId.value),
                                        tokenAccounts = accounts,
                                    )
                                } else it
                            }
                            .flatMap { storage.updateAccountInStorage(it) }
                    }
            }
   */

}


class KinAccountContextImpl extends KinAccountContextBase with KinAccountContext {

  @override
  AppInfoProvider appInfoProvider;

  KinAccountContextImpl._(executors, KinService service, Storage storage,
      KinAccountId accountId, this.appInfoProvider, KinLoggerFactory logger)
      : super(executors, service, storage, accountId, logger);

  factory KinAccountContextImpl.newAccount(KinEnvironment env) {
    var privateKey = PrivateKey.fromBytes( KeyPair.random().privateKey ) ;
    var newAccount = KinAccount(privateKey);
    env.storage.addAccount(newAccount);

    var envAgora = KinEnvironment as KinEnvironmentAgora ;

    return KinAccountContextImpl._(
        env.executors,
        env.service,
        env.storage,
        newAccount.id,
        envAgora?.appInfoProvider,
        env.logger
    );
  }

  @override
  Future<QuarkAmount> calculateFee(int numberOfOperations) {
    // TODO: implement calculateFee
    throw UnimplementedError();
  }

  @override
  void clearStorage(clearCompleteCallback) {
    // TODO: implement clearStorage
  }

  @override
  Future<bool> clearStorageNoCallback() {
    // TODO: implement clearStorageNoCallback
    throw UnimplementedError();
  }

  @override
  void getAccount(accountCallback, {bool forceUpdate = false}) {
    // TODO: implement getAccount
  }

  @override
  Future<KinAccount> getAccountAsFuture() {
    // TODO: implement getAccountAsFuture
    throw UnimplementedError();
  }

  @override
  Future<KinAccount> getAccountAsFutureMayForceUpdate({bool forceUpdate = false}) {
    // TODO: implement getAccountAsFutureMayForceUpdate
    throw UnimplementedError();
  }

  @override
  void getPaymentsForTransactionHash(TransactionHash transactionHash, paymentsCallback) {
    // TODO: implement getPaymentsForTransactionHash
  }

  @override
  Future<List<KinPayment>> getPaymentsForTransactionHashNoCallback(TransactionHash transactionHash) {
    // TODO: implement getPaymentsForTransactionHashNoCallback
    throw UnimplementedError();
  }

  @override
  Observer<KinBalance> observeBalance(ValueListener<KinBalance> balanceListener, {ObservationMode mode = ObservationMode.Passive}) {
    // TODO: implement observeBalance
    throw UnimplementedError();
  }

  @override
  Observer<KinBalance> observeBalanceNoBalanceListener({ObservationMode mode = ObservationMode.Passive}) {
    // TODO: implement observeBalanceNoBalanceListener
    throw UnimplementedError();
  }

  @override
  ListObserver<KinPayment> observePayments(ValueListener<List<KinPayment>> paymentsListener, {ObservationMode mode = ObservationMode.Passive}) {
    // TODO: implement observePayments
    throw UnimplementedError();
  }

  @override
  ListObserver<KinPayment> observePaymentsNoPaymentsListener({ObservationMode mode = ObservationMode.Passive}) {
    // TODO: implement observePaymentsNoPaymentsListener
    throw UnimplementedError();
  }

  @override
  Future<KinPayment> payInvoice(Invoice invoice, KinAccountId destinationAccount, AppIdx processingAppIdx, TransferType type) {
    // TODO: implement payInvoice
    throw UnimplementedError();
  }

  @override
  void sendKinPayment(KinAmount amount, KinAccountId destinationAccount, KinMemo memo, Invoice invoice, paymentCallback) {
    // TODO: implement sendKinPayment
  }

  @override
  Future<KinPayment> sendKinPaymentToAccount(KinAmount amount, KinAccountId destinationAccount, KinMemo memo, Invoice invoice) {
    // TODO: implement sendKinPaymentToAccount
    throw UnimplementedError();
  }

  @override
  void sendKinPayments(List<KinPaymentItem> payments, KinMemo memo, paymentsCallback) {
    // TODO: implement sendKinPayments
  }

  @override
  Future<List<KinPayment>> sendKinPaymentsByAccountSpec(List<KinPaymentItem> payments, KinMemo memo, AccountSpec sourceAccountSpec, AccountSpec destinationAccountSpec) {
    // TODO: implement sendKinPaymentsByAccountSpec
    throw UnimplementedError();
  }

  @override
  Future<List<KinPayment>> sendKinPaymentsWithAdditionalSignatures(List<KinPaymentItem> payments, KinMemo memo, AccountSpec sourceAccountSpec, AccountSpec destinationAccountSpec, List<XdrDecoratedSignature> additionalSignatures, QuarkAmount feeOverride) {
    // TODO: implement sendKinPaymentsWithAdditionalSignatures
    throw UnimplementedError();
  }

  @override
  Future<List<KinPayment>> sendKinTransaction(Future Function() buildTransaction) {
    // TODO: implement sendKinTransaction
    throw UnimplementedError();
  }


}



