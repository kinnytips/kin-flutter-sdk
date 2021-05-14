import 'package:grpc/grpc.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/network/api/agora/grpc_api.dart';
import 'package:kin_base/base/network/api/agora/model_to_proto_v4.dart';
import 'package:kin_base/base/network/api/kin_transaction_api_v4.dart';
import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pb.dart';
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pbgrpc.dart';

import 'package:kin_base/base/tools/extensions.dart';

import 'proto_to_model.dart';
import 'proto_to_model_v4.dart';

class AgoraKinTransactionsApiV4 extends GrpcApi implements KinTransactionApiV4 {
  NetworkEnvironment networkEnvironment;

  final TransactionClient _transactionClient;

  AgoraKinTransactionsApiV4(
      ClientChannel managedChannel, this.networkEnvironment)
      : _transactionClient = TransactionClient(managedChannel),
        super(managedChannel);

  @override
  Future<KinServiceResponse<List<KinTransaction>>> getTransactionHistory(
    KinAccountId accountId, {
    PagingToken pagingToken,
    KinServiceOrder order = KinServiceOrder.descending,
  }) async {
    var request = GetHistoryRequest(
        accountId: accountId.toProtoSolanaAccountId(),
        cursor: pagingToken.toProtoCursor());

    var history = await _transactionClient.getHistory(request);

    if ( history.result == GetHistoryResponse_Result.OK ) {
      var transactions = history.items.map((e) => e.toHistoricalKinTransaction(networkEnvironment)).toList().requireNoNulls();
      return KinServiceResponse(KinServiceResponseType.ok, transactions);
    }
    else if ( history.result == GetHistoryResponse_Result.NOT_FOUND ) {
      return KinServiceResponse(KinServiceResponseType.notFound);
    }
    else {
      return KinServiceResponse(KinServiceResponseType.undefinedError, null, UnrecognizedResultException(UnrecognizedProtoResponse()) );
    }

  }
}
