import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:traveller_app/_web_lib/screens/web_home_screen.dart';
import 'package:traveller_app/_web_lib/screens/web_ticket_screen.dart';
import 'package:traveller_app/_web_lib/widgets/web_navigation_bar.dart';
import 'package:traveller_app/_web_lib/widgets/web_toast_notification_widget.dart';
import 'package:traveller_app/services/service_locator.dart';


import '../data/bloc/route_bloc.dart';
import '../data/bloc/ticket_bloc.dart';

class WebMain extends StatefulWidget {
  const WebMain({super.key, required this.title, required this.theme});

  final String title;
  final ThemeData theme;


  @override
  State<WebMain> createState() => _WebMainState();
}

class _WebMainState extends State<WebMain> {
  @override
  void initState() {
    messageListener();
    super.initState();
  }

  Future<void> messageListener() async {
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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      String? title = notification?.title;
      String? body = notification?.body;
      if (notification != null && title != null && body != null) {
        showToastWidget(
            WebToastNotificationWidget(title: title, body: body),
            position: ToastPosition.bottom,
            duration: const Duration(seconds: 4),
          dismissOtherToast: true,
        );
      }
    });
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
      child: OKToast(

        child: MaterialApp.router(
          title: widget.title,
          theme: widget.theme,
          debugShowCheckedModeBanner: false,
          routerConfig: getWebRouter(),
        ),
      ),
    );
  }
}

GoRouter getWebRouter() {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  final TicketBloc ticketBloc = locator<TicketBloc>();
  final RouteBloc routeBloc = locator<RouteBloc>();

  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: WebPages.home.toRoutePath,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return WebNavigationBar(body: child);
          },
          routes: [
            // This screen is displayed on the ShellRoute's Navigator.
            GoRoute(
              path: WebPages.home.toRoutePath,
              name: WebPages.home.toName,
              builder: (homeContext, GoRouterState state) {
                return MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: ticketBloc,
                  ),
                  BlocProvider.value(
                    value: routeBloc,
                  ),
                ], child: const WebHomeScreen());
              },
              routes: <RouteBase>[
                GoRoute(
                  path: WebPages.ticket.toRoutePath,
                  name: WebPages.ticket.toName,
                  builder: (ticketContext, GoRouterState state) {
                    return MultiBlocProvider(providers: [
                      BlocProvider.value(
                        value: ticketBloc,
                      ),
                      BlocProvider.value(
                        value: routeBloc,
                      ),
                    ], child: const WebTicketScreen());
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
            body: Text(
              state.error.toString(),
            ),
          ),
      redirect: (context, state) async {
        late bool isLoggedIn = true;
        late bool isGoingToTicket = false;
        isGoingToTicket = state.matchedLocation == state.namedLocation(WebPages.ticket.toName);
        isLoggedIn = await SessionManager().containsKey("tokenKey");

        //redirect to home if trying to access ticket without being logged in.
        if (isGoingToTicket && !isLoggedIn) return WebPages.home.toPath;

        //no need to redirect
        return null;
      });
}

enum WebPages {
  home,
  ticket,
}

extension WebPageExtension on WebPages {
  String get toPath {
    switch (this) {
      case WebPages.home:
        return "/";
      case WebPages.ticket:
        return "/ticket";
      default:
        return "/";
    }
  }

  String get toRoutePath {
    switch (this) {
      case WebPages.home:
        return "/";
      case WebPages.ticket:
        return "ticket";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case WebPages.home:
        return "Home";
      case WebPages.ticket:
        return "Ticket";
      default:
        return "Home";
    }
  }
}
