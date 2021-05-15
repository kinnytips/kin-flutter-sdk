import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/stellar_base_type_conversions.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/network/api/agora/grpc_api.dart';
import 'package:kin_base/base/network/api/agora/model_to_proto_v4.dart';
import 'package:kin_base/base/network/api/kin_transaction_api_v4.dart';
import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/models/agora/protobuf/common/v4/model.pb.dart' as model_v4;
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pb.dart';
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pbgrpc.dart';

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

  @override
  Future<KinServiceResponse<int>> getMinKinVersion() async {
    var response = await _transactionClient.getMinimumKinVersion(GetMinimumKinVersionRequest());
    return KinServiceResponse(KinServiceResponseType.ok, response.version);
  }

  @override
  Future<KinServiceResponse<int>> getMinimumBalanceForRentExemption(int size) async {
    var response = await _transactionClient.getMinimumBalanceForRentExemption(GetMinimumBalanceForRentExemptionRequest(size: Int64(size)));
    return KinServiceResponse(KinServiceResponseType.ok, response.lamports.toInt());
  }

  @override
  Future<KinServiceResponse<Hash>> getRecentBlockHash() async {
    var response = await _transactionClient.getRecentBlockhash(GetRecentBlockhashRequest());
    return KinServiceResponse(KinServiceResponseType.ok, response.blockhash.toModel());
  }

  @override
  Future<KinServiceResponse<ServiceConfig>> getServiceConfig() async {
    var response =
        await _transactionClient.getServiceConfig(GetServiceConfigRequest());
    return KinServiceResponse(
        KinServiceResponseType.ok,
        ServiceConfig(
            response.subsidizerAccount.toPublicKey().asKinAccountId(),
            response.tokenProgram.toPublicKey().asKinAccountId(),
            response.token.toPublicKey().asKinAccountId()));
  }

  @override
  Future<KinServiceResponse<KinTransaction>> getTransaction(TransactionHash transactionHash) async {
    var request = GetTransactionRequest()..transactionId = model_v4.TransactionId(value: transactionHash.rawValue);
    var response = await _transactionClient.getTransaction(request);

    if (response.state == GetTransactionResponse_State.SUCCESS) {
      var transaction = response.item.toHistoricalKinTransaction(networkEnvironment);
      return KinServiceResponse(KinServiceResponseType.ok, transaction);
    }
    else if (response.state == GetTransactionResponse_State.UNKNOWN) {
      return KinServiceResponse(KinServiceResponseType.notFound);
    }
    else if (response.state == GetTransactionResponse_State.FAILED ) {
      return KinServiceResponse(KinServiceResponseType.undefinedError, null, Exception('Result.Failed') );
    }
    else if (response.state == GetTransactionResponse_State.PENDING ) {
      var transaction = response.item.toAcknowledgedKinTransaction(networkEnvironment);
      return KinServiceResponse(KinServiceResponseType.ok, transaction);
    }
    else {
      return KinServiceResponse(KinServiceResponseType.notFound);
    }
  }

  @override
  Future<KinServiceResponse<QuarkAmount>> getTransactionMinFee() async {
    // TODO: implement getTransactionMinFee
    throw UnimplementedError();
  }

  @override
  Future<KinServiceInvoiceResponse<KinTransaction>> submitTransaction(Transaction transaction, InvoiceList invoiceList) async {
    // TODO: implement submitTransaction
    throw UnimplementedError();
  }
}
