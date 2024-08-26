import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  get themeMode => _themeMode;
  _toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // final darkTheme = ThemeData(
  //   primarySwatch: Colors.grey,
  //   primaryColor: Colors.black,
  //   brightness: Brightness.dark,
  //   backgroundColor: Colors.black,
  //   //accentColor: Colors.white,
  //   //accentIconTheme: IconThemeData(color: Colors.black),
  //   dividerColor: Colors.black54,
  // );

  // final lightTheme = ThemeData(
  //   primarySwatch: Colors.grey,
  //   primaryColor: Colors.white,
  //   brightness: Brightness.light,
  //   backgroundColor: const Color(0xFFE5E5E5),
  //   //accentColor: Colors.black,
  //   //accentIconTheme: IconThemeData(color: Colors.white),
  //   dividerColor: Colors.white54,
  // );
}
