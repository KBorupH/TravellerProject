import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveller_app/_app_lib/app_page.dart';
import 'package:traveller_app/_app_lib/screens/app_home_screen.dart';
import 'package:traveller_app/_app_lib/screens/app_login_screen.dart';
import 'package:traveller_app/_app_lib/screens/app_ticket_screen.dart';

import '../data/bloc/route_bloc.dart';
import '../data/bloc/ticket_bloc.dart';
import '../services/service_locator.dart';

class AppMain extends StatefulWidget {
  const AppMain({super.key});

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
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
      const AppLoginScreen()
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
                child: Image(image: AssetImage('assets/images/LogoWhite.png')))
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
      drawer: Drawer(
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
              onTap: () {
                // Navigate to other page and pop drawer
                toggleDrawer();
                _onItemTapped(AppPages.ticket);
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              selected: appPageNotifier.currentPage.index == 2,
              onTap: () {
                // Navigate to other page and pop drawer
                toggleDrawer();
                _onItemTapped(AppPages.login);
              },
            )
          ],
        ),
      ),
    );
  }
}
