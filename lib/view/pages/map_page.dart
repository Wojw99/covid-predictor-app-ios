import 'package:covid_prediction_app_ios/utils/constants.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_back_button.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_button.dart';
import 'package:covid_prediction_app_ios/viewmodels/app_theme.dart';
import 'package:covid_prediction_app_ios/viewmodels/map_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class LandscapeView extends StatefulWidget {
  @override
  _LandscapeViewState createState() => _LandscapeViewState();
}

class _LandscapeViewState extends State<LandscapeView> {
  MapViewModel _viewModel;
  AppTheme _appTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<MapViewModel>(context);
    _appTheme = Provider.of<AppTheme>(context);
  }

  @override
  Widget build(BuildContext context) {
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
                firstDate: _viewModel.getFirstDate(),
                lastDate: _viewModel.getLastDate(),
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
}

class PortraitView extends StatefulWidget {
  @override
  _PortraitViewState createState() => _PortraitViewState();
}

class _PortraitViewState extends State<PortraitView> {
  MapViewModel _viewModel;
  AppTheme _appTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<MapViewModel>(context);
    _appTheme = Provider.of<AppTheme>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: MediaQuery.of(context).orientation == Orientation.portrait,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// * * * * * BACK BUTTON * * * * *
          IosBackButton(
            onPressed: () => Navigator.of(context).pop(),
            iconColor: _appTheme.colors.accent,
          ),

          /// * * * * * BUTTON DATE * * * * *
          IosButton(
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
            backgroundColor: _appTheme.colors.accent,
          ),
        ],
      ),
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapViewModel _viewModel;
  AppTheme _appTheme;
  MapShapeSource _dataSource;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<MapViewModel>(context);
    _appTheme = Provider.of<AppTheme>(context);
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
      body: SafeArea(
        child: Container(
          color: _appTheme.colors.gray,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// * * * * * WORLD MAP * * * * *
              Expanded(
                child: Container(
                  color: _appTheme.colors.light,
                  child: Stack(
                    children: [
                      SfMaps(
                        layers: [
                          MapShapeLayer(
                            source: _dataSource,
                            bubbleSettings: MapBubbleSettings(
                              maxRadius: 30,
                              minRadius: 15,
                              color: _appTheme.colors.accent.withOpacity(0.5),
                            ),
                            color: _appTheme.colors.accentLight,
                            bubbleTooltipBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Region: ${_viewModel.getPrimaryValueMapper(index)}'
                                  '\nCases: ${_viewModel.getBubbleSizeMapper(index).toInt()}',
                                  style: _appTheme.textButton
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

                      /// * * * * * SETTINGS * * * * *
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          Constants.screenPadding / 2,
                          8.0,
                          Constants.screenPadding / 2,
                          Constants.screenPadding / 3,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LandscapeView(),
                            Row(
                              children: [
                                /// * * * PREDICTED * * *
                                Expanded(
                                  child: IosButton(
                                    onPressed: () {
                                      _viewModel.changePredicted(true);
                                    },
                                    disabled:
                                        _viewModel.showPredicted ? false : true,
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
                                    disabled:
                                        _viewModel.showPredicted ? true : false,
                                    disabledColor: _appTheme.colors.gray,
                                    text: Strings.real,
                                    backgroundColor: _appTheme.colors.accent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
