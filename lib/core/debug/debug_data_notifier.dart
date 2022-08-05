import 'package:flutter_mason/core/data/local/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Listenable object of debug values and controls
class DebugNotifier extends ChangeNotifier {
  bool _showPerformanceOverlay = false;

  bool get showPerformanceOverlay => _showPerformanceOverlay;

  set showPerformanceOverlay(bool newValue) {
    if (newValue != _showPerformanceOverlay) {
      _showPerformanceOverlay = newValue;
      notifyListeners();
    }
  }

  void killCache() async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    HiveUtils.resetAllData();
  }
}
