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


Future<void> main() async {
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
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    print(await getDeviceToken());

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );



    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    runApp(MaterialApp(
      title: title,
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const AppMain(),
    ));
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