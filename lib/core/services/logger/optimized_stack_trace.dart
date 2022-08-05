/// Stack trace that filters out unneeded log pieces
class OptimizedStackTrace implements StackTrace {
  static final ignoredLines = ['Logger', 'FirebaseCrashlytics', 'FirebaseReporterFilter'];

  final String _stackTrace;

  const OptimizedStackTrace(this._stackTrace);

  @override
  String toString() {
    final lines =
        _stackTrace.toString().split('\n').where((line) => ignoredLines.every((ignore) => !line.contains(ignore)));
    return lines.join('\n');
  }
}
