import 'package:flutter/material.dart';
import 'package:traveller_app/_common_lib/widgets/ticket_widget.dart';

class TicketsScrollWidget extends StatefulWidget {
  const TicketsScrollWidget({super.key});

  @override
  State<TicketsScrollWidget> createState() => _TicketsScrollWidgetState();
}

class _TicketsScrollWidgetState extends State<TicketsScrollWidget> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          TicketWidget(
              startStation: "Ringsted",
              endStation: "Køge",
              startTime: "08:20",
              endTime: "08:40",
              platformNr: "4",
              seatNr: "231"),
          TicketWidget(
              startStation: "København H",
              endStation: "Odense",
              startTime: "18:30",
              endTime: "20:40",
              platformNr: "1",
              seatNr: "043"),
          TicketWidget(
              startStation: "Skagen",
              endStation: "Aarhus",
              startTime: "14:10",
              endTime: "17:50",
              platformNr: "5",
              seatNr: "114"),
          TicketWidget(
              startStation: "Sorø",
              endStation: "Næstved",
              startTime: "09:45",
              endTime: "11:15",
              platformNr: "2",
              seatNr: "325"),
          TicketWidget(
              startStation: "Næstved",
              endStation: "Sorø",
              startTime: "11:15 ",
              endTime: "09:45",
              platformNr: "3",
              seatNr: "314"),
          TicketWidget(
              startStation: "Sorø",
              endStation: "Skagen",
              startTime: "09:45",
              endTime: "15:54",
              platformNr: "5",
              seatNr: "201")
        ],
      ),
    );
  }
}
