import 'package:flutter/material.dart';

class WebTicketWidget extends StatefulWidget {
  const WebTicketWidget(
      {super.key,
      required this.startStation,
      required this.endStation,
      required this.startTime,
      required this.endTime,
      required this.platformNr,
      required this.seatNr});

  final String startStation;
  final String endStation;
  final String startTime;
  final String endTime;
  final String platformNr;
  final String seatNr;

  @override
  State<WebTicketWidget> createState() => _WebTicketWidgetState();
}

class _WebTicketWidgetState extends State<WebTicketWidget> {
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
                Text(widget.startStation, style: const TextStyle(fontSize: 25)),
                Text(widget.endStation, style: const TextStyle(fontSize: 25))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.startTime, style: const TextStyle(fontSize: 20)),
                Text(widget.endTime, style: const TextStyle(fontSize: 20))
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Platform: ${widget.platformNr}",
                    style: const TextStyle(fontSize: 25)),
                Text("Seat Nr: ${widget.seatNr}",
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
