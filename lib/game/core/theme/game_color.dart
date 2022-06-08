import 'package:flutter/material.dart';

class GameColor {
  static const MaterialColor brown = MaterialColor(
    _brownPrimaryValue,
    <int, Color>{
      100: Color(0xFFFFBA88),
      200: Color(0xFFE2A445),
      300: Color(0xFFBE7F50),
      400: Color(0xFF643B1D),
      500: Color(_brownPrimaryValue),
      600: Color(0xFF2A211B),
      700: Color(0xFF14110E),
    },
  );
  static const int _brownPrimaryValue = 0xFF48301E;

  static const MaterialColor orange = MaterialColor(
    _orangePrimaryValue,
    <int, Color>{
      100: Color(0xFFFFB9B9),
      200: Color(0xFFEB5A2B),
      300: Color(0xFFCC9393),
      400: Color(0xFF6B2B2B),
      500: Color(_brownPrimaryValue),
      600: Color(0xFF3E1C1C),
      700: Color(0xFF2E1616),
    },
  );
  static const int _orangePrimaryValue = 0xFF582929;

  static const MaterialColor turquoise = MaterialColor(
    _turquoisePrimaryValue,
    <int, Color>{
      100: Color(0xFF40E0D0),
      200: Color(0xFF40E0D0),
      300: Color(0xFF40E0D0),
      400: Color(0xFF40E0D0),
      500: Color(_turquoisePrimaryValue),
      600: Color(0xFF40E0D0),
      700: Color(0xFF40E0D0),
    },
  );
  static const int _turquoisePrimaryValue = 0xFF40E0D0;
}
