import 'tracking_event.dart';

abstract class AnalyticsClient {
  Future<void> setCurrentScreen({required String screenClass, required String screenName});
  Future<void> trackEvent(TrackingEvent trackingEvent);
  Future<void> setUserId(String userId);
}
