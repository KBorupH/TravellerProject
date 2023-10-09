import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveller_app/_common_lib/widgets/tickets_scroll_widget.dart';
import 'package:traveller_app/data/bloc/events/ticket_events.dart';
import 'package:traveller_app/data/bloc/ticket_bloc.dart';

class WebTicketScreen extends StatefulWidget {
  const WebTicketScreen({super.key});

  @override
  State<WebTicketScreen> createState() => _WebTicketScreenState();
}

class _WebTicketScreenState extends State<WebTicketScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff84a4e3), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const FractionallySizedBox(
              widthFactor: 0.6, child: TicketsScrollWidget()),
        ),
      ),
    );
  }
}
