import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller_app/_web_lib/screens/web_home_screen.dart';
import 'package:traveller_app/_web_lib/screens/web_ticket_screen.dart';
import 'package:traveller_app/_web_lib/widgets/web_navigation_bar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return WebNavigationBar(body: child);
      },
      routes: [
        // This screen is displayed on the ShellRoute's Navigator.
        GoRoute(
          path: '/',
          builder: (homeContext, GoRouterState state) {
            return const WebHomeScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'tickets',
              builder: (ticketContext, GoRouterState state) {
                return const WebTicketScreen();
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
);

GoRouter getWebRouter(){
  return _router;
}


