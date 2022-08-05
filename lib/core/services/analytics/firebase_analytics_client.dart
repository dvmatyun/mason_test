import 'package:flutter_mason/core/services/logger/logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'analytics_client.dart';
import 'tracking_event.dart';

class FirebaseAnalyticsClient implements AnalyticsClient {
  late FirebaseAnalytics firebaseAnalytics;

  FirebaseAnalyticsClient({FirebaseAnalytics? firebaseAnalytics})
      : firebaseAnalytics = firebaseAnalytics ?? FirebaseAnalytics.instance;

  @override
  Future<void> setCurrentScreen({required String screenClass, required String screenName}) {
    log.d('Analytics: setting screen to $screenClass: $screenName');
    return firebaseAnalytics.setCurrentScreen(screenName: screenName, screenClassOverride: screenClass);
  }

  @override
  Future<void> trackEvent(TrackingEvent trackingEvent) {
    log.d(
        'Analytics: sent tracking event ${trackingEvent.eventName} with parameters ${trackingEvent.parameters.toString()}');
    return firebaseAnalytics.logEvent(name: trackingEvent.eventName, parameters: trackingEvent.parameters);
  }

  @override
  Future<void> setUserId(String userId) {
    return firebaseAnalytics.setUserId(id: userId);
  }
}
