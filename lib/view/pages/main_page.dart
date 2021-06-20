import 'package:covid_prediction_app_ios/utils/constants.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/view/view_helper.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_button.dart';
import 'package:covid_prediction_app_ios/viewmodels/app_theme.dart';
import 'package:covid_prediction_app_ios/viewmodels/main_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'info_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainViewModel _viewModel;
  AppTheme _appTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<MainViewModel>(context);
    _appTheme = Provider.of<AppTheme>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appTheme.colors.gray,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.visibility),
            color: _appTheme.colors.accent,
            onPressed: _appTheme.toggleDarkMode,
          ),
          IconButton(
            icon: Icon(Icons.info),
            color: _appTheme.colors.accent,
            onPressed: () {
              _viewModel.navigateToInfoPage(context);
            },
          ),
        ],
      ),
      body: Container(
        color: _appTheme.colors.gray,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            Constants.screenPadding,
            0,
            Constants.screenPadding,
            Constants.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// - - - - - - HEADERS - - - - - -
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.kMainHeader,
                      style: _appTheme.header1,
                    ),
                    Text(
                      Strings.kMainHeader2,
                      style: _appTheme.header2,
                    ),
                  ],
                ),
              ),

              /// - - - - - - COVID IMAGE - - - - - -
              Flexible(
                child: Image(
                  image: AssetImage('assets/img/covid-2.png'),
                  height: 90.0,
                ),
              ),

              /// - - - - - - BUTTONS - - - - - -
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IosButton(
                      onPressed: () {
                        _viewModel.navigateToTablePage(context);
                      },
                      text: Strings.table,
                      iconData: Icons.table_rows_rounded,
                      backgroundColor: _appTheme.colors.accent,
                    ),
                    IosButton(
                      onPressed: () {
                        _viewModel.navigateToChartPage(context);
                      },
                      text: Strings.chart,
                      iconData: Icons.bar_chart,
                      backgroundColor: _appTheme.colors.accent,
                    ),
                    IosButton(
                      onPressed: () {
                        _viewModel.navigateToMapPage(context);
                      },
                      text: Strings.worldMap,
                      iconData: Icons.map,
                      backgroundColor: _appTheme.colors.accent,
                    ),
                  ],
                ),
              ),

              /// - - - - - - CASES TODAY - - - - - -
              Visibility(
                visible:
                    MediaQuery.of(context).orientation == Orientation.portrait,
                child: Container(
                  child: Column(
                    children: [
                      /// - - - - - HEAD - - - - -
                      Text(
                        '${Strings.casesToday} (${_viewModel.defaultRegion})',
                        style: TextStyle(
                          color: _appTheme.colors.textLight,
                          fontSize: 18.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// - - - - - REAL - - - - -
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  ViewHelper.formatNumber(
                                    _viewModel
                                        .getPredictedCasesToday()
                                        .toString(),
                                  ),
                                  style: _appTheme.casesStyle,
                                ),
                              ),
                              Text(
                                Strings.real,
                                style: _appTheme.textLight
                                    .copyWith(fontSize: 16.0),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 24.0,
                          ),

                          /// - - - - - PREDICTED - - - - -
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  ViewHelper.formatNumber(
                                    _viewModel.getRealCasesToday().toString(),
                                  ),
                                  style: _appTheme.casesStyle,
                                ),
                              ),
                              Text(
                                Strings.predicted,
                                style: _appTheme.textLight
                                    .copyWith(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
