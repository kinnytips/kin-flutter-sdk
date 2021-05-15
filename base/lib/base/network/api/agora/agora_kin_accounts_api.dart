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
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pb.dart';
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pbgrpc.dart';

import 'package:kin_base/base/tools/extensions.dart';

import 'proto_to_model.dart';
import 'proto_to_model_v4.dart';

class AgoraKinAccountsApi extends GrpcApi
    implements KinAccountApi, KinStreamingApi, KinAccountCreationApi {
  AgoraKinAccountsApi(ClientChannel managedChannel) : super(managedChannel);

  @override
  Future<KinAccount> createAccount(KinAccountId accountId) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<KinServiceResponse<KinAccount>> getAccount(KinAccountId accountId) {
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
