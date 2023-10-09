import 'package:flutter/material.dart';
import 'package:traveller_app/_common_lib/widgets/route_widget.dart';
import 'package:traveller_app/_common_lib/widgets/routes_scroll_widget.dart';
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FractionallySizedBox(
                widthFactor: 0.8,
                child: WebSearchWidget(),
              ),
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  child: RoutesScrollWidget(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
