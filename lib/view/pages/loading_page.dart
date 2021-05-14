import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:covid_prediction_app_ios/utils/app_styles.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/viewmodels/loading_vm.dart';
import 'package:covid_prediction_app_ios/viewmodels/main_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'main_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  LoadingViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<LoadingViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    // Fetching API data succeed
    if (_viewModel.success) {
      return MainPage();
    }

    // Fetching API data did not success
    if (_viewModel.error) {
      return Scaffold(
        body: Container(
          color: AppColors.light,
          child: Center(
            child: Text(
              _viewModel.errorText,
              style: AppStyles.textDark,
            ),
          ),
        ),
      );
    }

    // Start fetching API data
    _viewModel.fetchApiData();
    return Scaffold(
      body: Container(
        color: AppColors.light,
        child: Center(
          child: SpinKitDoubleBounce(
            color: AppColors.accentRed,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
