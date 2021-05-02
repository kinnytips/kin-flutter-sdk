import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/services/kin_services.dart';
import 'package:grpc/grpc.dart';

abstract class KinNetworkEnvironment implements NetworkEnvironment{}

abstract class KinLogger implements KinLoggerFactory {}

abstract class Service implements KinService {}

abstract class KinStorage implements Storage {}

abstract class Executors implements ExecutorServices {}

abstract class NetworkHandler implements NetworkOperationsHandler {}

class KinEnvironment {
  KinNetworkEnvironment networkEnvironment;
  KinLogger logger;
  Service service;
  KinStorage _storage;
  Executors _executors;
  NetworkHandler _networkHandler;

  KinEnvironment.Agora(
    ManagedChannel managedChannel /* whats the dart equivalent in the GRPC package? */,
    NetworkEnvironment agoraNetworkEnvironment,
    KinLogger agoraLogger,
    KinStorage agoraStorage,
    Executors executors,
    NetworkHandler networkHandler,
    Service service,
    AppInfoProvider appInfoProvider, [
    AppInfoRepository appInfoRepository = InMemoryAppInfoRepositoryImpl(),
    InvoiceRepository invoiceRepository = InMemoryInvoiceRepositoryImpl(),
  ]);

  Agora build() {
    final logger = logger ?? KinLoggerFactoryImpl(enableLogging);
    final executors = executors ?? ExecutorServices()
    final networkHandler - networkHandler ?? NetworkOperationsHandlerImpl(
      executors.sequentialScheduled,
      executors.parallelIO,
      logger,
      // todo what is this in Dart?
      shouldRetryError = { it is KinService.FatalError.TransientFailure },
    );
    final appInfoProvider = appInfoProvider ?? throw Exception('KinEnvironmentBuilderException: Must provide as ApplicationDelegate!');
    final storageBuilder = storageBuilder;
    if (!this@Builder::storage.isInitialized && storageBuilder != null) {
      storage = storageBuilder.setNetworkEnvironment(networkEnvironment).build();
    }
    // todo this might need to change?
    final blockchainVersion = networkEnvironemnt.isKin2() ? 2 : minApiVersion;
    final managedChannel = managedChannel ?? networkEnfironemtn.agoraApiConfig()
      .asManagedChannel(logger, blockchainVersion);

    KinService buildV3ApiService() {
      final accountsApi = AgoraKinAccountsApi(managedChannel, networkEnvironment);
      final transactionsApi = AgoraKinTransactionsApi(
        managedChannel,
        networkEnvironment,
      );
      return service ?? KinServiceImple(
        networkEnvironment,
        networkHandler,
        accountsApi,
        transactionsApi,
        accountsApi,
        accountsApi,
        transactionsApi,
        logger,
      );
    }

    KinService buildV4ApiService() {
      final accountsApi = AgoraKinAccountApiV4(managedChannel, networkEnvironment);
      final accountCreationApi = AgoraKinAccountCreationApiV4(managedChannel);
      final transactionsApi = AgoraKinTransactionsApiV4(
        managedChannel,
        networkEnvironment
      );

      return service ?? KinServiceImplV4(
        networkEnvironment,
        networkHandler,
        accountsApi,
        transactionsApi,
        accountsApi,
        accountCreationApi,
        logger,
      );
    }

    final metaServiceApi = MetaServiceApiImpl(
        minApiVersion,
        networkHandler,
        AgoraKinTransactionsApiV4(managedChannel, networkEnvironment),
        storage,
    );
    metaServiceApi.postInit();
    final service = KinServiceWrapper(
        buildV3ApiService(),
        buildV4ApiService(),
        metaServiceApi,
    );

    final agora =  Agora(
        managedChannel,
        networkEnvironment = networkEnvironment,
        logger = logger,
        storage = storage,
        executors = executors,
        networkHandler = networkHandler,
        service = service,
        appInfoProvider = appInfoProvider,
    );
    // todo do the following in Dart
    //                    ).apply {
    //                         appInfoRepository.addAppInfo(appInfoProvider.appInfo)
    //
    //                         with(storage) {
    //                             getAllAccountIds().forEach {
    //                                 getInvoiceListsMapForAccountId(it)
    //                                     .flatMap {
    //                                         invoiceRepository.addAllInvoices(it.values.map { it.invoices }
    //                                             .reduce { acc, list -> acc + list })
    //                                     }.resolve()
    //                             }
    //                         }
    //                     }

    return agora;

  }

  // todo convert to Dart code
   NetworkEnvironment.agoraApiConfig() = when(this) {
    NetworkEnvironment.KinStellarTestNetKin3,
    NetworkEnvironment.KinStellarTestNetKin2-> ApiConfig.TestNetAgora
    NetworkEnvironment.KinStellarMainNetKin3,
    NetworkEnvironment.KinStellarMainNetKin2-> ApiConfig.MainNetAgora
  }

  ApiConfig.asManagedChannel(KinLoggerFacotry logger, int blockchainVersion) {
    //                    OkHttpChannelBuilderForcedTls12.forAddress(networkEndpoint, tlsPort)
    //                         .intercept(
    //                             *listOfNotNull(
    //                                 AppUserAuthInterceptor(appInfoProvider!!),
    //                                 UserAgentInterceptor(storage),
    //                                 LoggingInterceptor(logger),
    //                                 if (blockchainVersion == 2) KinVersionInterceptor(blockchainVersion) else null,
    //                                 if (testMigration) UpgradeApiV4Interceptor() else null
    //                             ).toTypedArray()
    //                         )
    //                         .build()
  }

  Builder setManagedChannel(ManagedChannel managedChannel) = apply {
    this.managedChannel = managedChannel;
  }

  Builder setExecutorServices(ExecutorServices executors) = apply {
    this.executors = executors;
  }

  Builder setNetworkOperationsHandler(NetworkOperationsHandler networkHandler) = apply {
    this.networkHandler = networkHandler;
  }

  ///
  /// This option allows developers to force which api version the KinService should use.
  /// v3 - stellar (Kin 2 or Kin 3 blockchains)
  /// v4 - solana
  /// It is *not* required to set this as we default to v3 until migration day to solana.
  ///
  Builder setMinApiVersion(int minApiVersion) = apply {
    if (minApiVersion < 3 || minApiVersion > 4) {
      throw Exception('IllegalArgumentException: $minApiVersion is not supported, must be 3 or 4');
    }
    this.minApiVersion = minApiVersion;
  }

   ///
   /// This option allows developers to force an on-demand migration from the Stellar based
   /// Kin Blockchain to Solana on TestNet only.
   ///
  Builder testMigration()  = apply {
    this.testMigration = true;
  }

  Builder setLogger(KinLoggerFactory logger) = apply {
    this.logger = logger;
  }

  setAppInfoProvider(AppInfoProvider appInfoProvider) = apply {
    this.appInfoProvider = appInfoProvider;
  }

  Builder setKinService(KinService kinService) = apply {
    this.service = kinService;
  }

  Builder setEnableLogging() = apply {
    this.enableLogging = true;
  }

  CompletedBuilder setStorage(Storage storage) = with(this) {
    this.storage = storage;
    CompletedBuilder();
  }

  Builder.CompletedBuilder setStorage(KinFileStorage.Builder fileStorageBuilder) =
    with(this) {
    this.storageBuilder = fileStorageBuilder;
    CompletedBuilder();
  }

  Future<bool> importPrivateKey(PrivateKey privateKey) {
    //        return Promise.create<Boolean> { resolve, reject ->
    //             if (storage.getAccount(privateKey.asKinAccountId()) == null) {
    //                 service.getAccount(privateKey.asKinAccountId())
    //                     .then({
    //                         try {
    //                             resolve(storage.addAccount(it.copy(key = privateKey)))
    //                         } catch (t: Throwable) {
    //                             reject(t)
    //                         }
    //                     }, {
    //                         try {
    //                             resolve(storage.addAccount(KinAccount(privateKey)))
    //                         } catch (t: Throwable) {
    //                             reject(t)
    //                         }
    //                     })
    //             } else resolve(true)
    //         }
  }

  importPrivateKey(PrivateKey privateKey, Function(bool) callback) {
    // todo callback?
    return importPrivatekey(privateKey).callback(callback);
  }

  Future<List<KinAccountId>> allAccountIds() {
//        return Promise.create { resolve, reject ->
//             try {
//                 resolve(storage.getAllAccountIds())
//             } catch (t: Throwable) {
//                 reject(t)
//             }
//         }
  }

  setEnableLogging(bool enableLoggin) {
    logger.isLoggingEnabled = enableLogging;
  }
}


class KinEnvironmentBuilderException implements Exception {
  // todo need to send s to super
  KinEnvironmentBuilderException(String s) : super();
}
