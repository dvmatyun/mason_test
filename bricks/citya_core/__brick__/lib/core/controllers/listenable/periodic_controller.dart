import 'dart:async';

import 'package:{{name.snakeCase()}}/core/controllers/listenable/controller.dart';

/// Periodically runs the value lookup and pass that value to the listeners
/// The lookup function being set through the [delegate] parameter
/// Automatically closes after all the listeners are removed and starts when the first listener being added
/// [addListener] has also return value, that is equal to lastly emitted one - it allows to not wait for the next iteration
class PeriodicController<T> implements ListenableController<T> {
  final Duration _duration;
  final PeriodicControllerDelegate<T> _delegate;

  final List<ValueListener<T>> _listeners = [];

  Timer? _timer;
  T? _lastValue;

  @override
  T? get lastValue => _lastValue;

  PeriodicController({
    required Duration duration,
    required PeriodicControllerDelegate<T> delegate,
  })  : _duration = duration,
        _delegate = delegate;

  /// The listener will notify results from [periodicFunction] execution
  /// The first listener added to this controller will execute body immediately and start the timer to repeat it
  /// This function also returns the result of the previous success execution to reduce waiting time
  @override
  T? addListener(ValueListener<T> listener) {
    final isFirst = _listeners.isEmpty;
    _listeners.add(listener);

    if (isFirst) {
      _onTimerTick();
    }

    return _lastValue;
  }

  /// If removes the last listener from listeners list, it stops the timer entirely
  @override
  void removeListener(ValueListener<T> listener) {
    _listeners.remove(listener);

    if (_listeners.isEmpty) {
      _timer?.cancel();
      _timer = null;
    }
  }

  /// Stops the timer and cleans all the listeners
  /// Although, new listeners can be added to restart the controller
  @override
  void stop() {
    _listeners.clear();
    _timer?.cancel();
    _timer = null;
  }

  /// Runs the body, notifies all the listeners and restarts the timer
  void _onTimerTick() async {
    if (_listeners.isEmpty) {
      _timer?.cancel();
      _timer = null;
      return;
    }

    final result = await _delegate();
    if (result != null) {
      _lastValue = result;
      for (var listener in _listeners) {
        listener(result);
      }
    }
    _timer = Timer(_duration, _onTimerTick);
  }
}

/// Function holder that will be executed every time the timer runs out
/// If result value wont be null, that value will be emitted as event to all listeners
abstract class PeriodicControllerDelegate<T> {
  Future<T?> call();
}
