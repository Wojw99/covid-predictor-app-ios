import 'models/region.dart';

class Singleton {
  static final Singleton _instance = Singleton._internal();
  static List<Region> predictionList = <Region>[];
  static List<Region> realList = <Region>[];
  static bool darkMode;

  factory Singleton() {
    return _instance;
  }

  Singleton._internal() {
    print('created');
  }
}
