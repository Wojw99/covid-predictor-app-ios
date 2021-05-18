import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:covid_prediction_app_ios/utils/app_styles.dart';
import 'package:covid_prediction_app_ios/utils/constants.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_back_button.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_button.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_textfield.dart';
import 'package:covid_prediction_app_ios/view/widgets/w_chart.dart';
import 'package:covid_prediction_app_ios/view/widgets/w_data.dart';
import 'package:covid_prediction_app_ios/viewmodels/chart_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  ChartViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<ChartViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// * * * * * APP BAR * * * * *
      appBar: AppBar(
        title: Text(
          Strings.chart,
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.gray,
        leading: IosBackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.gray,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Constants.screenPadding,
              0,
              Constants.screenPadding,
              Constants.screenPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// * * * * * TEXT FIELD REGION * * * * *
                IosTextField(
                  iconData: Icons.search,
                  hintText: Strings.search,
                  initialValue: _viewModel.currentRegion,
                  onChanged: (value) {
                    _viewModel.changeRegion(value);
                  },
                ),

                SizedBox(height: Constants.screenPadding),

                Container(
                  decoration: AppStyles.defaultBoxDecoration,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.screenPadding,
                      vertical: 10.0,
                    ),
                    child: Column(
                      children: [
                        /// * * * * * VALUE DESCRIPTION * * * * *
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// * * * PREDICTED * * *
                            Column(
                              children: [
                                Text(
                                  _viewModel.getCurrentPredicted(),
                                  style: AppStyles.textChartValue,
                                ),
                                Text(
                                  Strings.predicted,
                                  style: AppStyles.textLight
                                      .copyWith(fontSize: 12.0),
                                ),
                              ],
                            ),

                            /// * * * DATE * * *
                            Text(
                              _viewModel.getCurrentOutputDate(),
                              style: AppStyles.textChartData,
                            ),

                            /// * * * REAL * * *
                            Column(
                              children: [
                                Text(
                                  _viewModel.getCurrentReal(),
                                  style: AppStyles.textChartValue,
                                ),
                                Text(
                                  Strings.real,
                                  style: AppStyles.textLight
                                      .copyWith(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        /// * * * * * CHART * * * * *
                        WChart(
                          width: MediaQuery.of(context).size.width -
                              Constants.screenPadding * 4,
                          height: MediaQuery.of(context).size.height / 2,
                          values: _viewModel.getOutputCases(),
                          onPressed: _viewModel.changeIndex,
                          barColor: AppColors.accentLight,
                          selectedBarColor: AppColors.accent,
                        ),

                        SizedBox(
                          height: Constants.screenPadding,
                        ),

                        /// * * * * * CHART SETTINGS * * * * *
                        Container(
                          decoration: AppStyles.defaultBoxDecoration.copyWith(
                            color: AppColors.gray,
                          ),
                          child: Row(
                              children: _viewModel.availableIntervals
                                  .map(
                                    (interval) => Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: IosButton(
                                          onPressed: () {
                                            _viewModel.changeInterval(interval);
                                          },
                                          disabledColor:
                                              _viewModel.currentInterval !=
                                                  interval,
                                          text: _viewModel
                                              .formatChartInterval(interval),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),

                        SizedBox(
                          height: Constants.screenPadding / 2,
                        ),

                        Row(
                          children: [
                            /// * * * PREDICTED * * *
                            Expanded(
                              child: IosButton(
                                onPressed: () {
                                  _viewModel.changePredicted(true);
                                },
                                disabledColor: !_viewModel.showPredicted,
                                text: Strings.predicted,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),

                            /// * * * REAL * * *
                            Expanded(
                              child: IosButton(
                                onPressed: () {
                                  _viewModel.changePredicted(false);
                                },
                                disabledColor: _viewModel.showPredicted,
                                text: Strings.real,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
