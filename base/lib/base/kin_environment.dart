import 'package:grpc/grpc.dart';
import 'package:kin_base/base/storage/storage.dart';
import 'package:kin_base/services/kin_services.dart';

import 'network/services/app_info_providers.dart';
import 'stellar/models/network_environment.dart';
import 'tools/executor_service.dart';
import 'tools/kin_logger.dart';

class KinEnvironment {
  NetworkEnvironment networkEnvironment;
  KinLoggerFactory logger;
  KinService service;
  Storage storage;
  ExecutorServices executors;
  NetworkOperationsHandler networkHandler;
}

class KinEnvironmentAgora extends KinEnvironment {
  ClientChannel managedChannel;
  InMemoryAppInfoRepositoryImpl appInfoRepository;
  InMemoryInvoiceRepositoryImpl invoiceRepository;
  AppInfoProvider appInfoProvider;
}
