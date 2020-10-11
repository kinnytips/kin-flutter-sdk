import 'package:grpc/grpc.dart';
import 'package:kin_sdk/models/application/account_history_response.dart';
import 'package:kin_sdk/models/application/account_transaction_response.dart';
import 'package:kin_sdk/models/gen/common/v3/model.pb.dart';
import 'package:kin_sdk/models/gen/transaction/v3/transaction_service.pb.dart';
import 'package:kin_sdk/models/gen/transaction/v3/transaction_service.pbgrpc.dart';
import 'package:logging/logging.dart';

class TransactionService {
  final log = Logger('TransactionService');
  final String endpoint;

  TransactionService(this.endpoint);

  Future<AccountHistoryResponse> getAccountHistory(String accountId) async {
    var getHistoryRequest = GetHistoryRequest()
      ..accountId = (StellarAccountId()..value = accountId);
    if (getHistoryRequest.hasAccountId()) {
      try {
        var response = await TransactionClient(ClientChannel(endpoint))
            .getHistory(getHistoryRequest)
            .timeout(Duration(seconds: 10));
        return AccountHistoryResponse(true, response.result, response.items);
      } catch (e) {
        log.severe("Error fetching account history" + e.toString());
        return AccountHistoryResponse(
            false, GetHistoryResponse_Result.NOT_FOUND, []);
      }
    } else {
      log.severe("Account id is not available");
      return AccountHistoryResponse(
          false, GetHistoryResponse_Result.NOT_FOUND, []);
    }
  }

  Future<AccountTransactionResponse> getTransaction(int transactionId) async {
    var getTransactionRequest = GetTransactionRequest()
      ..transactionHash = (TransactionHash()..value = [transactionId]);
    if (getTransactionRequest.hasTransactionHash()) {
      try {
        var response = await TransactionClient(ClientChannel(endpoint))
            .getTransaction(getTransactionRequest)
            .timeout(Duration(seconds: 10));
        return AccountTransactionResponse(
            true, response.item, response.ledger.toInt64());
      } catch (e) {
        log.severe("Error fetching transaction" + e.toString());
        return AccountTransactionResponse(false, null, null);
      }
    } else {
      log.severe("Transaction hash is not  available");
      return AccountTransactionResponse(false, null, null);
    }
  }
}
