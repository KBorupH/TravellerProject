import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveller_app/_common_lib/widgets/ticket_widget.dart';
import 'package:traveller_app/data/bloc/states/ticket_states.dart';

import '../../data/bloc/events/ticket_events.dart';
import '../../data/bloc/ticket_bloc.dart';

class TicketsScrollWidget extends StatefulWidget {
  const TicketsScrollWidget({super.key});

  @override
  State<TicketsScrollWidget> createState() => _TicketsScrollWidgetState();
}

class _TicketsScrollWidgetState extends State<TicketsScrollWidget> {
  late bool _ticketsLoading = true;

  @override
  void initState() {
    super.initState();
    final TicketBloc ticketBloc = BlocProvider.of<TicketBloc>(context);
    ticketBloc.add(GetAllTicketsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketBloc, TicketState>(
        listener: (listenContext, state) {
          if (state.currentState == TicketStates.complete) {
            setState(() {
              _ticketsLoading = false;
            });
          }
        },
        child: _ticketsLoading
            ? const CircularProgressIndicator()
            : BlocBuilder<TicketBloc, TicketState>(
          builder: (blocContext, TicketState state) {
            return SingleChildScrollView(
              child: Column(
                children: state.tickets
                    .map(
                      (ticket) => TicketWidget(ticket: ticket),
                )
                    .toList(),
              ),
            );
          },
        ),
    );
  }
}
