import 'package:covid_prediction_app_ios/services/api_service.dart';
import 'package:covid_prediction_app_ios/singleton.dart';
import 'package:covid_prediction_app_ios/view/pages/main_page.dart';
import 'package:covid_prediction_app_ios/viewmodels/main_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  bool _error = false;
  bool get error => _error;

  bool _success = false;
  bool get success => _success;

  String _errorText = '';
  String get errorText => _errorText;

  // fetch API data (if not fetching yet) and fill in Singleton lists
  void fetchApiData() async {
    if (loading) return;

    final apiService = ApiService();
    _loading = true;

    try {
      print('loading data...');
      // Fill in singleton lists available for the whole application
      Singleton.predictionList = await apiService.getPredictionsListTest();
      Singleton.realList = await apiService.getRealListTest();
      _success = true;
      print('success!');
    } catch (e) {
      _error = true;
      _errorText = e.toString();
    }

    notifyListeners();
  }

  void navigateToMainPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<MainViewModel>(
          create: (context) => MainViewModel(),
          builder: (context, widget) => MainPage(),
        ),
      ),
    );
  }
}