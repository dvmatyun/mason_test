import 'dart:async';

/// Prevents the callback from executing until [delayMs] has passed after previous run
class Throttler {
  final int delayMs;

  Timer? _timer;

  Throttler({required this.delayMs});

  void run(void Function() action) {
    if (_timer?.isActive ?? false) {
      return;
    }
    _timer = Timer(Duration(milliseconds: delayMs), () {});
    action();
  }

  void stop() {
    _timer?.cancel();
  }
}
