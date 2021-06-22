import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosButton extends StatelessWidget {
  final Key key;
  final Function onPressed;
  final String text;
  final IconData iconData;

  final double radius;
  final double elevation;
  final double height;

  final TextStyle textStyle;
  final TextStyle disabledTextStyle;
  final Color backgroundColor;
  final Color disabledColor;
  final bool disabled;

  IosButton({
    this.key,
    @required this.onPressed,
    @required this.text,
    this.iconData,
    this.backgroundColor = const Color(0xff0A64EC),
    this.disabledColor = const Color(0xfff4f4f4),
    this.textStyle = const TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    this.disabledTextStyle = const TextStyle(
      fontSize: 17.0,
      color: Color(0xff7A7A7A),
      fontWeight: FontWeight.normal,
    ),
    this.disabled = false,
    this.radius = 9.0,
    this.elevation = 0.0,
    this.height = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
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
              style: !disabled ? textStyle : disabledTextStyle,
            ),
          ],
        ),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevation),
        backgroundColor: !disabled
            ? MaterialStateProperty.all<Color>(backgroundColor)
            : MaterialStateProperty.all<Color>(disabledColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}
