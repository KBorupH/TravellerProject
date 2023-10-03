import 'package:flutter/material.dart';

class AppLoginScreen extends StatefulWidget {
  const AppLoginScreen({super.key});

  @override
  State<AppLoginScreen> createState() => _AppLoginScreenState();
}

class _AppLoginScreenState extends State<AppLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("LoginScreen"),);
  }
}
