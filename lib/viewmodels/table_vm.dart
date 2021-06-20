import 'package:covid_prediction_app_ios/models/region.dart';
import 'package:covid_prediction_app_ios/services/app_prefs.dart';
import 'package:covid_prediction_app_ios/utils/enums.dart';
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

  /// Index of currently visible cases (infections, recovered, deaths)
  TotalCases _selectedCases = TotalCases.Infected;
  TotalCases get selectedCases => _selectedCases;

  /// Available intervals
  List<TotalCases> get availableRadioButtons => _availableRadioButtons;
  List<TotalCases> _availableRadioButtons = [
    TotalCases.Infected,
    TotalCases.Recovered,
    TotalCases.Deaths,
  ];

  String formatChartInterval(TotalCases cases) {
    if (cases == TotalCases.Infected)
      return 'Infected';
    else if (cases == TotalCases.Recovered)
      return 'Recovered';
    else // if(cases == TotalCases.Deaths)
      return 'Deaths';
  }

  void changeTotalCases(TotalCases cases) {
    if (cases != null) {
      _selectedCases = cases;
      notifyListeners();
    }
  }

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
    final matchedOutputs = _predictionList[index]
        .outputs
        .where((element) => element.date == _selectedDate)
        .toList();

    if (matchedOutputs.isEmpty) return '...';

    if (selectedCases == TotalCases.Infected)
      return matchedOutputs.first.infected.toString();
    else if (selectedCases == TotalCases.Recovered)
      return matchedOutputs.first.recovered.toString();
    else // (selectedCases == TotalCases.Deaths)
      return matchedOutputs.first.deaths.toString();
  }

  String getRealCasesAt(int index) {
    final matchedOutputs = _realList[index]
        .outputs
        .where((element) => element.date == _selectedDate)
        .toList();

    if (matchedOutputs.isEmpty) return '...';

    if (selectedCases == TotalCases.Infected)
      return matchedOutputs.first.infected.toString();
    else if (selectedCases == TotalCases.Recovered)
      return matchedOutputs.first.recovered.toString();
    else // (selectedCases == TotalCases.Deaths)
      return matchedOutputs.first.deaths.toString();
  }
}
