import 'package:flutter_mason/app/resources/business_constants.dart';
import 'package:flutter_mason/core/data/local/hive.dart';
import 'package:flutter_mason/core/services/push_notifications/firebase_cloud_messages_handler.dart';
import 'package:flutter_mason/core/services/push_notifications/local_notification_controls.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

class ServicesInitializer {
  Future initAppServices() async {
    await EasyLocalization.ensureInitialized();
    await HiveUtils.initHive();
    await Firebase.initializeApp();
    await Intercom.instance.initialize(
      BusinessConstants.intercomAppKey,
      androidApiKey: BusinessConstants.intercomAndroidKey,
      iosApiKey: BusinessConstants.intercomIosKey,
    );
    await configureLocalNotifications();
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen(handleFirebaseRemoteMessage);
    FirebaseMessaging.onBackgroundMessage(handleFirebaseRemoteMessage);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    /// Stripe:
    Stripe.publishableKey = BusinessConstants.stripePublicKey;
    Stripe.merchantIdentifier = 'merchant.citya.stripe';
    Stripe.urlScheme = 'flutterstripe';

    await Stripe.instance.applySettings();
  }
}
