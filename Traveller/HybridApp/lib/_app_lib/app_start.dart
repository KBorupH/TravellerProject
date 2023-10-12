import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveller_app/_app_lib/notifiers/app_drawer_notifier.dart';
import 'package:traveller_app/_app_lib/screens/app_home_screen.dart';
import 'package:traveller_app/_app_lib/screens/app_login_screen.dart';
import 'package:traveller_app/_app_lib/screens/app_register_screen.dart';
import 'package:traveller_app/_app_lib/screens/app_ticket_screen.dart';

import '../data/bloc/route_bloc.dart';
import '../data/bloc/ticket_bloc.dart';
import 'notifiers/app_page_notifier.dart';

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Reloads body, with new index, loading a different page.
  void _onItemTapped(AppPages page) {
    setState(() {
      appPageNotifier.changePage(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TicketBloc ticketBloc = BlocProvider.of<TicketBloc>(context);
    final RouteBloc routeBloc = BlocProvider.of<RouteBloc>(context);

    // Method to open and close menu drawer.
    // Miniminzes Context pops.
    toggleDrawer() async {
      if (_scaffoldKey.currentState != null) {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          _scaffoldKey.currentState?.openEndDrawer();
        } else {
          _scaffoldKey.currentState?.openDrawer();
        }
      }
    }

    // Widget list to cycle through
    List<Widget> widgetScreens = <Widget>[
      const AppHomeScreen(),
      const AppTicketScreen(),
      const AppLoginScreen(),
      const AppRegisterScreen()
    ];

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Stack(
            children: [
              IconButton(
                  onPressed: () => toggleDrawer(),
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 20,
                  )),
              const Center(
                  child:
                      Image(image: AssetImage('assets/images/LogoWhite.png')))
            ],
          ),
        ),
        body: ListenableBuilder(
          listenable: appPageNotifier,
          builder: (context, child) {
            return SafeArea(
                child: MultiBlocProvider(providers: [
              BlocProvider.value(
                value: ticketBloc,
              ),
              BlocProvider.value(
                value: routeBloc,
              ),
            ], child: widgetScreens[appPageNotifier.currentPage.index]));
          },
        ),
        drawer: ListenableBuilder(
          listenable: appDrawerNotifier,
          builder: (context, child) {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    child: Image(
                      image: AssetImage('assets/images/Logo.png'),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Home"),
                    selected: appPageNotifier.currentPage.index == 0,
                    onTap: () {
                      // Navigate to other page and pop drawer
                      toggleDrawer();
                      _onItemTapped(AppPages.home);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.sticky_note_2),
                    title: const Text("Tickets"),
                    selected: appPageNotifier.currentPage.index == 1,
                    enabled: appDrawerNotifier.loggedIn,
                    onTap: () {
                      // Navigate to other page and pop drawer
                      toggleDrawer();
                      _onItemTapped(AppPages.ticket);
                    },
                  ),
                  Visibility(
                    visible: !appDrawerNotifier.loggedIn,
                    child: ListTile(
                      leading: const Icon(Icons.login),
                      title: const Text("Login"),
                      selected: appPageNotifier.currentPage.index == 2,
                      onTap: () {
                        // Navigate to other page and pop drawer
                        toggleDrawer();
                        _onItemTapped(AppPages.login);
                      },
                    ),
                  ),
                  Visibility(
                    visible: !appDrawerNotifier.loggedIn,
                    child: ListTile(
                      leading: const Icon(Icons.app_registration),
                      title: const Text("Register"),
                      selected: appPageNotifier.currentPage.index == 3,
                      onTap: () {
                        // Navigate to other page and pop drawer
                        toggleDrawer();
                        _onItemTapped(AppPages.register);
                      },
                    ),
                  ),
                  Visibility(
                    visible: appDrawerNotifier.loggedIn,
                    child: ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text("Account"),
                      onTap: () {
                        // Navigate to other page and pop drawer
                        // toggleDrawer();
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
