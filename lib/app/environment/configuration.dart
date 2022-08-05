import 'app_environment.dart';
import 'app_type.dart';

class AppConfiguration {
  final AppType appType;
  final AppEnvironment environment;
  final String apiUrl;

  AppConfiguration({
    required this.appType,
    required this.environment,
    required this.apiUrl,
  });
}
