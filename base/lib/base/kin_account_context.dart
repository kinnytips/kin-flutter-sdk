import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/tools/kin_logger.dart';
import 'package:kin_base/base/tools/observers.dart';
import 'package:kin_base/services/kin_services.dart';
import 'package:kin_base/stellarfork/xdr/xdr_signing.dart';

import 'models/account_spec.dart';
import 'models/appidx.dart';
import 'models/invoices.dart';
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

enum ObservationMode {
  Passive,
  Active,
  ActiveNewOnly,
}

extension ObservationModeExtension on ObservationMode {
  int get value => this.index ;
}

abstract class KinAccountReadOperationsAltIdioms {

  void getAccount(Callback<KinAccount> accountCallback, { bool forceUpdate = false }) ;

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
  KinAccountId accountId ;
}


abstract class KinAccountContext implements KinAccountContextReadOnly , KinPaymentWriteOperations {

}

class KinAccountContextReadOnlyImpl extends KinAccountContextBase , KinAccountContextReadOnly {

}


class KinAccountContextBase implements KinAccountReadOperations , KinPaymentReadOperations {

  ExecutorServices executors;
  KinService service;
  Storage storage;
  KinAccountId accountId;
  KinLoggerFactory logger;


}




