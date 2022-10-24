import 'package:flutter/material.dart';

class AppColors {

  static const MaterialColor primaryColor = MaterialColor(
      _primaryColorValue, <int, Color>{
    50: Color(0xFFEBEEFE),
    100: Color(0xFFCDD4FC),
    200: Color(0xFFACB8FA),
    300: Color(0xFF8A9CF8),
    400: Color(0xFF7186F7),
    500: Color(_primaryColorValue),
    600: Color(0xFF5069F4),
    700: Color(0xFF475EF2),
    800: Color(0xFF3D54F0),
    900: Color(0xFF2D42EE),
  });
  static const int _primaryColorValue = 0xFF5871F5;

}