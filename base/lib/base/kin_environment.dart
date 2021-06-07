import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:kin_base/base/network/services/kin_service_impl_v4.dart';
import 'package:kin_base/base/repository/app_info_repository.dart';
import 'package:kin_base/base/repository/invoice_repository.dart';
import 'package:kin_base/base/storage/storage.dart';
import 'package:kin_base/base/tools/observers.dart';

import 'package:kin_base/base/network/services/kin_service.dart';

import 'package:kin_base/base/network/api/agora/agora_v4_apis.dart';


import 'models/key.dart';
import 'models/kin_account.dart';
import 'network/services/app_info_providers.dart';
import 'network/services/kin_service_impl.dart';
import 'stellar/models/api_config.dart';
import 'stellar/models/network_environment.dart';
import 'tools/executor_service.dart';
import 'tools/kin_logger.dart';
import 'tools/network_operations_handler.dart';

class KinEnvironment {
  final NetworkEnvironment networkEnvironment;
  final KinLoggerFactory logger;
  final KinService service;
  final Storage storage;
  final ExecutorServices executors;
  final NetworkOperationsHandler networkHandler;

  KinEnvironment(this.networkEnvironment, this.logger, this.service,
      this.storage, this.executors, this.networkHandler);

  Future<bool> importPrivateKey(PrivateKey privateKey, [ Callback<bool> callback ]) async {
    var accountId = KinAccountId.fromPrivateKey(privateKey);

    if ( storage.getAccount(accountId) == null ) {
      try {
        var kinAccount = await service.getAccount(accountId);
        try {
          storage.addAccount(kinAccount);
        }
        catch (e) {
          if (callback != null) callback(false, e);
        }
      }
      catch(e) {
        try {
          storage.addAccount( KinAccount(privateKey) );
        }
        catch (e) {
          if (callback != null) callback(false, e);
        }
      }
    }

    if (callback != null) callback(true);

    return true ;
  }

  Future<List<KinAccountId>> allAccountIds() async {
    return storage.getAllAccountIds();
  }

  void setEnableLogging(bool enableLogging) {
    logger.isLoggingEnabled = enableLogging;
  }

}

class KinEnvironmentAgora extends KinEnvironment {
  final ClientChannel managedChannel;
  final InMemoryAppInfoRepositoryImpl appInfoRepository =
      InMemoryAppInfoRepositoryImpl();
  final InMemoryInvoiceRepositoryImpl invoiceRepository =
      InMemoryInvoiceRepositoryImpl();
  final AppInfoProvider appInfoProvider;

  KinEnvironmentAgora(
      this.managedChannel,
      NetworkEnvironment networkEnvironment,
      KinLoggerFactory logger,
      KinService service,
      Storage storage,
      ExecutorServices executors,
      NetworkOperationsHandler networkHandler,
      this.appInfoProvider)
      : super(networkEnvironment, logger, service, storage, executors,
            networkHandler);


  factory KinEnvironmentAgora.build(NetworkEnvironment networkEnvironment, {
    ClientChannel managedChannel,
    KinLoggerFactory logger ,
    bool enableLogging,
    KinService service,
    Storage storage,
    StorageBuilder storageBuilder,
    ExecutorServices executors,
    NetworkOperationsHandler networkHandler,
    AppInfoProvider appInfoProvider,
}) {

    logger ??= KinLoggerFactoryImpl(enableLogging) ;
    executors ??=  ExecutorServices() ;

    networkHandler ??=  NetworkOperationsHandlerImpl(
        ioScheduler: executors.sequentialScheduled,
        ioExecutor: executors.parallelIO,
        logger: logger,
        shouldRetryError: (e) => e is Error  //TODO: is KinService.FatalError.TransientFailure
    );

    if (appInfoProvider == null) throw KinEnvironmentBuilderException("Must provide an ApplicationDelegate!");

    managedChannel ??= _asManagedChannel( _agoraApiConfig(networkEnvironment) , logger, 4);

    var transactionsApi = new AgoraKinTransactionsApiV4(managedChannel, networkEnvironment);

    if (service == null) {
      var accountApi = AgoraKinAccountApiV4(managedChannel, networkEnvironment) ;

      var accountCreationApi = AgoraKinAccountCreationApiV4(managedChannel);

      service = KinServiceImplV4(
          networkEnvironment,
          networkHandler,
          accountApi,
          transactionsApi,
          null,
          accountCreationApi,
          logger);
    }

    if (storage == null) {
      storage = storageBuilder(networkEnvironment: networkEnvironment) ;
    }

    var agora = KinEnvironmentAgora(managedChannel, networkEnvironment, logger, service, storage, executors, networkHandler, appInfoProvider);

    return agora ;
  }

  static ClientChannel _asManagedChannel(
      ApiConfig apiConfig, KinLoggerFactory logger, int blockchainVersion) {
    var channelOptions = ChannelOptions(credentials: ChannelCredentials.secure());
    return ClientChannel(apiConfig.networkEndpoint,
        port: apiConfig.tlsPort, options: channelOptions);
  }

  static ApiConfig _agoraApiConfig(NetworkEnvironment networkEnvironment) {
    if (networkEnvironment is KinStellarTestNetKin3) {
      return ApiConfig.testNetAgora ;
    }
    else if (networkEnvironment is KinStellarMainNetKin3) {
      return ApiConfig.mainNetAgora ;
    }
    else {
      throw StateError("Unsupported: $networkEnvironment");
    }
  }

}


class KinEnvironmentBuilderException implements Exception {
  final String message ;

  KinEnvironmentBuilderException(this.message) ;

  @override
  String toString() {
    return 'KinEnvironmentBuilderException{message: $message}';
  }
}