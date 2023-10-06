import 'package:flutter/material.dart';
import 'package:traveller_app/_common_lib/widgets/route_widget.dart';
import 'package:traveller_app/_web_lib/widgets/web_search_widget.dart';

import '../../data/models/train_route.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FractionallySizedBox(
                widthFactor: 0.8,
                child: WebSearchWidget(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: FractionallySizedBox(
                    widthFactor: 0.6,
                    child: Column(
                      children: [
                        RouteWidget(route: TrainRoute("1","Ringsted","Køge","08:20","08:40"),     ),
                        RouteWidget(route: TrainRoute("2","København H","Odense","18:30","20:40") ),
                        RouteWidget(route: TrainRoute("3","Skagen","Aarhus","14:10","17:50")      ),
                        RouteWidget(route: TrainRoute("4","Sorø","Næstved","09:45","11:15")       ),
                        RouteWidget(route: TrainRoute("5","Sorø","Næstved","09:45","11:15")       ),
                        RouteWidget(route: TrainRoute("4","Sorø","Næstved","09:45","11:15")       ),
                        RouteWidget(route: TrainRoute("4","Sorø","Næstved","09:45","11:15")       ),
                        RouteWidget(route: TrainRoute("4","Sorø","Næstved","09:45","11:15")       ),
                        RouteWidget(route: TrainRoute("4","Sorø","Næstved","09:45","11:15")       ),
                        RouteWidget(route: TrainRoute("4","Sorø","Næstved","09:45","11:15")       ),
                        RouteWidget(route: TrainRoute("4","Sorø","Næstved","09:45","11:15")       ),
                        RouteWidget(route: TrainRoute("4","Sorø","Næstved","09:45","11:15")       ),
                        RouteWidget(route: TrainRoute("4","Sorø","Næstved","09:45","11:15")       ),
                        RouteWidget(route: TrainRoute("4","Sorø","Næstved","09:45","11:15")       ),
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
