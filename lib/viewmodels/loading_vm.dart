import 'package:covid_prediction_app_ios/services/api_service.dart';
import 'package:covid_prediction_app_ios/services/app_prefs.dart';
import 'package:covid_prediction_app_ios/view/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  bool _error = false;
  bool get error => _error;

  bool _success = false;
  bool get success => _success;

  String _errorText = '';
  String get errorText => _errorText;

  /// Fetch API data (if not fetching yet) and fill in Singleton lists.
  /// Path parameters is used only for unit testing.
  /// 192.168.1.20:3000, 10.0.2.2:3000
  Future<void> fetchApiData() async {
    if (loading) return;

    final apiService = ApiService();
    _loading = true;

//<<<<<<< Updated upstream
    // AppPreferences.predictionList =
    //     await apiService.getPredictionsList(path: path);
    // AppPreferences.realList = await apiService.getRealList(path: path);
    // _success = true;

    try {
      print('loading data...');
      // Fill in singleton lists available for the whole application
      AppPreferences.predictionList = await apiService.getPredictionsListTest();
      AppPreferences.realList = await apiService.getRealListTest();
      _success = true;
      print('success!');
    } catch (e) {
      _error = true;
      _errorText = e.toString();
      print(e);
    }
//=======
    AppPreferences.predictionList =
        await apiService.getPredictionsListTest();
    AppPreferences.realList = await apiService.getRealListTest();
    _success = true;

    // try {
    //   print('loading data...');
    //   // Fill in singleton lists available for the whole application
    //   AppPreferences.predictionList = await apiService.getPredictionsList();
    //   AppPreferences.realList = await apiService.getPredictionsList();
    //   _success = true;
    //   print('success!');
    // } catch (e) {
    //   _error = true;
    //   _errorText = e.toString();
    //   print(e);
    // }
//>>>>>>> Stashed changes

    notifyListeners();
  }

  void navigateToMainPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(),
      ),
    );
  }
}
