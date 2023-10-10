import 'package:flutter/material.dart';

import '../../data/models/ticket.dart';

class TicketWidget extends StatefulWidget {
  const TicketWidget(
      {super.key,
        required this.ticket});

  final Ticket ticket;

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.ticket.startStation, style: const TextStyle(fontSize: 25)),
                Text(widget.ticket.endStation, style: const TextStyle(fontSize: 25))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.ticket.startTime, style: const TextStyle(fontSize: 20)),
                Text(widget.ticket.endTime, style: const TextStyle(fontSize: 20))
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Platform: ${widget.ticket.platformNr}",
                    style: const TextStyle(fontSize: 25)),
                Text("Seat Nr: ${widget.ticket.seatId}",
                    style: const TextStyle(fontSize: 25))
              ],
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_down))
          ],
        ),
      ),
    );
  }
}
