import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

class DebugConsoleOutput extends LogOutput {
  final ConsoleOutput _consoleOutput = ConsoleOutput();

  DebugConsoleOutput();

  @override
  void output(OutputEvent event) {
    _consoleOutput.output(event);
  }
}

class FirebaseCrashlyticsOutput extends LogOutput {
  FirebaseCrashlyticsOutput();

  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      FirebaseCrashlytics.instance.log(line);
    }
  }
}
