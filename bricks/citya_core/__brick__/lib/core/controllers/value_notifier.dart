import 'package:flutter/foundation.dart';

class ValueNotifierImpl<T> with ChangeNotifier implements ValueListenable<T> {
  ValueNotifierImpl(T initialValue) : _value = initialValue;

  bool update(T value) {
    _value = value;
    notifyListeners();
    return true;
  }

  @override
  T get value => _value;
  T _value;
}
