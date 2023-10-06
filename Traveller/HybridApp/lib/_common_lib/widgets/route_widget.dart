import 'package:flutter/material.dart';

class RouteWidget extends StatefulWidget {
  const RouteWidget(
      {super.key,
      required this.startStation,
      required this.endStation,
      required this.startTime,
      required this.endTime});

  final String startStation;
  final String endStation;
  final String startTime;
  final String endTime;

  @override
  State<RouteWidget> createState() => _RouteWidgetState();
}

class _RouteWidgetState extends State<RouteWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_down))
          ],
        ),
      ),
    );
  }
}
