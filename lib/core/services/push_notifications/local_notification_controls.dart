import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Set of top-level configurations for local push notifications logic
/// These cannot be members of any class since they should be used in the top-level Push handlers, so they have to be kept like that

late FlutterLocalNotificationsPlugin _localNotifications;

const defaultAndroidNotificationsChannel = AndroidNotificationChannel(
  'default_citya_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for custom Citya notifications.', // description
  importance: Importance.high,
);

/// Initial configuration for incoming notifications
Future configureLocalNotifications() async {
  _localNotifications = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(defaultAndroidNotificationsChannel);
}

/// Show a foreground notification on device
void showLocalNotification({
  required int id,
  required String title,
  required String body,
}) {
  _localNotifications = FlutterLocalNotificationsPlugin();
  _localNotifications.show(
    id,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        defaultAndroidNotificationsChannel.id,
        defaultAndroidNotificationsChannel.name,
        channelDescription: defaultAndroidNotificationsChannel.description,
        icon: "@mipmap/ic_launcher",
        playSound: false,
      ),
      iOS: const IOSNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: false,
      ),
    ),
  );
}
