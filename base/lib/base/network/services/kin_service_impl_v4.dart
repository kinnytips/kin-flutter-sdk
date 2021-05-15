

import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/network/api/kin_account_api.dart';
import 'package:kin_base/base/network/api/kin_account_creation_api_v4.dart';
import 'package:kin_base/base/network/api/kin_streaming_api_v4.dart';
import 'package:kin_base/base/network/api/kin_transaction_api.dart';
import 'package:kin_base/base/network/api/kin_transaction_api_v4.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/tools/kin_logger.dart';

import 'kin_service.dart';

class KinServiceImplV4 extends KinService {

  final NetworkEnvironment networkEnvironment ;
  final NetworkOperationsHandler networkOperationsHandler ;
  final KinAccountApi accountApi ;
  final KinTransactionApiV4 transactionApi ;
  final KinStreamingApiV4 streamingApi ;
  final KinAccountCreationApiV4 accountCreationApi ;
  final KinLoggerFactory logger;

  KinServiceImplV4(
      this.networkEnvironment,
      this.networkOperationsHandler,
      this.accountApi,
      this.transactionApi,
      this.streamingApi,
      this.accountCreationApi,
      this.transactionWhitelistingApi,
      this.logger);

  @override
  Future<KinAccount> getAccount(KinAccountId accountId) {

  }

  @override
  Future<List<KinTransaction>> getLatestTransactions(KinAccountId kinAccountId) async {
    var response = await transactionApi.getTransactionHistory(kinAccountId) ;

    switch(response.type) {
      case KinServiceResponseType.ok: {
        if (response.payload == null) throw IllegalResponseError();
        return response.payload ;
      }
      case KinServiceResponseType.notFound: {
        throw ItemNotFoundError();
      }
      case KinServiceResponseType.undefinedError: {
        throw UnexpectedServiceError(response.error);
      }
      case KinServiceResponseType.transientFailure: {
        throw TransientFailure(response.error);
      }
      case KinServiceResponseType.upgradeRequiredError: {
        throw SDKUpgradeRequired(response.error);
      }
      default: throw StateError("Can't handle response type: ${response.type}");
    }
  }

}