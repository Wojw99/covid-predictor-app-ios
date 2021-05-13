import 'models/region.dart';

class Singleton {
  static final Singleton _instance = Singleton._internal();
  static List<Region> predictionList = <Region>[];
  static List<Region> realList = <Region>[];

  factory Singleton() {
    return _instance;
  }

  Singleton._internal() {
    print('created');
  }
}
