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
import 'package:syncfusion_flutter_maps/maps.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapViewModel _viewModel;
  MapShapeSource _dataSource;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<MapViewModel>(context);
    _dataSource = MapShapeSource.asset(
      "assets/world.json",
      shapeDataField: "name",
      dataCount: _viewModel.getDataCount(),
      primaryValueMapper: (int index) =>
          _viewModel.getPrimaryValueMapper(index),
      bubbleSizeMapper: (int index) => _viewModel.getBubbleSizeMapper(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// * * * * * APP BAR * * * * *
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.gray,
        title: Text(
          Strings.worldMap,
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IosBackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: Container(
        color: AppColors.gray,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// * * * * * BUTTON DATE * * * * *
            Padding(
              padding: EdgeInsets.fromLTRB(
                Constants.screenPadding,
                0,
                Constants.screenPadding,
                Constants.screenPadding / 2,
              ),
              child: IosButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: _viewModel.selectedDate,
                    firstDate: _viewModel.getFirstDate(),
                    lastDate: _viewModel.getLastDate(),
                  ).then((value) => _viewModel.changeDate(value));
                },
                text: _viewModel.selectedDateString,
                iconData: Icons.calendar_today,
              ),
            ),

            /// * * * * * WORLD MAP * * * * *
            Expanded(
              child: Container(
                color: AppColors.light,
                child: SfMaps(
                  layers: [
                    MapShapeLayer(
                      source: _dataSource,
                      bubbleSettings: MapBubbleSettings(
                        maxRadius: 30,
                        minRadius: 15,
                        color: AppColors.accent.withOpacity(0.5),
                      ),
                      color: AppColors.accentLight,
                      bubbleTooltipBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Region: ${_viewModel.getPrimaryValueMapper(index)}'
                            '\nCases: ${_viewModel.getBubbleSizeMapper(index).toInt()}',
                            style: AppStyles.textButton
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                        );
                      },
                      zoomPanBehavior: MapZoomPanBehavior(
                        enablePanning: true,
                        enableDoubleTapZooming: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// * * * * * SETTINGS * * * * *
            Container(
              color: AppColors.light,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.screenPadding,
                  vertical: Constants.screenPadding / 3,
                ),
                child: Row(
                  children: [
                    /// * * * PREDICTED * * *
                    Expanded(
                      child: IosButton(
                        onPressed: () {
                          _viewModel.changePredicted(true);
                        },
                        disabledColor: _viewModel.showPredicted ? false : true,
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
                        disabledColor: _viewModel.showPredicted ? true : false,
                        text: Strings.real,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
