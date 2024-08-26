import 'package:izesan/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

class ThemeModel extends BaseViewModel {
  //final ThemeData themeManager = locator<ThemeData>();
  bool isDark = true;
  final currentTheme = ThemeMode.light;

  toggleTheme(bool isDark) {
    isDark ? ThemeData.dark : ThemeMode.light;
    notifyListeners();
  }
}
