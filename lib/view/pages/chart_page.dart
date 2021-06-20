import 'package:covid_prediction_app_ios/utils/constants.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/view/view_helper.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_back_button.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_button.dart';
import 'package:covid_prediction_app_ios/view/widgets/w_chart.dart';
import 'package:covid_prediction_app_ios/viewmodels/app_theme.dart';
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
  AppTheme _appTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<ChartViewModel>(context);
    _appTheme = Provider.of<AppTheme>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _appTheme.colors.gray,
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Constants.screenPadding,
              8.0,
              Constants.screenPadding,
              Constants.screenPadding / 3,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// * * * * * TOP BAR * * * * *
                  buildTopBar(),

                  SizedBox(height: Constants.screenPadding),

                  /// * * * * * CHART SPACE * * * * *
                  Container(
                    decoration: _appTheme.defaultBoxDecoration,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.screenPadding,
                        vertical: 10.0,
                      ),
                      child: buildChartSpace(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChartSpace() {
    return Column(
      children: [
        /// * * * * * VALUE DESCRIPTION * * * * *
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// * * * PREDICTED * * *
            Column(
              children: [
                Text(
                  ViewHelper.formatNumber(
                    _viewModel.getCurrentPredicted(),
                  ),
                  style: _appTheme.textChartValue,
                ),
                Text(
                  Strings.predicted,
                  style: _appTheme.textLight.copyWith(fontSize: 12.0),
                ),
              ],
            ),

            /// * * * DATE * * *
            Text(
              _viewModel.getCurrentOutputDate(),
              style: _appTheme.textChartData,
            ),

            /// * * * REAL * * *
            Column(
              children: [
                Text(
                  ViewHelper.formatNumber(
                    _viewModel.getCurrentReal(),
                  ),
                  style: _appTheme.textChartValue,
                ),
                Text(
                  Strings.real,
                  style: _appTheme.textLight.copyWith(fontSize: 12.0),
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
          width:
              MediaQuery.of(context).size.width - Constants.screenPadding * 4,
          height: MediaQuery.of(context).size.height / 1.7,
          values: _viewModel.getOutputCases(),
          onPressed: _viewModel.changeIndex,
          barColor: _appTheme.colors.accentLight,
          selectedBarColor: _appTheme.colors.accent,
          backgroundColor: _appTheme.colors.light,
        ),

        SizedBox(
          height: Constants.screenPadding,
        ),

        /// * * * * * CHART SETTINGS * * * * *
        Container(
          decoration: _appTheme.defaultBoxDecoration.copyWith(
            color: _appTheme.colors.gray,
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
                          disabled: _viewModel.currentInterval != interval,
                          disabledColor: _appTheme.colors.gray,
                          text: _viewModel.formatChartInterval(interval),
                          backgroundColor: _appTheme.colors.accent,
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
                disabled: !_viewModel.showPredicted,
                disabledColor: _appTheme.colors.gray,
                text: Strings.predicted,
                backgroundColor: _appTheme.colors.accent,
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
                disabled: _viewModel.showPredicted,
                disabledColor: _appTheme.colors.gray,
                text: Strings.real,
                backgroundColor: _appTheme.colors.accent,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTopBar() {
    return Row(
      children: [
        /// * * * * * BACK BUTTON * * * * *
        IosBackButton(
          onPressed: () => Navigator.of(context).pop(),
          iconColor: _appTheme.colors.accent,
        ),

        /// * * * * * BUTTON REGION * * * * *
        Expanded(
          child: IosButton(
            iconData: Icons.search,
            onPressed: () {
              _viewModel.navigateToSelectRegionPage(context);
            },
            text: _viewModel.currentRegion,
            backgroundColor: _appTheme.colors.accent,
          ),
        ),
      ],
    );
  }
}
