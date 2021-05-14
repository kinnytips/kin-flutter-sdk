import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';

abstract class KinTransactionApi {

  Future<KinServiceResponse<List<KinTransaction>>> getTransactionHistory(
      KinAccountId accountId, {
        PagingToken pagingToken,
        KinServiceOrder order = KinServiceOrder.descending,
      });

  void getTransaction(
    GetTransactionRequest request,
    void Function( GetTransactionResponse response ) onCompleted
  ) ;

  void getTransactionMinFee(
    void Function( GetMinFeeForTransactionResponse response ) onCompleted
  );

  void submitTransaction(
    SubmitTransactionRequest request,
    void Function( SubmitTransactionResponse response ) onCompleted
  );

}