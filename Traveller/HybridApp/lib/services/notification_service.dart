import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

import '../firebase_options.dart';

Future<void> notificationInit() async {
  final NotificationService notificationService = NotificationService();

  notificationService.requestNotificationPermission();
  notificationService.firebaseInit();
  print("Device Firebase Token: ${await notificationService.getDeviceToken()}");
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = notification?.android;
      AppleNotification? apple = notification?.apple;

      if (kIsWeb) {
      } else {
        _initLocalNotification(message);

        if (Platform.isIOS || Platform.isMacOS) {
          _enableiOSForegroundMessage();
        } else if (Platform.isAndroid) {}

        _showNotification(message);
      }
    });
  }

  Future<void> _initLocalNotification(RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android
      _foregroundMessageHandler(payload, message);
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
    if (Platform.isWindows) {
      final _winNotifyPlugin = WindowsNotification(
          applicationId: "898056cc-074e-4fc3-b334-d443fba63e0b");

      // create new NotificationMessage instance with id, title, body, and images
      NotificationMessage message = NotificationMessage.fromPluginTemplate(
          "test1", "TEXT", "TEXT",
          image: "assets");

      // show notification
      _winNotifyPlugin.showNotificationPluginTemplate(message);
    } else {
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
          channelAction: AndroidNotificationChannelAction.update,
          importance: Importance.high,
          priority: Priority.high
        );

        notificationDetails = NotificationDetails(android: androidDetails);
      } else if (Platform.isIOS) {
        const DarwinNotificationDetails darwinDetails =
            DarwinNotificationDetails(
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
        _flutterLocalNotificationsPlugin.show(0, message.notification?.title,
            message.notification?.body, notificationDetails,
            payload: ext);
      });
    }
  }

  Future _enableiOSForegroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _foregroundMessageHandler(
      NotificationResponse payload, RemoteMessage message) {
    //Do something in the app on notification
  }
}
