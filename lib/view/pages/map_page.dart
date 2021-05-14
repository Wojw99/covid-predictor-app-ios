import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:covid_prediction_app_ios/utils/app_styles.dart';
import 'package:covid_prediction_app_ios/utils/constants.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_back_button.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_button.dart';
import 'package:covid_prediction_app_ios/viewmodels/map_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<MapViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// * * * * * APP BAR * * * * *
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.gray,
        leading: IosBackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: Container(
        color: AppColors.gray,
        child: Padding(
          padding: EdgeInsets.all(Constants.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// * * * * * HEADER * * * * *
              Text(
                Strings.worldMap,
                style: AppStyles.header1,
              ),

              SizedBox(height: 10.0),

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

              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
