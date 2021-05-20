import 'package:covid_prediction_app_ios/services/app_prefs.dart';
import 'package:covid_prediction_app_ios/models/region.dart';
import 'package:flutter/cupertino.dart';

class SelectRegionViewModel extends ChangeNotifier {
  List<Region> _predictionList = AppPreferences.predictionList;
  List<Region> _realList = AppPreferences.realList;

  List<String> _regionNamesInitial = [];
  List<String> _regionNames = [];
  List<String> get regionNames => _regionNames;

  SelectRegionViewModel() {
    _regionNamesInitial = _predictionList.map((e) => e.region).toList();
    _regionNames = _regionNamesInitial;
  }

  void filterRegions(String value) {
    _regionNames = _regionNamesInitial
        .where((element) => element.contains(value))
        .toList();
    notifyListeners();
  }

  void popWithRegionName(BuildContext context, String selectedRegion) {
    Navigator.pop(context, selectedRegion);
  }
}
