import '../models/region.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  static List<Region> predictionList = <Region>[];
  static List<Region> realList = <Region>[];
  static bool darkMode;

  factory AppPreferences() {
    return _instance;
  }

  AppPreferences._internal() {
    print('created');
  }
}
