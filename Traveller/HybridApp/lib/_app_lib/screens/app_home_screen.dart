import 'package:flutter/material.dart';

import '../../_common_lib/widgets/route_widget.dart';
import '../widgets/app_search_widget.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSearchWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Column(
                    children: [
                      RouteWidget(
                          startStation: "Ringsted",
                          endStation: "Køge",
                          startTime: "08:20",
                          endTime: "08:40"),
                      RouteWidget(
                          startStation: "København H",
                          endStation: "Odense",
                          startTime: "18:30",
                          endTime: "20:40"),
                      RouteWidget(
                          startStation: "Skagen",
                          endStation: "Aarhus",
                          startTime: "14:10",
                          endTime: "17:50"),
                      RouteWidget(
                          startStation: "Sorø",
                          endStation: "Næstved",
                          startTime: "09:45",
                          endTime: "11:15"),
                      RouteWidget(
                          startStation: "Sorø",
                          endStation: "Næstved",
                          startTime: "09:45",
                          endTime: "11:15"),
                      RouteWidget(
                          startStation: "Sorø",
                          endStation: "Næstved",
                          startTime: "09:45",
                          endTime: "11:15"),
                      RouteWidget(
                          startStation: "Sorø",
                          endStation: "Næstved",
                          startTime: "09:45",
                          endTime: "11:15"),
                      RouteWidget(
                          startStation: "Sorø",
                          endStation: "Næstved",
                          startTime: "09:45",
                          endTime: "11:15"),
                      RouteWidget(
                          startStation: "Sorø",
                          endStation: "Næstved",
                          startTime: "09:45",
                          endTime: "11:15"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
