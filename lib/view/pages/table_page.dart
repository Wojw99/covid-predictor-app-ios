import 'package:covid_prediction_app_ios/utils/constants.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/view/view_helper.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_back_button.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_button.dart';
import 'package:covid_prediction_app_ios/viewmodels/app_theme.dart';
import 'package:covid_prediction_app_ios/viewmodels/table_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  TableViewModel _viewModel;
  AppTheme _appTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<TableViewModel>(context);
    _appTheme = Provider.of<AppTheme>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _appTheme.colors.gray,

      /// * * * * * BODY * * * * *
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Constants.screenPadding,
              8.0,
              Constants.screenPadding,
              Constants.screenPadding / 3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// * * * * * TOP BAR * * * * *
                buildTopBar(),

                SizedBox(height: Constants.screenPadding / 2),

                /// * * * * * RADIO BUTTONS * * * * *
                Row(
                    children: _viewModel.availableRadioButtons
                        .map(
                          (cases) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: IosButton(
                                key: Key(
                                  _viewModel.formatTotalCasesEnum(cases),
                                ),
                                onPressed: () {
                                  _viewModel.changeTotalCases(cases);
                                },
                                disabled: _viewModel.selectedCases != cases,
                                disabledColor: _appTheme.colors.gray,
                                text: _viewModel.formatTotalCasesEnum(cases),
                                backgroundColor: _appTheme.colors.accent,
                              ),
                            ),
                          ),
                        )
                        .toList()),

                SizedBox(height: Constants.screenPadding / 2),

                /// * * * * * TABLE DESCRIPTION * * * * *
                Container(
                  decoration: BoxDecoration(
                    color: _appTheme.colors.accentLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Constants.radiusDefault),
                      topRight: Radius.circular(Constants.radiusDefault),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            Strings.region,
                            style: _appTheme.textDark,
                          ),
                          flex: 20,
                        ),
                        Expanded(
                          child: Text(
                            Strings.predicted,
                            style: _appTheme.textDark
                                .copyWith(color: _appTheme.colors.accent),
                          ),
                          flex: 20,
                        ),
                        Expanded(
                          child: Text(
                            Strings.real,
                            style: _appTheme.textDark,
                          ),
                          flex: 12,
                        ),
                      ],
                    ),
                  ),
                ),

                /// * * * * * TABLE CONTENT * * * * *
                Expanded(
                  child: Container(
                    color: _appTheme.colors.light,
                    child: ListView.builder(
                      itemCount: _viewModel.getListLength(),
                      itemBuilder: (BuildContext context, int index) {
                        return buildTableRow(index);
                      },
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

  Widget buildTopBar() {
    return Row(
      children: [
        /// * * * * * BACK BUTTON * * * * *
        IosBackButton(
          onPressed: () => Navigator.of(context).pop(),
          iconColor: _appTheme.colors.accent,
        ),

        /// * * * * * BUTTON DATE * * * * *
        Expanded(
          child: IosButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: _viewModel.selectedDate,
                firstDate: _viewModel.firstDate,
                lastDate: _viewModel.lastDate,
              ).then((value) => _viewModel.changeDate(value));
            },
            text: _viewModel.selectedDateString,
            iconData: Icons.calendar_today,
            backgroundColor: _appTheme.colors.accent,
          ),
        ),
      ],
    );
  }

  Widget buildTableRow(int index) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _viewModel.getRegion(index),
                    style: _appTheme.textDark,
                  ),
                  flex: 20,
                ),
                Expanded(
                  child: Text(
                    ViewHelper.formatNumber(
                      _viewModel.getPredictedCasesAt(index),
                    ),
                    style: _appTheme.textDark
                        .copyWith(color: _appTheme.colors.accent),
                  ),
                  flex: 20,
                ),
                Expanded(
                  child: Text(
                    ViewHelper.formatNumber(
                      _viewModel.getRealCasesAt(index),
                    ),
                    style: _appTheme.textDark,
                  ),
                  flex: 12,
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: _appTheme.colors.gray,
          ),
        ],
      ),
    );
  }
}
