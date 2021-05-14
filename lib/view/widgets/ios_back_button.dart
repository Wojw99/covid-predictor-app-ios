import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosBackButton extends StatelessWidget {
  final Function onPressed;

  IosBackButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: AppColors.accent),
      onPressed: onPressed,
    );
  }
}
