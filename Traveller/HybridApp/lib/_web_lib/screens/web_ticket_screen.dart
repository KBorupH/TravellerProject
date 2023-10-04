import 'package:flutter/material.dart';

import '../widgets/web_ticket_widget.dart';

class WebTicketScreen extends StatefulWidget {
  const WebTicketScreen({super.key});

  @override
  State<WebTicketScreen> createState() => _WebTicketScreenState();
}

class _WebTicketScreenState extends State<WebTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: FractionallySizedBox(
                widthFactor: 0.6,
                child: Column(
                  children: [
                    WebTicketWidget(
                        startStation: "Ringsted",
                        endStation: "Køge",
                        startTime: "08:20",
                        endTime: "08:40",
                        platformNr: "4",
                        seatNr: "231"),
                    WebTicketWidget(
                        startStation: "København H",
                        endStation: "Odense",
                        startTime: "18:30",
                        endTime: "20:40",
                        platformNr: "1",
                        seatNr: "043"),
                    WebTicketWidget(
                        startStation: "Skagen",
                        endStation: "Aarhus",
                        startTime: "14:10",
                        endTime: "17:50",
                        platformNr: "5",
                        seatNr: "114"),
                    WebTicketWidget(
                        startStation: "Sorø",
                        endStation: "Næstved",
                        startTime: "09:45",
                        endTime: "11:15",
                        platformNr: "2",
                        seatNr: "325"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
