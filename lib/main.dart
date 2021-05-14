import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/view/pages/loading_page.dart';
import 'package:covid_prediction_app_ios/viewmodels/loading_vm.dart';
import 'package:covid_prediction_app_ios/viewmodels/main_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SFPro',
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoadingViewModel()),
          ChangeNotifierProvider(create: (_) => MainViewModel()),
        ],
        child: LoadingPage(),
      ),
    );
  }
}
