import 'package:covid_prediction_app_ios/models/region.dart';
import 'package:covid_prediction_app_ios/singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableViewModel extends ChangeNotifier {
  List<Region> _predictionList = Singleton.predictionList;
  List<Region> _realList = Singleton.realList;

  /// For DatePicker
  DateTime get firstDate => _predictionList.first.outputs.first.date;
  DateTime get lastDate => _predictionList.first.outputs.last.date;

  /// For button with date
  DateTime _selectedDate = DateTime.utc(2021, 04, 24);
  DateTime get selectedDate => _selectedDate;
  String get selectedDateString =>
      '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}';

  void changeDate(DateTime date) {
    if (date != null) {
      _selectedDate = date.toUtc();
      notifyListeners();
    }
  }

  int getListsLength() {
    if (_predictionList.length != _realList.length)
      throw Exception('Lists have different sizes!');
    return _predictionList.length;
  }

  String getRegion(int index) {
    return _predictionList[index].region;
  }

  String getPredictedCasesAt(int index) {
    return _predictionList[index]
        .outputs
        .where((element) => element.date == _selectedDate)
        .toList()
        .first
        .cases
        .toString();
  }

  String getRealCasesAt(int index) {
    return _realList[index]
        .outputs
        .where((element) => element.date == _selectedDate)
        .toList()
        .first
        .cases
        .toString();
  }
}
