import 'package:flutter/material.dart';

class AppDrawerNotifier with ChangeNotifier {
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  void changeLoginState(bool loginState) {
    _loggedIn = loginState;
    notifyListeners();
  }
}

final AppDrawerNotifier appDrawerNotifier = AppDrawerNotifier();