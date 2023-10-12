import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:traveller_app/_web_lib/widgets/web_toast_notification_widget.dart';
import '../data/bloc/route_bloc.dart';
import '../data/bloc/ticket_bloc.dart';
import 'app_start.dart';

class AppMain extends StatefulWidget {
  const AppMain({super.key, required this.title, required this.theme});

  final String title;
  final ThemeData theme;

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  @override
  void initState() {
    super.initState();
    firebaseMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RouteBloc>(
            create: (BuildContext context) => RouteBloc(),
          ),
          BlocProvider<TicketBloc>(
            create: (BuildContext context) => TicketBloc(),
          ),
        ],
        child: MaterialApp(
          title: widget.title,
          theme: widget.theme,
          debugShowCheckedModeBanner: false,
          home: const AppStart(),
        ));
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void firebaseMessageListener() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = notification?.android;
      AppleNotification? apple = notification?.apple;

      _initLocalNotification(message);

      if (Platform.isIOS || Platform.isMacOS) {
        _enableiOSForegroundMessage();
      } else if (Platform.isAndroid) {}

      _showNotification(message);
    });
  }

  Future _enableiOSForegroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
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

  void _foregroundMessageHandler(
      NotificationResponse payload, RemoteMessage message) {
    //Do something in the app on notification
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
          androidChannel.id.toString(), androidChannel.name.toString(),
          channelAction: AndroidNotificationChannelAction.update,
          importance: Importance.max,
          priority: Priority.max);

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

    _flutterLocalNotificationsPlugin.show(0, message.notification?.title,
        message.notification?.body, notificationDetails,
        payload: ext);
  }
}
