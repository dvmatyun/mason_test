extension DateTimeUtils on DateTime {
  String toTimeString() {
    return '$hour:${minute.toString().padLeft(2, '0')}';
  }

  String toTimeStringIncludingTimeZone() {
    final dateTime = DateTime.now();
    final time = add(dateTime.timeZoneOffset);
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}
