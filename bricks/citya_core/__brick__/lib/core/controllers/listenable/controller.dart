typedef ValueListener<T> = void Function(T event);

abstract class ListenableController<T> {
  T? addListener(ValueListener<T> listener);
  void removeListener(ValueListener<T> listener);
  void stop();
  T? get lastValue;
}
