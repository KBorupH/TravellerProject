import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:traveller_app/_app_lib/app_main.dart';
import 'package:traveller_app/_web_lib/web_main.dart';
import 'package:traveller_app/services/service_locator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Conditional imports to avoid conflicts of packages between app and web
import 'package:traveller_app/platform_configs/urlstrategy.dart' // A stub, only present to expose the setUrlPathing method.
if (dart.library.io) 'package:traveller_app/platform_configs/urlstrategy_mobile.dart' //Is exposed to mobile, i.e. a functionless method
if (dart.library.js) 'package:traveller_app/platform_configs/urlstrategy_web.dart'; //Is exposed to web, actual pathing method.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //SubscribeToTopic not allowed on web
  if(!kIsWeb) FirebaseMessaging.instance.subscribeToTopic("route_status");

  print("Device Firebase Token: ${await FirebaseMessaging.instance.getToken()}");

  setupApi();

  const String title = "Traveller";
  ThemeData themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff003366)),
      useMaterial3: true);

  if (kIsWeb) { // running on the web!

    // Even while in this condition or further in the webmain widgets,
    // the import is still loaded, and should be conditional,
    // even if mobile shouldn't reach this line.
    setUrlPathing();
    runApp(WebMain(title: title, theme: themeData));
  } else {
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

    runApp(AppMain(title: title, theme: themeData));
  }
}
