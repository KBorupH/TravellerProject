import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:traveller_app/_app_lib/app_main.dart';
import 'package:traveller_app/_web_lib/web_main.dart';
import 'package:traveller_app/services/foreground_notification_service.dart';
import 'package:traveller_app/services/service_locator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final ForegroundNotificationService foregroundNotificationService =
  ForegroundNotificationService();

  foregroundNotificationService.requestNotificationPermission();
  foregroundNotificationService.firebaseInit();

  const String title = "Traveller";
  ThemeData themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff003366)),
      useMaterial3: true
  );

  setupApi();

  if (kIsWeb) { // running on the web!
    setPathUrlStrategy();
    runApp(MaterialApp.router(
      title: title,
      theme: themeData,
      debugShowCheckedModeBanner: false,
      routerConfig: getWebRouter(),
    ));
  } else {
    runApp(MaterialApp(
      title: title,
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const AppMain(),
    ));

    // 898056cc-074e-4fc3-b334-d443fba63e0b
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.messageId}");
  print("Handling a background message: ${message.data}");
  print("Handling a background message: ${message.notification}");
}