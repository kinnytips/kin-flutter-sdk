
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

  @override
  String toString() {
    return 'ServiceConfig{subsidizerAccount: $subsidizerAccount, tokenProgram: $tokenProgram, token: $token}';
  }
}

abstract class KinTransactionApiV4 implements KinTransactionApi {
  Future<KinServiceInvoiceResponse<KinTransaction>> submitTransaction(
      Transaction transaction, InvoiceList? invoiceList);

  Future<KinServiceResponse<ServiceConfig>> getServiceConfig();

  Future<KinServiceResponse<int>> getMinKinVersion();

  Future<KinServiceResponse<Hash>> getRecentBlockHash();

  Future<KinServiceResponse<int>> getMinimumBalanceForRentExemption(
      int size);
}
