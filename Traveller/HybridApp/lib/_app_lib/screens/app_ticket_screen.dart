import 'package:flutter/material.dart';

import '../../_common_lib/widgets/tickets_scroll_widget.dart';

class AppTicketScreen extends StatefulWidget {
  const AppTicketScreen({super.key});

  @override
  State<AppTicketScreen> createState() => _AppTicketScreenState();
}

class _AppTicketScreenState extends State<AppTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff6b97c9), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const FractionallySizedBox(
              widthFactor: 0.9, child: TicketsScrollWidget()),
        ),
      ),
    );
  }
}
