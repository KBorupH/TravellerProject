import 'package:flutter/material.dart';
import 'package:traveller_app/_common_lib/widgets/ticket_widget.dart';

import '../../data/models/ticket.dart';

class TicketsScrollWidget extends StatefulWidget {
  const TicketsScrollWidget({super.key});

  @override
  State<TicketsScrollWidget> createState() => _TicketsScrollWidgetState();
}

class _TicketsScrollWidgetState extends State<TicketsScrollWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TicketWidget(ticket: Ticket("", "", "", "Ringsted", "Køge", "08:20", "08:40", "4", "231")       ),
          TicketWidget(ticket: Ticket("", "", "", "København H", "Odense", "18:30", "20:40", "1", "043")  ),
          TicketWidget(ticket: Ticket("", "", "", "Skagen", "Aarhus", "14:10", "17:50", "5", "114")       ),
          TicketWidget(ticket: Ticket("", "", "", "Sorø", "Næstved", "09:45", "11:15", "2", "325")        ),
          TicketWidget(ticket: Ticket("", "", "", "Næstved", "Sorø", "11:15 ", "09:45", "3", "314")       ),
          TicketWidget(ticket: Ticket("", "", "", "Sorø", "Skagen", "09:45", "15:54", "5", "201")         )
        ],
      ),
    );
  }
}
