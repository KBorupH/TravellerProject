import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveller_app/_app_lib/app_main.dart';
import 'package:traveller_app/_web_lib/web_main.dart';
import 'package:traveller_app/data/bloc/route_bloc.dart';
import 'package:traveller_app/data/bloc/ticket_bloc.dart';
import 'package:traveller_app/services/notification_service.dart';
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

  //SubscribeToTopic not allowed on web
  if(!kIsWeb) FirebaseMessaging.instance.subscribeToTopic("route_status");

  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);


  late final MaterialApp platformApp;

  notificationInit();
  setupApi();

  const String title = "Traveller";
  ThemeData themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff003366)),
      useMaterial3: true);

  if (kIsWeb) {
    // running on the web!
    setPathUrlStrategy();
    platformApp = MaterialApp.router(
      title: title,
      theme: themeData,
      debugShowCheckedModeBanner: false,
      routerConfig: getWebRouter(),
    );
  } else {
    platformApp = MaterialApp(
      title: title,
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const AppMain(),
    );
  }

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<RouteBloc>(
        create: (BuildContext context) => locator<RouteBloc>(),
      ),
      BlocProvider<TicketBloc>(
        create: (BuildContext context) => locator<TicketBloc>(),
      ),
    ], child: platformApp),
  );
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  //Do something outside of the app on notification

}
