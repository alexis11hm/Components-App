import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _darkTheme = false;
  bool _customTheme = false;
  ThemeData _currentTheme;

  ThemeChanger(int theme) {
    switch (theme) {
      case 1: //Light
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light().copyWith(accentColor: Colors.pink);
        break;
      case 2: //Dark
        _darkTheme = true;
        _customTheme = false;
        _currentTheme = ThemeData.dark().copyWith(accentColor: Colors.amber);
        break;
      case 1: //Custom
        _darkTheme = false;
        _customTheme = true;
        break;
      default:
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();
    }
  }

  bool get darkTheme => this._darkTheme;

  set darkTheme(bool value) {
    _customTheme = false;
    _darkTheme = value;
    if (value) {
      _currentTheme = ThemeData.dark().copyWith(accentColor: Colors.amber);
    } else {
      _currentTheme = ThemeData.light().copyWith(accentColor: Colors.pink);
    }
    notifyListeners();
  }

  bool get customTheme => this._customTheme;

  set customTheme(bool value) {
    _darkTheme = false;
    _customTheme = value;
    if (value) {
      _currentTheme = ThemeData.dark().copyWith(
          accentColor: Color(0xFF48A0EB),
          primaryColorLight: Colors.white,
          scaffoldBackgroundColor: Color(0xFF16202B),
          textTheme: TextTheme(body1: TextStyle(color: Colors.white)));
    } else {
      _currentTheme = ThemeData.light().copyWith(accentColor: Colors.pink);
    }
    notifyListeners();
  }

  ThemeData get currentTheme => this._currentTheme;
}
