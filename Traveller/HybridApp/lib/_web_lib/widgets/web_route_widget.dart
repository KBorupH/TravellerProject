import 'package:flutter/material.dart';

class WebRouteWidget extends StatefulWidget {
  const WebRouteWidget(
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
  State<WebRouteWidget> createState() => _WebRouteWidgetState();
}

class _WebRouteWidgetState extends State<WebRouteWidget> {
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
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_down))
          ],
        ),
      ),
    );
  }
}
