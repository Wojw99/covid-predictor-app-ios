import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  static const defaultBoxDecoration = BoxDecoration(
    color: AppColors.light,
    borderRadius: BorderRadius.all(Radius.circular(9.0)),
  );

  static const TextStyle textLight = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
  );

  static const TextStyle textDark = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
  );

  static const TextStyle textButton = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    color: AppColors.light,
  );

  static const TextStyle textChartValue = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle textChartData = TextStyle(
    fontSize: 19.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );

  static const TextStyle header1 = TextStyle(
    fontSize: 34.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle header2 = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
  );
}
