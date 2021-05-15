import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/stellar_base_type_conversions.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/network/api/agora/grpc_api.dart';
import 'package:kin_base/base/network/api/agora/model_to_proto.dart';
import 'package:kin_base/base/network/api/kin_transaction_api.dart';

import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as model_v3;
import 'package:kin_base/models/agora/protobuf/transaction/v3/transaction_service.pb.dart';
import 'package:kin_base/models/agora/protobuf/transaction/v3/transaction_service.pbgrpc.dart';

import 'proto_to_model.dart';

class AgoraKinTransactionsApi extends GrpcApi implements KinTransactionApi {
  NetworkEnvironment networkEnvironment;

  final TransactionClient _transactionClient;

  AgoraKinTransactionsApi(
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
        accountId: accountId.toProtoStellarAccountId(),
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

  @override
  Future<KinServiceResponse<KinTransaction>> getTransaction(TransactionHash transactionHash) async {
    var request = GetTransactionRequest()..transactionHash = model_v3.TransactionHash(value: transactionHash.rawValue);
    var response = await _transactionClient.getTransaction(request);

    if (response.state == GetTransactionResponse_State.SUCCESS) {
      var transaction = response.item.toHistoricalKinTransaction(networkEnvironment);
      return KinServiceResponse(KinServiceResponseType.ok, transaction);
    }
    else if (response.state == GetTransactionResponse_State.UNKNOWN) {
      return KinServiceResponse(KinServiceResponseType.notFound);
    }
    else {
      return KinServiceResponse(KinServiceResponseType.notFound);
    }
  }

  @override
  Future<KinServiceResponse<QuarkAmount>> getTransactionMinFee() async {
    return KinServiceResponse(KinServiceResponseType.ok, QuarkAmount(100));
  }

}
