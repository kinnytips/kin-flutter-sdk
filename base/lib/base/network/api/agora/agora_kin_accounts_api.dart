import 'dart:typed_data';

import 'package:grpc/grpc.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_amount.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/network/api/agora/grpc_api.dart';
import 'package:kin_base/base/network/api/kin_account_api.dart';
import 'package:kin_base/base/network/api/kin_account_creation_api.dart';
import 'package:kin_base/base/network/api/kin_streaming_api.dart';
import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/tools/observers.dart';
import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pb.dart';
import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pbgrpc.dart';
import 'package:kin_base/models/agora/protobuf/common/v4/model.pb.dart'
    as model_v4;
import 'package:kin_base/models/agora/protobuf/common/v4/model.pb.dart';

import 'package:logging/logging.dart';

class AgoraKinAccountsApi extends GrpcApi
    implements KinAccountApi, KinStreamingApi, KinAccountCreationApi {
  final AccountClient _accountClient;

  AgoraKinAccountsApi(ClientChannel managedChannel)
      : this._accountClient = AccountClient(managedChannel),
        super(managedChannel);

  final log = Logger('AccountService');

  @override
  Future<KinServiceResponse<KinAccount>> createAccount(
      KinAccountId accountId) async {
    // TODO: implement createAccount
    // Transaction.Value contains the instructions for creating the account
    var transaction = model_v4.Transaction();
    var createAccountRequest = CreateAccountRequest()
      ..transaction = transaction;
    try {
      await AccountClient(managedChannel)
          .createAccount(createAccountRequest)
          .timeout(Duration(seconds: 10));
      return KinServiceResponse<KinAccount>(KinServiceResponseType.ok);
    } catch (e) {
      log.severe(
        "Error creating account :" + e.toString(),
      );
      return KinServiceResponse<KinAccount>(KinServiceResponseType.exists);
    }
  }

  @override
  Future<KinServiceResponse<KinAccount>> getAccount(
      KinAccountId accountId) async {
    var getAccountRequest = GetAccountInfoRequest()
      ..accountId = SolanaAccountId(value: accountId.value);

    var response = await _accountClient
        .getAccountInfo(getAccountRequest)
        .timeout(Duration(seconds: 10));

    if (response.result == GetAccountInfoResponse_Result.NOT_FOUND) {
      return KinServiceResponse(KinServiceResponseType.notFound);
    }

    var info = response.accountInfo;
    var id = KinAccountId(info.accountId.value as Uint8List?);
    var publicKey = PublicKey(id.base58Encode());

    var balance = KinBalance(KinAmount.fromInt(info.balance.toInt()));
    var kinAccount = KinAccount(
      publicKey,
      id: id,
      tokenAccounts: [publicKey],
      balance: balance,
      status: KinAccountStatusRegistered(1),
    );

    return KinServiceResponse(KinServiceResponseType.ok, kinAccount);
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
