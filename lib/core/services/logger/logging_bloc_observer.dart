import 'package:flutter_bloc/flutter_bloc.dart';

import 'logger.dart';

/// Observer for dumping bloc events into logs
class LoggingBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.e(bloc, error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log.i('Bloc ${bloc.runtimeType}#${bloc.hashCode} received ${event?.toString()}');
    super.onEvent(bloc, event);
  }
}
