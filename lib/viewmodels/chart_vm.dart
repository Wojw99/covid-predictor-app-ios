import 'package:covid_prediction_app_ios/models/region.dart';
import 'package:flutter/cupertino.dart';

import '../singleton.dart';

class ChartViewModel extends ChangeNotifier {
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
}
