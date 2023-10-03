import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller_app/_web_lib/screens/web_home_screen.dart';
import 'package:traveller_app/_web_lib/screens/web_ticket_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Row(
                children: [
                  const Text("Traveller Web"),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
                    child: ElevatedButton(
                      onPressed: () => context.go('/'),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.train),
                          SizedBox(
                            width: 3,
                          ),
                          Text("Routes")
                        ],
                      ),
                    ),
                  )
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    onPressed: () => context.go('/tickets'),
                    child: const Row(
                      children: [
                        Icon(Icons.sticky_note_2),
                        Text("Tickets"),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.login),
                          Text("Login"),
                        ],
                      ),
                    )),
              ],
            ),
            body: SafeArea(
              child: child,
            ),
          );
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
        )));

class WebMain extends StatelessWidget {
  const WebMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Traveller',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
