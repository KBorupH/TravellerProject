import 'package:flutter/material.dart';
import 'package:traveller_app/_web_lib/widgets/web_route_widget.dart';
import 'package:traveller_app/_web_lib/widgets/web_search_widget.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.5,
              child: WebSearchWidget(),
            ),
            SingleChildScrollView(
              child: FractionallySizedBox(
                widthFactor: 0.4,
                child: Column(
                  children: [
                    WebRouteWidget(
                        startStation: "Ringsted",
                        endStation: "Køge",
                        startTime: "08:20",
                        endTime: "08:40"),
                    WebRouteWidget(
                        startStation: "København H",
                        endStation: "Odense",
                        startTime: "18:30",
                        endTime: "20:40"),
                    WebRouteWidget(
                        startStation: "Skagen",
                        endStation: "Aarhus",
                        startTime: "14:10",
                        endTime: "17:50"),
                    WebRouteWidget(
                        startStation: "Sorø",
                        endStation: "Næstved",
                        startTime: "09:45",
                        endTime: "11:15"),
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
