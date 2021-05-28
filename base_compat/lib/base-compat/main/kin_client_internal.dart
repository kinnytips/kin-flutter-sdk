import 'package:kin_sdk/base-compat/main/backup_restore.dart';
import 'package:kin_sdk/base/network/models/AppInfo.dart';
import 'package:kin_sdk/base/network/services/AppInfoProvider.dart';

class KinClientInternal {
  AppInfoProvider _dummyAppInfoProvider() {
    AppInfo appInfo = AppInfo(AppIdx.TEST_APP_IDX, )
  }

  Environment environment;
  String appId;
  String storeKey;

  Context _context;
  BackupRestore _backupRestore;
  KeyStore _keyStore;
  Storage _storage;
  KinEnvironment _kinEnvironment;
  KinAccountImpl[] _kinAccouts;
  KinLogger _log;

  KinClientInternal(Context context, Environment environment, String appId) {
    _context = context;
    this.environment = environment;
    this.appId = appId;
  }
}