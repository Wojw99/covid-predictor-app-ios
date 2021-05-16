import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WChart extends StatefulWidget {
  final List<double> values;
  final double height;
  final double width;
  final Function(int, double) onPressed;
  final Color backgroundColor;
  final Color barColor;
  final Color selectedBarColor;
  final double barRadiusValue;

  WChart({
    this.values = const [],
    @required this.height,
    @required this.width,
    @required this.onPressed,
    this.backgroundColor = Colors.white,
    this.barColor = Colors.grey,
    this.selectedBarColor = Colors.blue,
    this.barRadiusValue = 9.0,
  });

  @override
  _WChartState createState() => _WChartState();
}

class _WChartState extends State<WChart> {
  int tappedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final maxVal = widget.values.isNotEmpty ? findMaxValue() : 0;
    final valuesSize = widget.values.length;
    final valuesMap = widget.values.asMap();
    return Container(
      height: widget.height,
      width: widget.width,
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: valuesMap.entries
            .map(
              (entry) => GestureDetector(
                onTap: () {
                  setState(() {
                    tappedIndex = entry.key;
                  });
                  widget.onPressed(entry.key, entry.value);
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    /// REST OF SPACE
                    Container(
                      color: widget.backgroundColor,
                      height: widget.height,
                      width: widget.width / valuesSize,
                    ),

                    /// * * * FILLED * * *
                    Container(
                      width: widget.width / valuesSize,
                      height: (entry.value * widget.height) / maxVal,
                      decoration: BoxDecoration(
                        color: entry.key == tappedIndex
                            ? widget.selectedBarColor
                            : widget.barColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(widget.barRadiusValue),
                          topRight: Radius.circular(widget.barRadiusValue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  double findMaxValue() {
    var maxVal = widget.values[0];

    for (var v in widget.values) {
      if (v > maxVal) maxVal = v;
    }

    return maxVal;
  }
}
