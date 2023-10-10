import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller_app/_web_lib/screens/web_home_screen.dart';
import 'package:traveller_app/_web_lib/screens/web_ticket_screen.dart';
import 'package:traveller_app/_web_lib/widgets/web_navigation_bar.dart';
import 'package:traveller_app/services/service_locator.dart';

import '../data/bloc/route_bloc.dart';
import '../data/bloc/ticket_bloc.dart';

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
    redirect: (context, state) {
      late bool isLoggedIn = true;
      late bool isGoingToTicket = false;
      // isGoingToTicket = state. == state.namedLocation(WebPages.ticket.toPath);
      // isLoggedIn = appService.loginState;

      //redirect to home if trying to access ticket without being logged in.
      if (isGoingToTicket && !isLoggedIn) return WebPages.home.toPath;

      //no need to redirect
      return null;
    }
  );
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
