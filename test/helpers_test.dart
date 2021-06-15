import 'package:covid_prediction_app_ios/view/view_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:covid_prediction_app_ios/main.dart';

void main() {
  group('ViewHelper', () {
    test('format number', () {
      var num = 885325;
      var format = ViewHelper.formatNumber(num.toString());
      expect(format, '885 325');
    });

    test('format number2', () {
      var num = 4000;
      var format = ViewHelper.formatNumber(num.toString());
      expect(format, '4 000');
    });

    test('format number3', () {
      var num = 6000000;
      var format = ViewHelper.formatNumber(num.toString());
      expect(format, '6 000 000');
    });

    test('format number4', () {
      var num = 6000000000;
      var format = ViewHelper.formatNumber(num.toString());
      expect(format, '6 000 000 000');
    });
  });
}
