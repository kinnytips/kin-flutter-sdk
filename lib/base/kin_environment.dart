// import 'package:kin_sdk/base/stellar/models/network_environment.dart';
// import 'package:kin_sdk/services/kin_services.dart';
// import 'package:grpc/grpc.dart';

// abstract class KinNetworkEnvironment implements NetworkEnvironment{}

// abstract class KinLogger implements KinLoggerFactory {}

// abstract class Service implements KinService {}

// abstract class KinStorage implements Storage {}

// abstract class Executors implements ExecutorServices {}

// abstract class NetworkHandler implements NetworkOperationsHandler {}

// class KinEnvironment {
//   KinNetworkEnvironment networkEnvironment;
//   KinLogger logger;
//   Service service;
//   KinStorage _storage;
//   Executors _executors;
//   NetworkHandler _networkHandler;

//   KinEnvironment.Agora(
//     ManagedChannel managedChannel /* whats the dart equivalent in the GRPC package? */,
//     NetworkEnvironment agoraNetworkEnvironment,
//     KinLogger agoraLogger,
//     KinStorage agoraStorage,
//     Executors executors,
//     NetworkHandler networkHandler,
//     Service service,
//     InMemoryAppInfoRepositoryImpl appInfoRepository,
//     InMemoryInvoiceRepositoryImpl invoiceRepository,
//     AppInfoProvider appInfoProvider,
//   ) {

//   }
// }