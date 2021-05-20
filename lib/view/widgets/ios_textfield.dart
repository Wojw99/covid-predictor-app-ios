import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosTextField extends StatelessWidget {
  final String hintText;
  final String initialValue;
  final Function(String) onChanged;
  final IconData iconData;
  final Color backgroundColor;
  final Color textColor;
  final double height;

  IosTextField({
    this.hintText,
    this.initialValue,
    this.onChanged,
    this.iconData,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.height = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
        color: backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            icon: iconData != null ? Icon(iconData) : null,
            fillColor: backgroundColor,
            hoverColor: backgroundColor,
            focusColor: backgroundColor,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            hintText: hintText,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
