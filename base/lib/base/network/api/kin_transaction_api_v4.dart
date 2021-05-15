
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';

import 'kin_transaction_api.dart';

class ServiceConfig {
  final KinAccountId subsidizerAccount;

  /** TODO: (fom kin-android) remove these two after we've locked in some tokens **/
  final KinAccountId tokenProgram ;
  final KinAccountId token ;

  ServiceConfig(this.subsidizerAccount, this.tokenProgram, this.token);
}

abstract class KinTransactionApiV4 implements KinTransactionApi {
  Future<KinServiceInvoiceResponse<KinTransaction>> submitTransaction(
      Transaction transaction, InvoiceList invoiceList);

  Future<KinServiceInvoiceResponse<ServiceConfig>> getServiceConfig();

  Future<KinServiceInvoiceResponse<int>> getMinKinVersion();

  Future<KinServiceInvoiceResponse<Hash>> getRecentBlockHash();

  Future<KinServiceInvoiceResponse<int>> getMinimumBalanceForRentExemption(
      int size);
}
