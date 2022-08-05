import 'package:flutter_mason/core/services/logger/optimized_stack_trace.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

class FirebaseReporterFilter extends LogFilter {
  final _productionFilter = ProductionFilter();

  FirebaseReporterFilter() {
    _productionFilter.level = Level.info;
  }

  @override
  bool shouldLog(LogEvent event) {
    if (event.level.index >= Level.error.index) {
      final optimizedStackTrace = OptimizedStackTrace(event.stackTrace.toString());
      FirebaseCrashlytics.instance.recordError(
        event.error,
        optimizedStackTrace,
        reason: event.message,
        printDetails: false,
        fatal: event.level.index >= Level.wtf.index,
      );
    }

    return _productionFilter.shouldLog(event);
  }
}
