import 'package:covid_prediction_app_ios/utils/constants.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
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
      /// * * * * * APP BAR * * * * *
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _appTheme.colors.gray,
        title: Text(
          Strings.table,
          style: TextStyle(
            color: _appTheme.colors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IosBackButton(onPressed: () => Navigator.of(context).pop()),
      ),

      /// * * * * * BODY * * * * *
      body: Container(
        color: _appTheme.colors.gray,
        child: Padding(
          padding: EdgeInsets.all(Constants.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// * * * * * BUTTON DATE * * * * *
              IosButton(
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
              ),

              SizedBox(height: Constants.screenPadding),

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
                                        _viewModel.getPredictedCasesAt(index),
                                        style: _appTheme.textDark.copyWith(
                                            color: _appTheme.colors.accent),
                                      ),
                                      flex: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _viewModel.getRealCasesAt(index),
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
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
