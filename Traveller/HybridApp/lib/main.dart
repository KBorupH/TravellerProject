import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveller_app/_app_lib/app_main.dart';
import 'package:traveller_app/_web_lib/web_main.dart';
import 'package:traveller_app/data/bloc/route_bloc.dart';
import 'package:traveller_app/data/bloc/ticket_bloc.dart';
import 'package:traveller_app/services/service_locator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //SubscribeToTopic not allowed on web
  if(!kIsWeb) FirebaseMessaging.instance.subscribeToTopic("route_status");

  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

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
  print("Device Firebase Token: ${await FirebaseMessaging.instance.getToken()}");

  setupApi();

  const String title = "Traveller";
  ThemeData themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff003366)),
      useMaterial3: true);

  if (kIsWeb) {
    // running on the web!
    setUrlStrategy(PathUrlStrategy());
    runApp(WebMain(title: title, theme: themeData));
  } else {
    runApp(AppMain(title: title, theme: themeData));
  }
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  //Do something outside of the app on notification

}
