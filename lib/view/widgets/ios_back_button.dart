import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosBackButton extends StatelessWidget {
  final Function onPressed;
  final Color iconColor;

  IosBackButton({this.onPressed, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: iconColor),
      onPressed: onPressed,
    );
  }
}
