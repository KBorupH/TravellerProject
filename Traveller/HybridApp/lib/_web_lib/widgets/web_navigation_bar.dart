import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller_app/_web_lib/web_main.dart';
import 'package:traveller_app/_web_lib/widgets/web_login_widget.dart';
import 'package:traveller_app/_web_lib/widgets/web_register_widget.dart';

class WebNavigationBar extends StatefulWidget {
  const WebNavigationBar({super.key, required this.body});

  final Widget body;

  @override
  State<WebNavigationBar> createState() => _WebNavigationBarState();
}

class _WebNavigationBarState extends State<WebNavigationBar> {
  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            SizedBox(
              width: 150,
              child: IconButton(
                icon: Image.asset('assets/images/LogoWhite.png'),
                iconSize: 10,
                onPressed: () => context.go(WebPages.home.toPath),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
              child: ElevatedButton(
                onPressed: () => context.go(WebPages.home.toPath),
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
              onPressed:
                  loggedIn ? () => context.go(WebPages.ticket.toPath) : null,
              style: ButtonStyle(backgroundColor:
                  MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return Theme.of(context).colorScheme.background.withOpacity(0.5);
                return null; // Use the component's default.
              })),
              child: const Row(
                children: [
                  Icon(Icons.sticky_note_2),
                  Text("Tickets"),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !loggedIn,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: ElevatedButton(
                onPressed: () async {
                  loggedIn = await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return const WebLoginWidget();
                      });
                  //Needed to make the navigation bar reactive. Setstate has no effect, probably locked by GoRouter
                  context.go(GoRouterState.of(context).matchedLocation);
                },
                child: const Row(
                  children: [
                    Icon(Icons.login),
                    Text("Login"),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: !loggedIn,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: ElevatedButton(
                onPressed: () async {
                  loggedIn = await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return const WebRegisterWidget();
                      });
                  //Needed to make the navigation bar reactive. Setstate has no effect, probably locked by GoRouter
                  context.go(GoRouterState.of(context).matchedLocation);
                },
                child: const Row(
                  children: [
                    Icon(Icons.app_registration),
                    Text("Register"),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: loggedIn,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Icons.account_circle_rounded),
                    Text("Account"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: widget.body,
      ),
    );
  }
}
