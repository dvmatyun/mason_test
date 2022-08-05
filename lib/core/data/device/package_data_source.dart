import 'package:package_info/package_info.dart';

abstract class PackageInfoDataSource {
  Future<String> getAppVersion();
}

class DefaultPackageInfoDataSource implements PackageInfoDataSource {
  PackageInfo? _packageInfo;

  DefaultPackageInfoDataSource({PackageInfo? packageInfo}) : _packageInfo = packageInfo;

  @override
  Future<String> getAppVersion() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!.version;
  }
}
