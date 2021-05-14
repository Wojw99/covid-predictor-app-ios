import 'package:covid_prediction_app_ios/singleton.dart';
import 'package:covid_prediction_app_ios/view/pages/chart_page.dart';
import 'package:covid_prediction_app_ios/view/pages/map_page.dart';
import 'package:covid_prediction_app_ios/view/pages/table_page.dart';
import 'package:covid_prediction_app_ios/viewmodels/chart_vm.dart';
import 'package:covid_prediction_app_ios/viewmodels/map_vm.dart';
import 'package:covid_prediction_app_ios/viewmodels/table_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainViewModel extends ChangeNotifier {
  String _defaultRegion = 'Poland';
  String get defaultRegion => _defaultRegion;

  void navigateToTablePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<TableViewModel>(
          create: (context) => TableViewModel(),
          builder: (context, widget) => TablePage(),
        ),
      ),
    );
  }

  void navigateToMapPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<MapViewModel>(
          create: (context) => MapViewModel(),
          builder: (context, widget) => MapPage(),
        ),
      ),
    );
  }

  void navigateToChartPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<ChartViewModel>(
          create: (context) => ChartViewModel(),
          builder: (context, widget) => ChartPage(),
        ),
      ),
    );
  }

  int getPredictedCasesToday() {
    final poland = Singleton.predictionList
        .where((element) => element.region == defaultRegion)
        .toList()
        .first;
    return poland.outputs.first.cases;
  }

  int getRealCasesToday() {
    final poland = Singleton.realList
        .where((element) => element.region == defaultRegion)
        .toList()
        .first;
    return poland.outputs.first.cases;
  }
}
