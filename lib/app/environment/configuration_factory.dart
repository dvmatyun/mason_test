import 'package:flutter_mason/app/resources/business_constants.dart';
import 'package:package_info/package_info.dart';

import 'app_environment.dart';
import 'app_type.dart';
import 'configuration.dart';

class EnvironmentConfigurationFactory {
  static Future<AppConfiguration> getConfigsForApp() async {
    final appType = await getCurrentAppType();
    final environment = await getCurrentEnvironment();
    final customUrl = _getApiUrl(environment);

    return AppConfiguration(
      appType: appType,
      environment: environment,
      apiUrl: customUrl,
    );
  }

  static Future<AppType> getCurrentAppType() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    final isPassenger = packageName.contains('passenger');

    return isPassenger ? AppType.passenger : AppType.driver;
  }

  static Future<AppEnvironment> getCurrentEnvironment() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    final domains = packageName.split('.');

    switch (domains.last) {
      case 'dev':
        return AppEnvironment.development;
      case 'staging':
        return AppEnvironment.staging;
      default:
        return AppEnvironment.production;
    }
  }

  static String _getApiUrl(AppEnvironment environment) {
    const urlFromParams = String.fromEnvironment('CUSTOM_API_URL');
    if (urlFromParams.isNotEmpty) return urlFromParams;

    switch (environment) {
      case AppEnvironment.production:
        return BusinessConstants.productionApiUrl;
      default:
        return BusinessConstants.stagingApiUrl;
    }
  }
}
