import 'dart:async';

import 'package:{{name.snakeCase()}}/core/controllers/listenable/controller.dart';

/// Simple stream wrapper that allows to manually pass events with [addEvent]
/// Allows to exchange additional events between several objects
/// Typical usecase: send event back from bloc to UI listener that will trigger navigation or modal windows
class EventController<T> implements ListenableController<T> {
  bool get isClosed => _isClosed;
  bool _isClosed = false;

  final StreamController<T> _streamController;
  Stream<T> get stream => _streamController.stream;

  /// if true - adds the latest emitted value to the newly added listener
  final bool notifyOnNewListener;

  final Map<ValueListener<T>, StreamSubscription> _subscriptions = {};

  T? _lastValue;

  @override
  T? get lastValue => _lastValue;

  EventController({this.notifyOnNewListener = false}) : _streamController = StreamController<T>.broadcast();

  void addEvent(T event) {
    if (isClosed) {
      return;
    }
    _streamController.add(event);
    _lastValue = event;
  }

  @override
  T? addListener(ValueListener<T> listener) {
    final subscription = _streamController.stream.listen(listener);
    if (_subscriptions.containsKey(listener)) {
      _subscriptions[listener]!.cancel();
    }

    _subscriptions[listener] = subscription;
    if (_lastValue != null && notifyOnNewListener) {
      listener(_lastValue as T);
    }
    return _lastValue;
  }

  @override
  void stop() {
    _isClosed = true;
    final keysToRemove = [];
    for (var key in _subscriptions.keys) {
      _subscriptions[key]!.cancel();
      keysToRemove.add(key);
    }
    _subscriptions.removeWhere((key, _) => keysToRemove.contains(key));
    _streamController.close();
  }

  @override
  void removeListener(ValueListener<T> listener) {
    if (_subscriptions.containsKey(listener)) {
      _subscriptions[listener]!.cancel();
      _subscriptions.remove(listener);
    }
  }
}
