

import 'package:kin_base/base/network/api/kin_transaction_api.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/tools/kin_logger.dart';

import 'kin_service.dart';

class KinServiceImpl extends KinService {

  final NetworkEnvironment networkEnvironment ;
  final NetworkOperationsHandler networkOperationsHandler ;
  final KinAccountApi accountApi ;
  final KinTransactionApi transactionApi ;
  final KinStreamingApi streamingApi ;
  final KinAccountCreationApi accountCreationApi ;
  final KinTransactionWhitelistingApi transactionWhitelistingApi ;
  final KinLoggerFactory logger;

  KinServiceImpl(
      this.networkEnvironment,
      this.networkOperationsHandler,
      this.accountApi,
      this.transactionApi,
      this.streamingApi,
      this.accountCreationApi,
      this.transactionWhitelistingApi,
      this.logger);
}