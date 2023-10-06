import 'package:flutter/material.dart';
import '../../data/models/train_route.dart' as models;


class RouteWidget extends StatefulWidget {
  const RouteWidget(
      {super.key,
      required this.route});

  final models.TrainRoute route;

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
                Text(widget.route.startStation, style: const TextStyle(fontSize: 25)),
                Text(widget.route.endStation, style: const TextStyle(fontSize: 25))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.route.startTime, style: const TextStyle(fontSize: 20)),
                Text(widget.route.endTime, style: const TextStyle(fontSize: 20))
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
