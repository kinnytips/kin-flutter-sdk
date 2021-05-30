import 'package:decimal/decimal.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/solana/encoding.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/stellar_base_type_conversions.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/network/api/agora/grpc_api.dart';
import 'package:kin_base/base/network/api/agora/model_to_proto.dart';
import 'package:kin_base/base/network/api/agora/model_to_proto_v4.dart';
import 'package:kin_base/base/network/api/api_helpers.dart';
import 'package:kin_base/base/network/api/kin_account_api_v4.dart';
import 'package:kin_base/base/network/api/kin_account_creation_api_v4.dart';
import 'package:kin_base/base/network/api/kin_streaming_api_v4.dart';
import 'package:kin_base/base/network/api/kin_transaction_api_v4.dart';
import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/stellar/models/result_code.dart';
import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/base/tools/observers.dart';
import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pbgrpc.dart';
import 'package:kin_base/models/agora/protobuf/common/v4/model.pb.dart' as model_v4;
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pb.dart';
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pbgrpc.dart';

import 'proto_to_model_v4.dart';


class AgoraKinAccountCreationApiV4 extends GrpcApi implements KinAccountCreationApiV4 {

  final AccountClient _accountClient ;

  AgoraKinAccountCreationApiV4(ClientChannel managedChannel)
      : _accountClient = AccountClient(managedChannel),
        super(managedChannel) ;

  @override
  Future<KinServiceResponse<KinAccount>> createAccount(KinAccountId accountId) {
    throw UnsupportedError('Only for V3 protocol');
  }

  @override
  Future<KinServiceResponse<KinAccount>> createAccountV4(Transaction transaction) async {
    var request = CreateAccountRequest(
      commitment: model_v4.Commitment.SINGLE,
      transaction: model_v4.Transaction(value: transaction.marshal()),
    );

    var response = await _accountClient.createAccount(request);

    if ( response.result == CreateAccountResponse_Result.OK ) {
      var account = response.accountInfo.toKinAccount() ;
      return KinServiceResponse( KinServiceResponseType.ok , account );
    }
    else if ( response.result == CreateAccountResponse_Result.EXISTS ) {
      return KinServiceResponse( KinServiceResponseType.exists );
    }
    else {
      return KinServiceResponse( KinServiceResponseType.undefinedError );
    }
  }

}

class AgoraKinAccountApiV4 extends GrpcApi implements KinAccountApiV4, KinStreamingApiV4 {
  NetworkEnvironment networkEnvironment;

  final AccountClient _accountClient;

  AgoraKinAccountApiV4(ClientChannel managedChannel, this.networkEnvironment) :
        _accountClient = AccountClient(managedChannel),
        super(managedChannel);

  @override
  Future<KinServiceResponse<KinAccount>> getAccount(KinAccountId accountId) async {
    try {
      model_v4.Commitment commitment = model_v4.Commitment.SINGLE;

      var request = new GetAccountInfoRequest(
          accountId: accountId.toProtoSolanaAccountId(),
          commitment: commitment);

      var account = await _accountClient.getAccountInfo(request);

      if (account.result == GetAccountInfoResponse_Result.OK) {
        var accountInfo = account.accountInfo.toKinAccount();
        return KinServiceResponse(KinServiceResponseType.ok, accountInfo);
      }
      else if (account.result == GetAccountInfoResponse_Result.NOT_FOUND) {
        return KinServiceResponse(KinServiceResponseType.notFound);
      }
      else {
        return KinServiceResponse(KinServiceResponseType.undefinedError, null,
            UnrecognizedResultException(UnrecognizedProtoResponse()));
      }
    }
    catch (e) {
      if ( GrpcApi.canRetry(e) ) {
        return KinServiceResponse(KinServiceResponseType.transientFailure, null, TransientFailure(e));
      }
      else if ( GrpcApi.isForcedUpgrade(e) ) {
        return KinServiceResponse(KinServiceResponseType.upgradeRequiredError, null);
      }
      else {
        return KinServiceResponse(KinServiceResponseType.undefinedError, null, UnrecognizedResultException(e));
      }
    }
  }

  @override
  Future<KinServiceResponse<List<PublicKey>>> resolveTokenAccounts(KinAccountId accountId) async {
    var request = new ResolveTokenAccountsRequest(accountId: accountId.toProtoSolanaAccountId(), includeAccountInfo: true);
    var accounts = await _accountClient.resolveTokenAccounts(request);

    var publicKeys = accounts.tokenAccountInfos.map((e) => e.accountId.toPublicKey()).toList();

    return new KinServiceResponse(KinServiceResponseType.ok, publicKeys);
  }

  @override
  Observer<KinAccount> streamAccount(KinAccountId kinAccountId) {
    // TODO: implement streamAccount
    throw UnimplementedError();
  }

  @override
  Observer<KinTransaction> streamNewTransactions(KinAccountId kinAccountId) {
    // TODO: implement streamNewTransactions
    throw UnimplementedError();
  }


}

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
      cursor: pagingToken != null && pagingToken.value.isNotEmpty
          ? pagingToken.toProtoCursorV4()
          : null,
    );

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
    return KinServiceResponse(KinServiceResponseType.ok, QuarkAmount(0));
  }

  @override
  Future<KinServiceInvoiceResponse<KinTransaction>> submitTransaction(Transaction transaction, InvoiceList invoiceList) async {
    var amount = transaction.totalAmount ;
    var commitment ;

    if (amount.value < Decimal.fromInt(50000) ) { // ~1 $USD
      commitment = model_v4.Commitment.RECENT ;
    } else if (amount.value < Decimal.fromInt(500000) ) { // ~10 $USD
      commitment = model_v4.Commitment.SINGLE ;
    } else {
      commitment = model_v4.Commitment.MAX ;
    }

    var request = SubmitTransactionRequest(
      transaction: model_v4.Transaction( value: transaction.marshal() ),
        commitment: commitment) ;

    if (invoiceList != null) {
      request.invoiceList = invoiceList.toProto();
    }

    var response = await _transactionClient.submitTransaction(request);

    if (response.result == SubmitTransactionResponse_Result.OK || response.result == SubmitTransactionResponse_Result.ALREADY_SUBMITTED) {

      var historyItem = HistoryItem();

      var signatures2 = transaction.signatures.toList();
      signatures2[0] = response.signature.toModel();

      var transactionMarshal = transaction.copyWith(signatures: signatures2).marshal() ;

      historyItem.solanaTransaction = model_v4.Transaction( value: transactionMarshal ) ;

      if (invoiceList != null) {
        historyItem.invoiceList = invoiceList.toProto();
      }

      var responseTransaction = historyItem.toAcknowledgedKinTransaction(networkEnvironment);

      return KinServiceInvoiceResponse(KinServiceResponseType.ok, responseTransaction);
    }
    else if (response.result == SubmitTransactionResponse_Result.FAILED) {
      var responseType2 = parseResultCode( response.transactionError.toResultXdr() ).toKinServiceResponseType() ;

      if (responseType2 == KinServiceResponseType.ok) {
        return KinServiceInvoiceResponse(KinServiceResponseType.undefinedError);
      }
      else {
        return KinServiceInvoiceResponse(responseType2);
      }
    }
    else if (response.result == SubmitTransactionResponse_Result.INVOICE_ERROR) {
      /* No `response.invoiceErrorsList`:
      SubmitTransactionResponse.Result.InvoiceErrors(response.invoiceErrorsList.map {
                    when (it.reason) {
                        InvoiceError.Reason.ALREADY_PAID -> SubmitTransactionResponse.Result.InvoiceErrors.InvoiceError.ALREADY_PAID
                        InvoiceError.Reason.WRONG_DESTINATION -> SubmitTransactionResponse.Result.InvoiceErrors.InvoiceError.WRONG_DESTINATION
                        InvoiceError.Reason.SKU_NOT_FOUND -> SubmitTransactionResponse.Result.InvoiceErrors.InvoiceError.SKU_NOT_FOUND
                        InvoiceError.Reason.UNRECOGNIZED,
                        InvoiceError.Reason.UNKNOWN,
                        null -> SubmitTransactionResponse.Result.InvoiceErrors.InvoiceError.UNKNOWN
                    }
                })
       */
      return KinServiceInvoiceResponse(KinServiceResponseType.invoiceError);
    }
    else if (response.result == SubmitTransactionResponse_Result.REJECTED) {
      return KinServiceInvoiceResponse(KinServiceResponseType.webhookRejected);
    }
    else if (response.result == SubmitTransactionResponse_Result.PAYER_REQUIRED) {
      return KinServiceInvoiceResponse(KinServiceResponseType.undefinedError, null, Exception("subsidizer required: not yet supported in this sdk outside of community agora instance"));
    }
    else {
      return KinServiceInvoiceResponse(KinServiceResponseType.undefinedError, null, Exception("Internal Error"));
    }
  }
}
