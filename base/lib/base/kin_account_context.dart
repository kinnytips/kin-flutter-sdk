import 'dart:collection';
import 'dart:typed_data';

import 'package:decimal/decimal.dart';
import 'package:kin_base/base/kin_environment.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/models/stellar_base_type_conversions.dart';
import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/tools/kin_logger.dart';
import 'package:kin_base/base/tools/network_operations_handler.dart';
import 'package:kin_base/base/tools/observers.dart';
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
import 'tools/extensions.dart';

enum ObservationMode {
  Passive,
  Active,
  ActiveNewOnly,
}

extension ObservationModeExtension on ObservationMode {
  int get value => this.index ;
}

abstract class KinAccountReadOperationsAltIdioms {

  Observer<KinBalance> observeBalance({ ObservationMode mode = ObservationMode.Passive , ValueListener<KinBalance> balanceListener });

  void clearStorage(Callback<bool> clearCompleteCallback);
}

abstract class KinAccountReadOperations extends KinAccountReadOperationsAltIdioms {

  Future<KinAccount> getAccount({ bool forceUpdate = false , Callback<KinAccount> accountCallback }) ;

  Future<KinAccount> getAccountAsFutureMayForceUpdate({ bool forceUpdate = false }) ;

  Future<KinAccount> getAccountAsFuture() ;

  Observer<KinBalance> observeBalanceNoBalanceListener( { ObservationMode mode = ObservationMode.Passive }) ;

  Future<bool> clearStorageNoCallback();

}

abstract class KinPaymentReadOperationsAltIdioms {

  ListObserver<KinPayment> observePayments({ ObservationMode mode = ObservationMode.Passive , ValueListener<List<KinPayment>> paymentsListener });

  void getPaymentsForTransactionHash(TransactionHash transactionHash, Callback<List<KinPayment>> paymentsCallback);

}


abstract class  KinPaymentReadOperations implements KinPaymentReadOperationsAltIdioms {

  Future<QuarkAmount> calculateFee(int numberOfOperations);

  ListObserver<KinPayment> observePaymentsNoPaymentsListener({ObservationMode mode = ObservationMode.Passive});

  Future<List<KinPayment>> getPaymentsForTransactionHashNoCallback(TransactionHash transactionHash);
}

abstract class KinPaymentWriteOperationsAltIdioms {
  Future<KinPayment> sendKinPayment(
      KinAmount amount,
      KinAccountId destinationAccount,
      {KinMemo memo, Invoice invoice});

  Future<List<KinPayment>> sendKinPayments(
      List<KinPaymentItem> payments,
      {KinMemo memo});
}


abstract class KinPaymentWriteOperations implements KinPaymentWriteOperationsAltIdioms {

  AppInfoProvider appInfoProvider ;

  Future<KinPayment> payInvoice(Invoice invoice,
      KinAccountId destinationAccount,
      AppIdx processingAppIdx
      /* = appInfoProvider?.appInfo?.appIndex?: throw RuntimeException("Need to specify an AppIdx") */,
      TransferType type /* = TransferType.spend */);

  Future<List<KinPayment>> sendKinPaymentsByAccountSpec(
      List<KinPaymentItem>payments,
      KinMemo memo /*= KinMemo.NONE */,
      {AccountSpec sourceAccountSpec /* = AccountSpec.Preferred*/,
      AccountSpec destinationAccountSpec /*= AccountSpec.Preferred */,
      List<XdrDecoratedSignature> additionalSignatures,
      QuarkAmount feeOverride});

  Future<List<KinPayment>> sendKinTransaction(
      Future<KinTransaction> Function() buildTransaction);
}


abstract class  KinAccountContextReadOnly extends KinAccountReadOperations implements KinPaymentReadOperations {
  KinAccountId get accountId ;
}


abstract class KinAccountContext implements KinAccountContextReadOnly , KinPaymentWriteOperations {

  factory KinAccountContext.newAccount(KinEnvironment env) {
    return KinAccountContextImpl.newAccount(env);
  }

  factory KinAccountContext.useExistingAccount(KinEnvironment env, KinAccountId accountId) {
    return KinAccountContextImpl.existingAccount(env, accountId);
  }

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

  ValueSubject<KinBalance> _balanceSubject ;

  ValueSubject<KinBalance> get balanceSubject {
    if (_balanceSubject == null) {
      _balanceSubject = ValueSubject<KinBalance>() ;

      executors.parallelIO.execute(() async {
        var account = await getAccount();
        _balanceSubject.onNext(account.balance);
        fetchUpdatedBalance() ;
      });
    }
    return _balanceSubject ;
  }

  ListSubject<KinPayment> _paymentsSubject ;

  ListSubject<KinPayment> get paymentsSubject {
    if (_paymentsSubject == null) {
      _paymentsSubject = ListSubject<KinPayment>(
          () async {
            var page = await _requestNextPage() ;
            _paymentsSubject.onNext( page.asKinPayments() );
          },
          () async {
            var page = await _requestPreviousPage() ;
            _paymentsSubject.onNext( page.asKinPayments() );
          },
          () {
            executors.parallelIO.execute(() async {
              var transactions = await storage.getStoredTransactions(accountId);
              var items = transactions?.items ?? <KinTransaction>[] ;
              var payments = items.asKinPayments(true);
              _paymentsSubject.onNext(payments);
              fetchUpdatedTransactionHistory();
            });
          }
      ) ;
    }
    return _paymentsSubject ;
  }

  Future<List<KinTransaction>> fetchUpdatedTransactionHistory() async {
    var page = await _requestNextPage();
    paymentsSubject.onNext(page.asKinPayments(true));
    return page ;
  }

  Future<List<KinTransaction>> _requestNextPage() async {
    var transactions = await storage.getStoredTransactions(accountId);

    List<KinTransaction> newTransactions;
    if (transactions?.headPagingToken != null) {
      newTransactions = await service.getTransactionPage(
          accountId, transactions.headPagingToken, KinServiceOrder.ascending);
    } else {
      newTransactions = await service.getLatestTransactions(accountId);
    }

    await storage.upsertNewTransactionsInStorage(accountId, newTransactions);

    return newTransactions;
  }

  Future<List<KinTransaction>> _requestPreviousPage() async {
    var transactions = await storage.getStoredTransactions(accountId);

    List<KinTransaction> newTransactions;
    if (transactions?.tailPagingToken != null) {
      newTransactions = await service.getTransactionPage(
          accountId, transactions.tailPagingToken, KinServiceOrder.descending);
    } else {
      newTransactions = await service.getLatestTransactions(accountId);
    }

    storage.upsertOldTransactionsInStorage(accountId, newTransactions);

    return newTransactions;
  }

  Future<KinBalance> fetchUpdatedBalance() async {
    var account = await getAccount(forceUpdate: true);
    storage.updateAccountInStorage(account);
    balanceSubject.onNext(account.balance);
    return account.balance;
  }

  @override
  Future<QuarkAmount> calculateFee(int numberOfOperations) async {
    if (await service.canWhitelistTransactions()) {
      return KinAmount.zero.toQuarks();
    }
    else {
      var minFee = await storage.getMinFee();

      if (minFee == null) {
        minFee = await service.getMinFee();
        await storage.setMinFee(minFee);
      }

      return QuarkAmount(minFee.value * numberOfOperations);
    }
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
  Observer<KinBalance> observeBalance({ObservationMode mode = ObservationMode.Passive, ValueListener<KinBalance> balanceListener}) {
    log.log("observeBalance");
    _setupActiveStreamingUpdatesIfNecessary(balanceSubject, mode);
    balanceSubject.requestInvalidation();

    if (balanceListener != null) {
      balanceSubject.listen(balanceListener);
    }

    return balanceSubject ;
  }

  final DisposeBag _lifecycle = DisposeBag();
  Observer<KinAccount> _accountStream ;
  
  Observer<T>  _setupActiveStreamingUpdatesIfNecessary<T>(Observer<T> observer, ObservationMode mode) {
    switch (mode) {
      case ObservationMode.ActiveNewOnly:
      case ObservationMode.Active: {
        if (_accountStream == null) {
          service.streamAccount(accountId);
        }
      }
    }
    return observer ;
  }
  
  /*
  private fun <T> Observer<T>.setupActiveStreamingUpdatesIfNecessary(mode: ObservationMode): Observer<T> {
        when (mode) {
            ObservationMode.ActiveNewOnly,
            ObservationMode.Active -> {
                synchronized(streamLock) {
                    if (accountStream == null) {
                        accountStream = service.streamAccount(accountId).apply {
                            disposedBy(lifecycle)
                                .flatMapPromise { kinAccount ->
                                    storage.updateAccountInStorage(kinAccount)
                                        .map { it.balance }
                                        .doOnResolved { balance ->
                                            // Yea...this 5s delay is gross but reads aren't
                                            // deterministic with the account update events so
                                            // instead of polling (worse), we delay for a
                                            // 'best effort' history update.
                                            // TODO: Maybe we can do better with a future event for history updates.
                                            Promise.defer { fetchUpdatedTransactionHistory() }
                                                .doOnResolved { balanceSubject.onNext(balance) }
                                                .resolveIn(5, TimeUnit.SECONDS)
                                        }
                                }.resolve()
                        }

                        doOnDisposed {
                            lifecycle.dispose()
                            accountStream = null
                        }
                    }
                }
            }
        }
        return this
    }
   */

  @override
  Observer<KinBalance> observeBalanceNoBalanceListener({ObservationMode mode = ObservationMode.Passive}) {
    // TODO: implement observeBalanceNoBalanceListener
    throw UnimplementedError();
  }

  @override
  ListObserver<KinPayment> observePayments({ObservationMode mode = ObservationMode.Passive, ValueListener<List<KinPayment>> paymentsListener}) {
    if (mode == ObservationMode.Passive) {
      paymentsSubject.requestInvalidation();
      return paymentsSubject;
    }
    else if (mode == ObservationMode.Active) {
      paymentsSubject.requestInvalidation();
      _setupActiveStreamingUpdatesIfNecessary(paymentsSubject, mode);
      return paymentsSubject;
    }
    else if (mode == ObservationMode.ActiveNewOnly) {
      var listSubject = ListSubject<KinPayment>() ;
      var lifecycle = DisposeBag();
      
      var observer = service.streamNewTransactions(accountId);
      observer.disposedBy(lifecycle);
      observer.mapPromise((e) => e.asKinPayments() ).then((e) => listSubject.onNext(e));
      observer.doOnDisposed(() => lifecycle.dispose() );
      
      return listSubject ;
    }
    else {
      throw StateError("Can't handle mode: $mode");
    }
  }

  @override
  ListObserver<KinPayment> observePaymentsNoPaymentsListener({ObservationMode mode = ObservationMode.Passive}) {
    // TODO: implement observePaymentsNoPaymentsListener
    throw UnimplementedError();
  }

  Future<KinAccount> maybeFetchAccountDetails() async {
    try {
      var kinAccount = await service.getAccount(accountId);
      storage.updateAccountInStorage(kinAccount) ;
      return kinAccount ;
    }
    catch(e) {
      var accounts = await service.resolveTokenAccounts(accountId);

      var maybeResolvedAccountId = accounts != null && accounts.isNotEmpty ? accounts.first.asKinAccountId() : accountId ;

      var account2 = await service.getAccount(maybeResolvedAccountId) ;

      var accountResolved ;
      if (maybeResolvedAccountId != accountId) {
        // b/c we want to update our on hand account with the resolved accountInfo details on solana
        accountResolved = account2.copy(
          id: accountId,
          key: PublicKey.fromBytes(accountId.value),
          tokenAccounts: accounts,
        );

      } else {
        accountResolved = account2 ;
      }

      return storage.updateAccountInStorage(accountResolved) ;
    }
  }

  @override
  Future<KinAccount> getAccount({bool forceUpdate = false, accountCallback}) async {
    log.log("getAccount");

    var account = await storage.getStoredAccount(accountId);

    if ( account.status is KinAccountStatusUnregistered ) {
      return this._registerAccount(account);
    }
    else if ( account.status is KinAccountStatusRegistered ) {
      if (!forceUpdate) {
        return account ;
      }
      else {
        return maybeFetchAccountDetails() ;
      }
    }
    else {
      throw StateError("Unknown status: ${account.status}");
    }

  }

  Future<KinAccount> _registerAccount(KinAccount account) async {
    var accountReg = await service.createAccount(account.id, account.key) ;
    var accountToStore = account.merge(accountReg);

    if ( !storage.updateAccount(accountToStore) ) {
      throw StateError('Failed to store Account Data!');
    }

    return accountToStore ;
  }

}


class KinAccountContextImpl extends KinAccountContextBase with KinAccountContext {

  @override
  AppInfoProvider appInfoProvider;

  KinAccountContextImpl._(executors, KinService service, Storage storage,
      KinAccountId accountId, this.appInfoProvider, KinLoggerFactory logger)
      : super(executors, service, storage, accountId, logger);

  static Uint8List _generateRandomPrivateKey() {
    //var keyPair = KeyPair.fromSecretSeedBytes(Uint8List.fromList(List<int>.generate(32, (i) => i)));
    //return keyPair.privateKey;
    return KeyPair.random().privateKey;
  }

  factory KinAccountContextImpl.newAccount(KinEnvironment env) {
    var privateKey = PrivateKey.fromBytes( _generateRandomPrivateKey() ) ;
    var newAccount = KinAccount(privateKey);
    env.storage.addAccount(newAccount);

    var envAgora = env as KinEnvironmentAgora ;

    return KinAccountContextImpl._(
        env.executors,
        env.service,
        env.storage,
        newAccount.id,
        envAgora?.appInfoProvider,
        env.logger
    );
  }

  factory KinAccountContextImpl.existingAccount(KinEnvironment env, KinAccountId accountId) {
    var envAgora = env as KinEnvironmentAgora ;

    return KinAccountContextImpl._(
        env.executors,
        env.service,
        env.storage,
        accountId,
        envAgora?.appInfoProvider,
        env.logger
    );
  }

  @override
  Future<KinAccount> getAccount({bool forceUpdate = false, accountCallback}) async {
    log.log("getAccount");

    var storedAccount = await storage.getStoredAccount(accountId);

    if (storedAccount == null) {
      throw StateError("Private key missing for account with id: $accountId");
    }

    if ( storedAccount.status.value == KinAccountStatusUnregistered.defaultValue ) {
      try {
        return await _registerAccount(storedAccount);
      }
      catch(e,s) {
        log.error('Error registering account: $storedAccount', e, s);
        return maybeFetchAccountDetails() ;
      }
    }
    else if ( storedAccount.status.value == KinAccountStatusRegistered.defaultValue ) {
      if (!forceUpdate) {
        return storedAccount ;
      }
      else {
        return maybeFetchAccountDetails();
      }
    }
    else {
      throw StateError("Can't handle account.status: ${ storedAccount.status }");
    }

  }

  Future<KinAccount> _registerAccount(KinAccount account) async {
    var serviceAccount = await service.createAccount( account.id, account.key as PrivateKey ) ;
    var accountToStore = account.merge(serviceAccount);

    if (!storage.updateAccount(accountToStore)) {
      throw StateError("Failed to store Account Data!");
    } else {
      return accountToStore;
    }
  }

  @override
  Future<KinPayment> payInvoice(Invoice invoice, KinAccountId destinationAccount, AppIdx processingAppIdx, TransferType type) {
    // TODO: implement payInvoice
    throw UnimplementedError();
  }

  @override
  Future<KinPayment> sendKinPayment(KinAmount amount, KinAccountId destinationAccount, {KinMemo memo, Invoice invoice}) async {
    log.log("sendKinPayment");
    var ret = await sendKinPayments([KinPaymentItem(amount, destinationAccount, invoice)], memo: memo);
    return ret.single;
  }

  @override
  Future<List<KinPayment>> sendKinPayments(List<KinPaymentItem> payments, {KinMemo memo}) {
    return sendKinPaymentsByAccountSpec(payments, memo);
  }

  @override
  Future<List<KinPayment>> sendKinPaymentsByAccountSpec(List<KinPaymentItem> payments, KinMemo memo, { AccountSpec sourceAccountSpec, AccountSpec destinationAccountSpec , List<XdrDecoratedSignature> additionalSignatures, QuarkAmount feeOverride}) async {
    log.log("sendKinPayments");

    memo ??= KinMemo.none;

    var MAX_ATTEMPTS = 6;
    var FIXED_ATTEMPTS = 2;

    var invalidAccountErrorRetryStrategy = BackoffStrategy.combine([
      BackoffStrategyFixed(3000, FIXED_ATTEMPTS),
      BackoffStrategyExponentialIncrease(
        initial: 275,
        multiplier: 2.0,
        jitter: 1.0,
        maxAttempts: MAX_ATTEMPTS - FIXED_ATTEMPTS,
        maximumWaitTime: Duration(milliseconds: 60000),
      )
    ]);

    Error lastError ;
    for (var attemptCount = 0; attemptCount < MAX_ATTEMPTS; ++attemptCount) {
      try {
        return executors.parallelIO.execute(() async {
          return await sendKinTransaction(() => _buildPaymentTransaction(payments, memo, sourceAccountSpec, destinationAccountSpec, feeOverride, attemptCount));
        });
      }
      catch(e) {
        lastError = e ;

        if (e is BadSequenceNumberInRequestError) {
          service.invalidateBlockhashCache();
          continue;
        }
        else if (e is InsufficientFeeInRequestError) {
          var minFee = await service.getMinFee();
          storage.setMinFee(minFee);
          continue;
        }
        else if (e is UnknownAccountInRequestError) {
          var delay = invalidAccountErrorRetryStrategy.nextDelay();
          log.log("Waiting $delay ms...");
          await Future.delayed(Duration(milliseconds: delay)) ;
          continue;
        }
        else {
          rethrow ;
        }
      }
    }

    throw lastError ;
  }

  Future<KinTransaction> _buildPaymentTransaction(List<KinPaymentItem> payments, KinMemo memo, AccountSpec sourceAccountSpec, AccountSpec destinationAccountSpec , QuarkAmount feeOverride, int attemptCount,) async {
    var account = await getAccount();

    SourceAccountSigningData sourceAccount ;
    if ((attemptCount == 0 && account.tokenAccounts.isEmpty) || sourceAccountSpec == AccountSpec.Exact) {
      sourceAccount = SourceAccountSigningData(
          (account.status as KinAccountStatusRegistered)?.sequence ?? 0,
          account.key as PrivateKey,
          account.key.asPublicKey()
      );
    } else {
      var resolveTokenAccounts = await service.resolveTokenAccounts(accountId);

      var resolvedAccount = await storage.updateAccountInStorage(account.copy(tokenAccounts: resolveTokenAccounts));

      sourceAccount = SourceAccountSigningData(
          (resolvedAccount.status as KinAccountStatusRegistered)?.sequence ?? 0,
          resolvedAccount.key as PrivateKey,
          resolvedAccount.tokenAccounts.firstOrNull ?? resolvedAccount.key.asPublicKey()
      );
    }

    List<KinPaymentItem> paymentItems ;
    if (attemptCount == 0 || destinationAccountSpec == AccountSpec.Exact) {
      paymentItems = payments ;
    } else {
      paymentItems = await Future.wait( payments.map((paymentItem) async {
        var destinationTokenAccounts = await service.resolveTokenAccounts(paymentItem.destinationAccount);
        return paymentItem.copy(destinationAccount: destinationTokenAccounts.first.asKinAccountId());
      }));
    }

    var fee = await calculateFee(payments.length);

    var transaction = service.buildAndSignTransaction(
        sourceAccount.ownerKey,
        sourceAccount.sourceKey,
        sourceAccount.nonce,
        paymentItems,
        memo,
        feeOverride ?? fee
    );

    if (transaction is StellarKinTransaction) {
      throw UnsupportedError('Unsupported type: $transaction');
    }
    else {
      return transaction ;
    }
  }

  @override
  Future<List<KinPayment>> sendKinPaymentsWithAdditionalSignatures(List<KinPaymentItem> payments, KinMemo memo, AccountSpec sourceAccountSpec, AccountSpec destinationAccountSpec, List<XdrDecoratedSignature> additionalSignatures, QuarkAmount feeOverride) {
    // TODO: implement sendKinPaymentsWithAdditionalSignatures
    throw UnimplementedError();
  }

  final ExecutorService _outgoingTransactionsQueueIO = ExecutorService.createSequencial();

  @override
  Future<List<KinPayment>> sendKinTransaction(Future<KinTransaction> Function() buildTransaction) async {
    log.log('sendKinTransaction> $buildTransaction');

    var buildConsumed = false;

    var ret = _outgoingTransactionsQueueIO.execute(() async {
      var transaction = await buildTransaction();
      var expectedNewBalance = await _computeExpectedNewBalance(transaction);

      var submittedTransaction = await service.buildSignAndSubmitTransaction(() async {
        if (!buildConsumed) {
          buildConsumed = true ;
          return transaction ;
        } else {
          return buildTransaction();
        }
      }) ;

      storage.advanceSequence(accountId);

      await storage.insertNewTransactionInStorage(accountId, submittedTransaction) ;
      var payments = submittedTransaction.asKinPayments() ;

      if (_accountStream == null) {
        _storeAndNotifyOfBalanceUpdate(expectedNewBalance);
      }

      return payments ;
    });

    return ret ;
  }

  Future<KinBalance> _computeExpectedNewBalance(KinTransaction transaction) async {
    var account = await storage.getStoredAccount(accountId) ;
    if (account == null) return KinBalance();

    var kinPayments = transaction.asKinPayments() ;

    var amountToDeduct = transaction.fee.toKin();

    for (var payment in kinPayments.where((e) => e.destinationAccountId != accountId)) {
      amountToDeduct += payment.destinationAccountId != payment.sourceAccountId ? payment.amount : KinAmount.zero ;
    }

    var newAmount = account.balance.amount - amountToDeduct ;
    if ( newAmount.value < Decimal.zero ) newAmount = KinAmount.zero ;

    return account.balance.copy(
        amount: newAmount,
        pendingAmount: newAmount
    );
  }

  Future<void> _storeAndNotifyOfBalanceUpdate(KinBalance newBalance) async {
    var account = await storage.updateAccountBalance(accountId, newBalance) ;
    balanceSubject.onNext(account.balance);

    var transactions = await storage.getStoredTransactions(accountId);

    var items = transactions?.items ?? <KinTransaction>[] ;
    paymentsSubject.onNext(items.asKinPayments(true));
  }

}


class SourceAccountSigningData {
  int nonce;
  PrivateKey ownerKey;
  PublicKey sourceKey;

  SourceAccountSigningData(this.nonce, this.ownerKey, this.sourceKey);
}
