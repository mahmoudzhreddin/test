import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Map<int, Color> primarySwatch = {
    50: Color(0xFFE4ECF4),
    100: Color(0xFFBBCEE3),
    200: Color(0xFF8DAED0),
    300: Color(0xFF5F8EBD),
    400: Color(0xFF3D75AF),
    500: Color(0xFF1b5da1),
    600: Color(0xFF185599),
    700: Color(0xFF144B8F),
    800: Color(0xFF104185),
    900: Color(0xFF083074),
  };

  static const primaryColor = MaterialColor(0xFF1b5da1, primarySwatch);

  static const Map<int, Color> secondaryMaterial = {
    1: Color(0xFFFCF4F1),
    5: Color(0xFFFDF4EC),
    10: Color(0xFFFCF2E6),
    25: Color(0xFFFCEAC5),
    50: Color(0xFFFCD38A),
    100: Color(0xFFFCC954),
    200: Color(0xFFFFC947),
    300: Color(0xFFFFC947),
    400: Color(0xFFFFC947),
    500: Color(0xFFFFC947),
    600: Color(0xFFE0A818),
    700: Color(0xFFC48E0A),
    800: Color(0xFF9A6C00),
    900: Color(0xFF503904),
  };

  static const secondaryColor = MaterialColor(0xFFFFC947, secondaryMaterial);

  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;
  static Color grey = Colors.grey.shade600;

  static Color getRandomColor() {
    return Color.fromRGBO(Random().nextInt(300), Random().nextInt(300),
        Random().nextInt(300), 0.5);
  }
}
