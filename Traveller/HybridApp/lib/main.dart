import 'package:flutter/material.dart';
import 'package:traveller_app/_app_lib/app_main.dart';
import 'package:traveller_app/_web_lib/web_main.dart';
import 'package:traveller_app/services/service_locator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_strategy/url_strategy.dart';


void main() {
  setupApi();
  if (kIsWeb) {
    // running on the web!
    setPathUrlStrategy();
    runApp(const WebMain());
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const AppMain());
  }
}


