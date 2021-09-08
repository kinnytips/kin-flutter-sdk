import 'package:grpc/grpc.dart';
import 'package:kin_base/models/agora/protobuf/common/v4/model.pb.dart';
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pbgrpc.dart';
import 'package:kin_base/models/app/interfaces/status.dart';
import 'package:kin_base/models/app/sdk/constants.dart';
import 'package:kin_base/models/app/transaction/submit_kin_transaction_response.dart';
import 'package:kin_base/models/app/transaction/transaction_history_response.dart';
import 'package:logging/logging.dart';

class TransactionService {
  final log = Logger('TransactionService');
  final String endpoint;

  TransactionService(this.endpoint);

  Future<SubmitKinTransactionResponse> submitTransaction(
    double amount,
    String destinationAddress,
    double fee,
  ) async {
    // TODO add the transaction class to submit the transaction
    var transaction = SubmitTransactionRequest();
    try {
      await TransactionClient(ClientChannel(endpoint))
          .submitTransaction(transaction)
          .timeout(Duration(seconds: 10));

      // TODO map the values received in the response
      return SubmitKinTransactionResponse(
        Constants.meta,
        Status(
          Result.SUCCESS,
          "Account is retrieved.",
        ),
      );
    } catch (e) {
      log.severe("Error submitting the transaction: " + e.toString());
      return SubmitKinTransactionResponse(
        Constants.meta,
        Status(
          Result.FAIL,
          e.toString(),
        ),
      );
    }
  }

  Future<TransactionHistoryResponse> getTransactionHistory(
      String accountId) async {
    // TODO create the history request with the values it needs
    // TODO Convert String id to byte array
    // TODO SolanaAccountId needs string id converted to ByteArrays
    var request = GetHistoryRequest()..accountId = SolanaAccountId();
    try {
      await TransactionClient(ClientChannel(endpoint))
          .getHistory(request)
          .timeout(Duration(seconds: 10));

      // TODO map the values received in the response
      return TransactionHistoryResponse(
        Constants.meta,
        Status(
          Result.SUCCESS,
          "Account is retrieved.",
        ),
      );
    } catch (e) {
      log.severe("Error retrieving the transaction history: " + e.toString());
      return TransactionHistoryResponse(
        Constants.meta,
        Status(
          Result.FAIL,
          e.toString(),
        ),
      );
    }
  }
}
