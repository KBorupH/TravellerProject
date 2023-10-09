import 'package:flutter/material.dart';

class AppPage with ChangeNotifier {
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
  login
}

final AppPage appPageNotifier = AppPage();
