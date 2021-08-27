import 'package:kin_base/base/models/app_info.dart';
import 'package:kin_base/base/models/appidx.dart';

abstract class AppInfoRepository {
  void addAppInfo(AppInfo appInfo);

  Future<AppInfo?> appInfoByAppIndex(AppIdx appIndex);
}

class InMemoryAppInfoRepositoryImpl implements AppInfoRepository {
  final Map<AppIdx, AppInfo> _storage = <AppIdx, AppInfo>{};

  @override
  void addAppInfo(AppInfo appInfo) {
    _storage[appInfo.appIndex] = appInfo;
  }

  @override
  Future<AppInfo?> appInfoByAppIndex(AppIdx appIndex) async {
    return _storage[appIndex];
  }
}
