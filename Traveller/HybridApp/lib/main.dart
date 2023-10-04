import 'package:flutter/material.dart';
import 'package:traveller_app/_app_lib/app_main.dart';
import 'package:traveller_app/_web_lib/web_router.dart';
import 'package:traveller_app/services/service_locator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart';

void main() {
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
    runApp(MaterialApp(
      title: title,
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const AppMain(),
    ));
  }
}
