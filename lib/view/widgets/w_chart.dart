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
  final int initialIndex;

  WChart({
    this.values = const [],
    @required this.height,
    @required this.width,
    @required this.onPressed,
    this.backgroundColor = Colors.white,
    this.barColor = Colors.grey,
    this.selectedBarColor = Colors.blue,
    this.barRadiusValue = 9.0,
    this.initialIndex = 0,
  });

  @override
  _WChartState createState() => _WChartState();
}

class _WChartState extends State<WChart> {
  int tappedIndex = 0;

  @override
  void initState() {
    tappedIndex = widget.initialIndex;
    checkNegatives();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final maxVal = widget.values.isNotEmpty ? findMaxValue() : 0;
    final minVal = widget.values.isNotEmpty ? findMinValue() : 0;
    final valuesSize = widget.values.length;
    final valuesMap = widget.values.asMap();
    final barWidth = widget.width / valuesSize;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final x = details.localPosition.dx;
        final index = x ~/ barWidth; // equals to (x / barWidth).toInt()
        // print('$x / $barWidth = ${x / barWidth} so i = ${index}');
        setState(() {
          tappedIndex = index;
        });
        if (index < valuesSize && index >= 0) {
          widget.onPressed(index, widget.values[index]);
        }
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        color: widget.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: valuesMap.entries.map((entry) {
            final shift = minVal / 1.03;
            final filledHeight =
                ((entry.value - shift) * widget.height) / (maxVal - shift);
            return GestureDetector(
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
                    height: filledHeight,
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
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Search for negative values and throw an exception if any are found
  void checkNegatives() {
    for (int i = 0; i < widget.values.length; i++) {
      if (widget.values[i] < 0)
        throw Exception('Values for chart cannot be less than zero!');
    }
  }

  double findMaxValue() {
    var maxVal = widget.values[0];

    for (var v in widget.values) {
      if (v > maxVal) maxVal = v;
    }

    return maxVal;
  }

  double findMinValue() {
    var maxVal = widget.values[0];

    for (var v in widget.values) {
      if (v < maxVal) maxVal = v;
    }

    return maxVal;
  }
}
