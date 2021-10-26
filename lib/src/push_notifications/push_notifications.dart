import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_medium/src/utils/app_colors.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'roomie_notifications', // id
  'roomie notifications', // title
  // 'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

notificationPermission() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    sound: true,
  );
}

getNotificationOpenedApp() {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    print("getNotificationOpenedApp data---" + notification.toString());
    selectNotification(json.encode(notification));
  });
}

getNotification() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    print("notification body---------------" + notification.body.toString());
    AndroidNotification android = message.notification.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.id,
              //  channel.description,
              color: AppColors.notificationColor,
              icon: 'medium_notification',
            ),
          ),
          payload: json.encode(message.data));
    }
  });
}

Future selectNotification(String payload) async {
  print('payload: $payload');
}
