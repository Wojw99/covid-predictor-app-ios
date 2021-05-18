import 'package:covid_prediction_app_ios/models/region.dart';
import 'package:flutter/cupertino.dart';

import '../singleton.dart';

class MapViewModel extends ChangeNotifier {
  List<Region> _predictionList = Singleton.predictionList;
  List<Region> _realList = Singleton.realList;

  List<Region> get predictionList => _predictionList;
  List<Region> get realList => _realList;

  bool _showPredicted = true;
  bool get showPredicted => _showPredicted;

  /// For button with date
  DateTime _selectedDate = DateTime.utc(2021, 04, 23);
  DateTime get selectedDate => _selectedDate;
  String get selectedDateString =>
      '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}';

  /// For DatePicker.
  DateTime getFirstDate() {
    // It's important to check if showPredicted is true because
    // prediction list has bigger size.
    if (_showPredicted) return _predictionList.first.outputs.first.date;
    return _realList.first.outputs.first.date;
  }

  /// For DatePicker.
  DateTime getLastDate() {
    // It's important to check if showPredicted is true because
    // prediction list has bigger size.
    if (_showPredicted) return _predictionList.first.outputs.last.date;
    return _realList.first.outputs.last.date;
  }

  /// Get region names for map
  String getPrimaryValueMapper(int index) {
    if (_showPredicted) {
      return predictionList[index].region;
    }
    return realList[index].region;
  }

  /// Get predicted/real values that will be mapped into map bubble size
  double getBubbleSizeMapper(int index) {
    var list = [];

    if (_showPredicted) {
      list = _predictionList;
    } else {
      list = _realList;
    }

    double cases = list[index]
        .outputs
        .where((element) => element.date == selectedDate)
        .toList()
        .first
        .cases
        .toDouble();
    return cases;
  }

  /// Get length of predictions/real list for map
  int getDataCount() {
    if (_showPredicted) {
      return predictionList.length;
    }
    return realList.length;
  }

  /// Change date for with data will be visible
  void changeDate(DateTime date) {
    if (date != null) {
      _selectedDate = date.toUtc();
      notifyListeners();
    }
  }

  /// Determine if predicted or real data should be visible
  void changePredicted(bool showPredicted) {
    if (showPredicted != null) {
      _showPredicted = showPredicted;
      if (_selectedDate.microsecondsSinceEpoch >
          getLastDate().microsecondsSinceEpoch) {
        _selectedDate = getLastDate();
      }
      notifyListeners();
    }
  }
}
