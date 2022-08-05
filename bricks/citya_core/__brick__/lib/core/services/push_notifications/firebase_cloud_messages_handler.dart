import 'package:firebase_messaging/firebase_messaging.dart';

/// Set of top-level handler functions dedicated to Push Notification handling
/// These cannot be members of any class, so they have to be kept like that

/// Remote message handler should ALWAYS be a top-level function and not a class member or anonymous function
Future handleFirebaseRemoteMessage(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  if (notification == null) return;
  // TODO: enable when we need foreground notifications
  // showLocalNotification(
  //   id: notification.hashCode,
  //   title: notification.title ?? '',
  //   body: notification.body ?? '',
  // );
}
