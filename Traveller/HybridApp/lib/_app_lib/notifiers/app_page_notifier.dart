import 'package:flutter/material.dart';

class AppPageNotifier with ChangeNotifier {
  AppPages _currentPage = AppPages.home;
  AppPages get currentPage => _currentPage;

  void changePage(AppPages newPage) {
    _currentPage = newPage;
    notifyListeners();
  }
}

enum AppPages {
  home,
  ticket,
  login,
  register
}

final AppPageNotifier appPageNotifier = AppPageNotifier();
