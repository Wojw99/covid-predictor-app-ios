import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:covid_prediction_app_ios/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final IconData iconData;

  final double radius;
  final double elevation;
  final double height;

  final TextStyle textStyle;
  final Color backgroundColor;
  final bool disabledColor;

  IosButton({
    @required this.onPressed,
    @required this.text,
    this.iconData,
    this.backgroundColor = AppColors.accent,
    this.textStyle = AppStyles.textButton,
    this.disabledColor = false,
    this.radius = 9.0,
    this.elevation = 0.0,
    this.height = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// * * * * * * ICON * * * * * *
            Visibility(
              visible: iconData != null,
              child: Row(
                children: [
                  Icon(iconData),
                  Expanded(child: Container()),
                ],
              ),
            ),

            /// * * * * * * TEXT * * * * * *
            Text(
              text,
              style: !disabledColor
                  ? textStyle
                  : textStyle.copyWith(
                      color: AppColors.textLight,
                      fontWeight: FontWeight.normal,
                    ),
            ),
          ],
        ),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevation),
        backgroundColor: !disabledColor
            ? MaterialStateProperty.all<Color>(backgroundColor)
            : MaterialStateProperty.all<Color>(AppColors.gray),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}
