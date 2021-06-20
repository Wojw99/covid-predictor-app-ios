import 'package:covid_prediction_app_ios/services/app_prefs.dart';
import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:covid_prediction_app_ios/view/pages/chart_page.dart';
import 'package:covid_prediction_app_ios/view/pages/map_page.dart';
import 'package:covid_prediction_app_ios/view/pages/table_page.dart';
import 'package:covid_prediction_app_ios/viewmodels/chart_vm.dart';
import 'package:covid_prediction_app_ios/viewmodels/map_vm.dart';
import 'package:covid_prediction_app_ios/viewmodels/table_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';

class MainViewModel extends ChangeNotifier {
  String _defaultRegion = 'Poland';
  String get defaultRegion => _defaultRegion;

  void navigateToTablePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => TableViewModel()),
            ChangeNotifierProvider(create: (_) => AppTheme()),
          ],
          child: TablePage(),
        ),
      ),
    );
  }

  void navigateToMapPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MapViewModel()),
            ChangeNotifierProvider(create: (_) => AppTheme()),
          ],
          child: MapPage(),
        ),
      ),
    );
  }

  void navigateToChartPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ChartViewModel()),
            ChangeNotifierProvider(create: (_) => AppTheme()),
          ],
          child: ChartPage(),
        ),
      ),
    );
  }

  int getPredictedCasesToday() {
    final poland = AppPreferences.predictionList
        .where((element) => element.region == defaultRegion)
        .toList()
        .first;
    return poland.outputs.last.infected;
  }

  int getRealCasesToday() {
    final poland = AppPreferences.realList
        .where((element) => element.region == defaultRegion)
        .toList()
        .first;
    return poland.outputs.last.infected;
  }
}
