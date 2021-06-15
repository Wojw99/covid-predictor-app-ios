import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static final AppColors _instance = AppColors._internal();

  factory AppColors() {
    return _instance;
  }

  AppColors._internal() {
    print('created');
  }

  static bool _darkModeOn = false;

  static void toggleDarkMode() {
    _darkModeOn = !_darkModeOn;
  }

  static ThemeColors _lightThemeColors = ThemeColors(
    light: Colors.white,
    gray: Color(0xfff4f4f4),
    accent: Color(0xff0A64EC),
    accentLight: Color(0xffE5EDFA),
    accentRed: Color(0xffed3c43),
    textLight: Color(0xff7A7A7A),
    textDark: Color(0xff000000),
  );

  static ThemeColors _darkThemeColors = ThemeColors(
    light: Color(0xff292929),
    gray: Color(0xff0D0D0D),
    accent: Color(0xffec860a),
    accentLight: Color(0xff575757),
    accentRed: Color(0xffed3c43),
    textLight: Color(0xb3ffffff),
    textDark: Color(0xffffffff),
  );

  static Color light =
      _darkModeOn ? _darkThemeColors.light : _lightThemeColors.light;
  static Color gray =
      _darkModeOn ? _darkThemeColors.gray : _lightThemeColors.gray;
  static Color accent =
      _darkModeOn ? _darkThemeColors.accent : _lightThemeColors.accent;
  static Color accentLight = _darkModeOn
      ? _darkThemeColors.accentLight
      : _lightThemeColors.accentLight;
  static Color accentRed =
      _darkModeOn ? _darkThemeColors.accentRed : _lightThemeColors.accentRed;
  static Color textLight =
      _darkModeOn ? _darkThemeColors.textLight : _lightThemeColors.textLight;
  static Color textDark =
      _darkModeOn ? _darkThemeColors.textDark : _lightThemeColors.textDark;
}

class ThemeColors {
  final Color light;
  final Color gray;
  final Color accent;
  final Color accentLight;
  final Color accentRed;

  final Color textLight;
  final Color textDark;

  ThemeColors({
    this.light,
    this.gray,
    this.accent,
    this.accentLight,
    this.accentRed,
    this.textLight,
    this.textDark,
  });
}
