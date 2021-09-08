
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';

abstract class KinTransactionApi {
  Future<KinServiceResponse<List<KinTransaction>>> getTransactionHistory(
    KinAccountId accountId, {
    PagingToken? pagingToken,
    KinServiceOrder order = KinServiceOrder.descending,
  });

  Future<KinServiceResponse<KinTransaction>> getTransaction(
      TransactionHash transactionHash);

  Future<KinServiceResponse<QuarkAmount>> getTransactionMinFee();

  /* Won't be implemented! Only `KinTransactionApiV4.submitTransaction` will be.
  Future<KinServiceInvoiceResponse<KinTransaction>> submitTransaction(
      Uint8List transactionEnvelopeXdr, InvoiceList invoiceList);
   */
}
