import 'package:covid_prediction_app_ios/models/output.dart';
import 'package:covid_prediction_app_ios/models/region.dart';
import 'package:flutter/cupertino.dart';

import '../singleton.dart';

class ChartViewModel extends ChangeNotifier {
  List<Region> _predictionList = Singleton.predictionList;
  List<Region> _realList = Singleton.realList;

  String _currentRegion = 'Poland';
  String get currentRegion => _currentRegion;

  bool _showPredicted = true;
  bool get showPredicted => _showPredicted;

  /// Index of currently visible output
  int get currentIndex => _currentIndex;
  int _currentIndex = 0;

  /// Index of currently visible output
  ChartInterval get currentInterval => _currentInterval;
  ChartInterval _currentInterval = ChartInterval.oneMonth;

  /// Available intervals
  List<ChartInterval> get availableIntervals => _availableIntervals;
  List<ChartInterval> _availableIntervals = [
    ChartInterval.oneWeek,
    ChartInterval.oneMonth,
    ChartInterval.ThreeMonths,
    ChartInterval.sixMonths,
    ChartInterval.oneYear,
  ];

  /// Current output date for value description
  String getCurrentOutputDate() {
    final list = getPredictedOutputs();
    if (list.isNotEmpty) {
      return formatDateTime(list[currentIndex].date);
    } else {
      return '';
    }
  }

  /// Current predicted cases for value description
  String getCurrentPredicted() {
    final list = getPredictedOutputs();
    if (list.isNotEmpty) {
      return list[currentIndex].cases.toString();
    } else {
      return '';
    }
  }

  /// Current real cases for value description
  String getCurrentReal() {
    final list = getRealOutputs();
    if (list.isNotEmpty) {
      return list[currentIndex].cases.toString();
    } else {
      return '';
    }
  }

  String formatDateTime(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }

  String formatChartInterval(ChartInterval interval) {
    if (interval == ChartInterval.oneWeek)
      return '1w';
    else if (interval == ChartInterval.oneMonth)
      return '1m';
    else if (interval == ChartInterval.ThreeMonths)
      return '3m';
    else if (interval == ChartInterval.sixMonths)
      return '6m';
    else // if(interval == ChartInterval.oneWeek)
      return '1y';
  }

  /// Get list of predicted outputs
  List<Output> getPredictedOutputs() {
    final region = _predictionList
        .where((element) =>
            element.region.toLowerCase() == _currentRegion.toLowerCase())
        .toList();
    if (region.isNotEmpty) {
      return region.first.outputs;
    } else {
      return [];
    }
  }

  /// Get list of real outputs
  List<Output> getRealOutputs() {
    final region = _realList
        .where((element) =>
            element.region.toLowerCase() == _currentRegion.toLowerCase())
        .toList();
    if (region.isNotEmpty) {
      return region.first.outputs;
    } else {
      return [];
    }
  }

  /// Get list of outputs that will be visible on chart
  List<Output> getOutputs() {
    List<Output> outputs = [];

    if (showPredicted) {
      outputs = getPredictedOutputs();
    } else {
      outputs = getRealOutputs();
    }

    return outputs;
  }

  /// Get list of output cases that will be visible on chart
  List<double> getOutputCases() {
    return getOutputs().map((e) => e.cases.toDouble()).toList();
  }

  /// Determine if predicted or real data should be visible
  void changePredicted(bool showPredicted) {
    if (showPredicted != null) {
      _showPredicted = showPredicted;
      notifyListeners();
    }
  }

  /// Change region for which data will be visible
  void changeRegion(String region) {
    if (region != null) {
      _currentRegion = region;
      _currentIndex = 0;
      notifyListeners();
    }
  }

  /// Change day (output list index) for which data will be visible
  void changeIndex(int index, double value) {
    if (index != null) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  /// Change day interval for which data will be visible
  void changeInterval(ChartInterval interval) {
    if (interval != null) {
      _currentInterval = interval;
      notifyListeners();
    }
  }
}

enum ChartInterval {
  oneWeek,
  oneMonth,
  ThreeMonths,
  sixMonths,
  oneYear,
}
