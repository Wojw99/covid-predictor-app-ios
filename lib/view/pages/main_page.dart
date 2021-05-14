import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:covid_prediction_app_ios/utils/app_styles.dart';
import 'package:covid_prediction_app_ios/utils/constants.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_button.dart';
import 'package:covid_prediction_app_ios/viewmodels/main_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<MainViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.gray,
          child: Padding(
            padding: EdgeInsets.all(Constants.screenPadding),
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
                        style: AppStyles.header1,
                      ),
                      Text(
                        Strings.kMainHeader2,
                        style: AppStyles.header2,
                      ),
                    ],
                  ),
                ),

                /// - - - - - - COVID IMAGE - - - - - -
                Image(
                  image: AssetImage('assets/img/covid-2.png'),
                  height: 90.0,
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
                      ),
                      IosButton(
                        onPressed: () {
                          _viewModel.navigateToChartPage(context);
                        },
                        text: Strings.chart,
                        iconData: Icons.bar_chart,
                      ),
                      IosButton(
                        onPressed: () {
                          _viewModel.navigateToMapPage(context);
                        },
                        text: Strings.worldMap,
                        iconData: Icons.map,
                      ),
                    ],
                  ),
                ),

                /// - - - - - - CASES TODAY - - - - - -
                Container(
                  child: Column(
                    children: [
                      /// - - - - - HEAD - - - - -
                      Text(
                        '${Strings.casesToday} (${_viewModel.defaultRegion})',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// - - - - - REAL - - - - -
                          Column(
                            children: [
                              Text(
                                _viewModel.getPredictedCasesToday().toString(),
                                style: casesStyle,
                              ),
                              Text(
                                Strings.real,
                                style: AppStyles.textLight
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
                              Text(
                                _viewModel.getRealCasesToday().toString(),
                                style: casesStyle,
                              ),
                              Text(
                                Strings.predicted,
                                style: AppStyles.textLight
                                    .copyWith(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const casesStyle = TextStyle(
  letterSpacing: -1.0,
  color: AppColors.textDark,
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);
