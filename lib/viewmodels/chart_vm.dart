import 'package:covid_prediction_app_ios/models/output.dart';
import 'package:covid_prediction_app_ios/models/region.dart';
import 'package:covid_prediction_app_ios/view/pages/select_region_page.dart';
import 'package:covid_prediction_app_ios/viewmodels/select_region_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_prefs.dart';
import 'app_theme.dart';

class ChartViewModel extends ChangeNotifier {
  List<Region> _predictionList = AppPreferences.predictionList;
  List<Region> _realList = AppPreferences.realList;

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
    ChartInterval.threeMonths,
    ChartInterval.sixMonths,
    ChartInterval.oneYear,
  ];

  /// Current output date for value description
  String getCurrentOutputDate() {
    final list = getPredictedOutputs();
    if (list.isNotEmpty && currentIndex < list.length) {
      return formatDateTime(list[currentIndex].date);
    } else {
      return '...';
    }
  }

  /// Current predicted cases for value description
  String getCurrentPredicted() {
    final list = getPredictedOutputs();
    if (list.isNotEmpty && currentIndex < list.length) {
      return list[currentIndex].cases.toString();
    } else {
      return '...';
    }
  }

  /// Current real cases for value description
  String getCurrentReal() {
    final list = getRealOutputs();
    // There may be more predicted cases than real cases
    if (list.isNotEmpty && currentIndex < list.length) {
      return list[currentIndex].cases.toString();
    } else {
      return '...';
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
    else if (interval == ChartInterval.threeMonths)
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
    // Chart widget sends callback every time when GestureDetector detect
    // long press so incoming index can be same several times. We don't need
    // to rebuild page every time.
    if (index != _currentIndex && index != null) {
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

  /// Navigate to select region page and wait for user selection
  void navigateToSelectRegionPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SelectRegionViewModel()),
            ChangeNotifierProvider(create: (_) => AppTheme()),
          ],
          child: SelectRegionPage(),
        ),
      ),
    );
    if (result != null) {
      _currentRegion = result.toString();
      notifyListeners();
    }
  }
}

enum ChartInterval {
  oneWeek,
  oneMonth,
  threeMonths,
  sixMonths,
  oneYear,
}
