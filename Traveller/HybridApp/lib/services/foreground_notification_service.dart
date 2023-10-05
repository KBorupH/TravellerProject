import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void requestNotificationPermission() async {
}

class ForegroundNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> _initLocalNotification(RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          // handle interaction when app is active for android
          _handleMessage(payload, message);
        });
  }

  void firebaseInit() {
    FirebaseMessaging.instance.subscribeToTopic("route_status");

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = notification?.android;
      AppleNotification? apple = notification?.apple;

      if (kIsWeb) {

      } else {
        if (Platform.isIOS) {
          _initForegroundMessage();
        } else if (Platform.isAndroid) {
          _initLocalNotification();
          _initForegroundMessage();
        }
      }

      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
            0,
            message.notification?.title,
            message.notification?.body,
            notificationDetails,
            payload: ext)
      });
    });
  }

  void requestNotificationPermission() async {

  }

  Future<String> getDeviceToken() async {
    return (await FirebaseMessaging.instance.getToken())!;
  }

  void _initForegroundMessage() {

  }

  void _messageHandler(NotificationResponse payload, RemoteMessage message) {
    //Do something in the app when local notification
  }

  Future _foregroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

}



