import 'package:{{name.snakeCase()}}/app/environment/app_environment.dart';
import 'package:logger/logger.dart';

import 'configs/filters.dart';
import 'configs/outputs.dart';
import 'configs/printers.dart';

/// Generates the logger. Why factory instead of constructor?
/// In the future, we may want to read current build flavor and change the logger configurations accordingly
/// for example, we can duplicate production logs to external SDK or write profiling outputs to the file
class LoggerFactory {
  static Logger getLogger(AppEnvironment environment) {
    return Logger(
      filter: FirebaseReporterFilter(),
      printer: ProductionPrinter(),
      output: _getLogOutput(environment),
    );
  }

  static LogOutput _getLogOutput(AppEnvironment environment) {
    switch (environment) {
      case AppEnvironment.development:
      case AppEnvironment.staging:
        return MultiOutput([
          DebugConsoleOutput(),
          FirebaseCrashlyticsOutput(),
        ]);
      case AppEnvironment.production:
        return FirebaseCrashlyticsOutput();
    }
  }
}
