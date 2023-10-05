import 'package:flutter/material.dart';
import 'package:traveller_app/_common_lib/widgets/route_widget.dart';
import 'package:traveller_app/_web_lib/widgets/web_search_widget.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff84a4e3), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FractionallySizedBox(
                widthFactor: 0.8,
                child: WebSearchWidget(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: FractionallySizedBox(
                    widthFactor: 0.6,
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
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
