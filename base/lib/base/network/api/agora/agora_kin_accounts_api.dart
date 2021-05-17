import 'package:grpc/grpc.dart';
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/network/api/agora/grpc_api.dart';
import 'package:kin_base/base/network/api/agora/model_to_proto_v4.dart';
import 'package:kin_base/base/network/api/kin_account_api.dart';
import 'package:kin_base/base/network/api/kin_account_creation_api.dart';
import 'package:kin_base/base/network/api/kin_streaming_api.dart';
import 'package:kin_base/base/network/api/kin_transaction_api_v4.dart';
import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/tools/observers.dart';
import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pb.dart';
import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pbgrpc.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as model_v3;
import 'package:kin_base/models/agora/protobuf/common/v4/model.pb.dart' as model_v4;
import 'package:kin_base/models/agora/protobuf/transaction/v3/transaction_service.pbgrpc.dart';

import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/models/app/account/create_kin_account_response.dart';
import 'package:kin_base/models/app/interfaces/status.dart';
import 'package:kin_base/models/app/sdk/constants.dart';
import 'package:logging/logging.dart';

import 'proto_to_model.dart';
import 'proto_to_model_v4.dart';

class AgoraKinAccountsApi extends GrpcApi
    implements KinAccountApi, KinStreamingApi, KinAccountCreationApi {

  AgoraKinAccountsApi(ClientChannel managedChannel) : super(managedChannel) {
    // No AccountClient for V3!
    //_accountClient = AccountClient(managedChannel) ;
  }

  final log = Logger('AccountService');

  @override
  Future<KinServiceResponse<KinAccount>> createAccount(KinAccountId accountId) async {
    // TODO: implement createAccount
        // Transaction.Value contains the instructions for creating the account
    var transaction = model_v4.Transaction();
    var createAccountRequest = CreateAccountRequest()
      ..transaction = transaction;
    try {
      var response = await AccountClient(managedChannel)
          .createAccount(createAccountRequest)
          .timeout(Duration(seconds: 10));
      return KinServiceResponse<KinAccount>(
        KinServiceResponseType.ok
      );
    } catch (e) {
      log.severe(
        "Error creating account :" + e.toString(),
      );
      return  KinServiceResponse<KinAccount>(
        KinServiceResponseType.exists
      );
    }
  }

  @override
  Future<KinServiceResponse<KinAccount>> getAccount(KinAccountId accountId) async  {
    // TODO: implement getAccount
    throw UnimplementedError();
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
