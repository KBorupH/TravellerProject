import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:traveller_app/_app_lib/screens/app_home_screen.dart';
import 'package:traveller_app/_app_lib/screens/app_login_screen.dart';
import 'package:traveller_app/_app_lib/screens/app_ticket_screen.dart';

class AppMain extends StatefulWidget {
  const AppMain({super.key});

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  // Reloads body, with new index, loading a different page.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      AppHomeScreen(),
      AppTicketScreen(),
      AppLoginScreen()
    ];

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Yay! A notification!'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        ));
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Stack(
            children: [
              IconButton(
                  onPressed: () => toggleDrawer(),
                  icon: const Icon(Icons.menu)),
              const Center(
                  child:
                      Image(image: AssetImage('assets/images/LogoWhite.png')))
            ],
          )),
      body: SafeArea(child: widgetScreens[_selectedIndex]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text("Menu")),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              selected: _selectedIndex == 0,
              onTap: () {
                // Navigate to other page and pop drawer
                toggleDrawer();
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sticky_note_2),
              title: const Text("Tickets"),
              selected: _selectedIndex == 1,
              onTap: () {
                // Navigate to other page and pop drawer
                toggleDrawer();
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              selected: _selectedIndex == 2,
              onTap: () {
                // Navigate to other page and pop drawer
                toggleDrawer();
                _onItemTapped(2);
              },
            )
          ],
        ),
      ),
    );
  }
}
