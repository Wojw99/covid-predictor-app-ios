//import 'package:covid_prediction_app_ios/services/app_prefs.dart';
import 'package:covid_prediction_app_ios/services/storage_manager.dart';
import 'file:///D:/Dev/GitHub/covid-predictor-app-ios/lib/services/app_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  ThemeColors lightThemeColors = ThemeColors(
    light: Colors.white,
    gray: Color(0xfff4f4f4),
    accent: Color(0xff0A64EC),
    accentLight: Color(0xffE5EDFA),
    accentRed: Color(0xffed3c43),
    textLight: Color(0xff7A7A7A),
    textDark: Color(0xff000000),

    //textGreen_DarkGrey: Colors.lightGreen ,

  );

  ThemeColors darkThemeColors = ThemeColors(
    light: Color(0xff292929),
    gray: Color(0xff1E1E1E),
    accent: Color(0xffec7f0a),
    accentLight: Color(0xff494949),
    accentRed: Color(0xffed3c43),
    textLight: Color(0xb3ffffff),
    textDark: Color(0xffffffff),

    //textGreen_DarkGrey: Color(0xff494949),

  );

  // ThemeColors _colors;

  bool _darkModeOn = false;
  bool get darkModeOn => _darkModeOn;

  ThemeColors get colors => darkModeOn ? darkThemeColors : lightThemeColors;

  String _storageKey = 'dark_mode';

  AppTheme() {
    if (AppPreferences.darkMode == null) {
      // Dark mode did not read yet
      StorageManager.readBoolData(_storageKey).then((value) {
        if (value == null) {
          // When the application is used first time and storage
          // did not configured
          _darkModeOn = false;
          StorageManager.saveData(_storageKey, _darkModeOn);
        } else {
          _darkModeOn = value;
        }
        AppPreferences.darkMode = _darkModeOn;
        notifyListeners();
      });
    } else {
      // Dark mode was read while using the app
      _darkModeOn = AppPreferences.darkMode;
    }
  }

  void toggleDarkMode() {
    _darkModeOn = !_darkModeOn;
    AppPreferences.darkMode = _darkModeOn;
    notifyListeners();
    StorageManager.saveData(_storageKey, _darkModeOn);
  }

  TextStyle get casesStyle => TextStyle(
        letterSpacing: -1.0,
        color: colors.textDark,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      );

  BoxDecoration get defaultBoxDecoration => BoxDecoration(
        color: colors.light,
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      );

  TextStyle get textLight => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: colors.textLight,
      );

  TextStyle get textDark => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: colors.textDark,
      );

  TextStyle get textButton => TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
        color: colors.light,
      );

  TextStyle get textChartValue => TextStyle(
        fontSize: 23.0,
        fontWeight: FontWeight.w600,
        color: colors.textDark,
      );

  TextStyle get textChartData => TextStyle(
        fontSize: 19.0,
        fontWeight: FontWeight.w600,
        color: colors.textLight,
      );

  TextStyle get header1 => TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.bold,
        color: colors.textDark,
      );

  TextStyle get header2 => TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.normal,
        color: colors.textLight,
      );
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
