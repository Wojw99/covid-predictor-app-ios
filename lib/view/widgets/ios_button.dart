import 'package:covid_prediction_app_ios/utils/app_colors.dart';
import 'package:covid_prediction_app_ios/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final IconData iconData;

  final double radius = 9.0;
  final double elevation = 0.0;
  final double height = 36.0;

  final TextStyle textStyle = AppStyles.textButton;
  final Color backgroundColor = AppColors.accent;

  IosButton({
    @required this.onPressed,
    @required this.text,
    this.iconData,
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
              style: textStyle,
            ),
          ],
        ),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevation),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}
