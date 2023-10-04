import 'package:flutter/material.dart';

class AppTicketScreen extends StatefulWidget {
  const AppTicketScreen({super.key});

  @override
  State<AppTicketScreen> createState() => _AppTicketScreenState();
}

class _AppTicketScreenState extends State<AppTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("TicketScreen"),);
  }
}
