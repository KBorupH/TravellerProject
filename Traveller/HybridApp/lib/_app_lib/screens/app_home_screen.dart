import 'package:flutter/material.dart';

import '../../_common_lib/widgets/route_widget.dart';
import '../widgets/app_search_widget.dart';
import '../../data/models/train_route.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ),
          ],
        ),
      ),
    );
  }
}
