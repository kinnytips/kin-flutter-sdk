//Placeholder

class KinClient {
  KinClientInternal _delegate;

  KinClient(Context context, Environment environment, String appId, String storeKey, BackupRestore backupRestore, KeyStore keyStore, Storage storage, KinEnvironment kinEnvironment) {
    _delegate = new KinClientInternal(context, environment, appId, storeKey, backupRestore, keyStore, storage, kinEnvironment);
  }
}