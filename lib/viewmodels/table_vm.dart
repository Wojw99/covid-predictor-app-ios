import 'package:covid_prediction_app_ios/models/region.dart';
import 'package:covid_prediction_app_ios/services/app_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableViewModel extends ChangeNotifier {
  List<Region> _predictionList = AppPreferences.predictionList;
  List<Region> _realList = AppPreferences.realList;

  /// For DatePicker
  DateTime get firstDate => _predictionList.first.outputs.first.date;
  DateTime get lastDate => _predictionList.first.outputs.last.date;

  /// For button with date
  DateTime _selectedDate = DateTime.utc(2021, 6, 8);
  DateTime get selectedDate => _selectedDate;
  String get selectedDateString =>
      '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}';

  void changeDate(DateTime date) {
    if (date != null) {
      _selectedDate = date.toUtc();
      notifyListeners();
    }
  }

  /// There may be more predicted cases than real so the method returns
  /// length of prediction list
  int getListLength() {
    return _predictionList.length;
  }

  String getRegion(int index) {
    return _predictionList[index].region;
  }

  String getPredictedCasesAt(int index) {
    // There should be more predicted cases than real cases
    // but let's check it for sure
    final matchedOutputs = _predictionList[index]
        .outputs
        .where((element) => element.date == _selectedDate)
        .toList();

    if (matchedOutputs.isEmpty) return '...';

    return matchedOutputs.first.cases.toString();
  }

  String getRealCasesAt(int index) {
    // There may be more real cases than predicted
    final matchedOutputs = _realList[index]
        .outputs
        .where((element) => element.date == _selectedDate)
        .toList();

    if (matchedOutputs.isEmpty) return '...';

    return matchedOutputs.first.cases.toString();
  }
}
