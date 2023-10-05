import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void requestNotificationPermission() async {
}

class ForegroundNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void firebaseInit() {
    FirebaseMessaging.instance.subscribeToTopic("route_status");

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = notification?.android;
      AppleNotification? apple = notification?.apple;

      if (kIsWeb) {

      } else {
        _initLocalNotification(message);

        if (Platform.isIOS) {
          _enableiOSForegroundMessage();
        } else if (Platform.isAndroid) {
        }

        _showNotification(message);

      }
    });
  }

  Future<void> _initLocalNotification(RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          // handle interaction when app is active for android
          _messageHandler(payload, message);
        });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }

  Future<String> getDeviceToken() async {
    return (await FirebaseMessaging.instance.getToken())!;
  }

  void _showNotification(RemoteMessage message) {
    NotificationDetails notificationDetails = NotificationDetails();

    if (Platform.isAndroid) {
      AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        importance: Importance.max,
        playSound: true,
        showBadge: true,
        enableVibration: true,
      );

      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        androidChannel.id.toString(),
        androidChannel.name.toString(),
      );

      notificationDetails = NotificationDetails(android: androidDetails);
    } else if (Platform.isIOS) {
      const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          presentBanner: true,
      );
      notificationDetails = const NotificationDetails(iOS: darwinDetails);
    }

    var ext = '';

    for (MapEntry<String, dynamic> item in message.data.entries) {
      ext += item.value as String;
      ext += '|';
    }

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          notificationDetails,
          payload: ext);
    });
  }

  void _messageHandler(NotificationResponse payload, RemoteMessage message) {
    //Do something in the app when local notification
  }

  Future _enableiOSForegroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

}



