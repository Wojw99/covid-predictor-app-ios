import 'package:covid_prediction_app_ios/utils/constants.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_back_button.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_button.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_textfield.dart';
import 'package:covid_prediction_app_ios/viewmodels/app_theme.dart';
import 'package:covid_prediction_app_ios/viewmodels/select_region_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectRegionPage extends StatefulWidget {
  @override
  _SelectRegionPageState createState() => _SelectRegionPageState();
}

class _SelectRegionPageState extends State<SelectRegionPage> {
  SelectRegionViewModel _viewModel;
  AppTheme _appTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<SelectRegionViewModel>(context);
    _appTheme = Provider.of<AppTheme>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// * * * * * APP BAR * * * * *
      appBar: AppBar(
        title: Text(
          Strings.selectRegion,
          style: TextStyle(
            color: _appTheme.colors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: _appTheme.colors.gray,
        leading: IosBackButton(onPressed: () => Navigator.of(context).pop()),
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
            children: [
              /// * * * * * BUTTON * * * * *
              IosTextField(
                iconData: Icons.search,
                hintText: Strings.search,
                initialValue: '',
                onChanged: (value) {
                  _viewModel.filterRegions(value);
                },
              ),

              SizedBox(height: Constants.screenPadding / 2),

              /// * * * * * LIST * * * * *
              Expanded(
                child: ListView.builder(
                  itemCount: _viewModel.regionNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
                      child: IosButton(
                        disabled: false,
                        height: 48.0,
                        onPressed: () {
                          _viewModel.popWithRegionName(
                            context,
                            _viewModel.regionNames[index],
                          );
                        },
                        backgroundColor: _appTheme.colors.accent,
                        text: _viewModel.regionNames[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
