import 'package:flutter/material.dart';
import 'package:traveller_app/_common_lib/widgets/routes_scroll_widget.dart';

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
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: RoutesScrollWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
