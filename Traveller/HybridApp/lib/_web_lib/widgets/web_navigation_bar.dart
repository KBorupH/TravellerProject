import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller_app/_web_lib/widgets/web_login_widget.dart';

class WebNavigationBar extends StatelessWidget {
  const WebNavigationBar({super.key, required this.body});

  final Widget body;

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
                onPressed: () => context.go('/'),
              ),
            ),
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
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return const WebLoginWidget();
                      });
                },
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
        child: body,
      ),
    );
  }
}
