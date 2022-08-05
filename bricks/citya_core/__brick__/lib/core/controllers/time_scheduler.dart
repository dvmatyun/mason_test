import 'dart:async';

import 'package:{{name.snakeCase()}}/core/structs/dto.dart';

typedef ScheduledFunction = Future Function();

/// Plans execution of function for later time
/// Caches planned action time into [Dto] and restores it even after app restart or re-instantiation
class TimeScheduler {
  final Dto<String> _scheduledDateDto;

  Timer? _timer;

  TimeScheduler({required Dto<String> scheduledDateDto}) : _scheduledDateDto = scheduledDateDto;

  /// [scheduledFunction] will be scheduled for execution and scheduled time [runAt] will be cached.
  /// If some date was already scheduled before, [scheduledFunction] will ignore [runAt] parameter
  /// and plan its execution on previously cached date.
  /// However, if cached date has already passed or there is no cached date at all,
  /// [scheduledFunction] will plan itself for [runAt] date and cache it instead
  void runScheduled(ScheduledFunction scheduledFunction, DateTime runAt) async {
    final preservedDateString = await _scheduledDateDto.get();

    if (preservedDateString == null) {
      return _runTimer(scheduledFunction, runAt);
    }

    final preservedDate = DateTime.parse(preservedDateString);
    final hasPreservedDatePassed = DateTime.now().isAfter(preservedDate);

    if (hasPreservedDatePassed) {
      await _scheduledDateDto.save(null);
      return _runTimer(scheduledFunction, runAt);
    }

    return _runTimer(scheduledFunction, preservedDate);
  }

  /// Stops the timer and prevents planned function execution
  ///when [cancelSchedule = true], it will also clear scheduled date
  void stop({bool cancelSchedule = false}) async {
    _timer?.cancel();
    if (cancelSchedule) {
      await _scheduledDateDto.save(null);
    }
  }

  void _runTimer(ScheduledFunction scheduledFunction, DateTime runAt) async {
    await _scheduledDateDto.save(runAt.toIso8601String());

    final timeRemaining = runAt.difference(DateTime.now());
    if (timeRemaining.isNegative) {
      return scheduledFunction();
    }

    _timer = Timer(timeRemaining, scheduledFunction);
  }
}
