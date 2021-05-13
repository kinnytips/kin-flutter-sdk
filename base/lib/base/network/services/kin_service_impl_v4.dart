

import 'package:kin_base/base/network/api/kin_transaction_api.dart';
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
}