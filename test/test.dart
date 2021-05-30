import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:covid_prediction_app_ios/main.dart';

void main() {
  group('Testing', () {
    test('', () {
      List<double> list1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      final list2 = list1.sublist(0, 3).toList();
      print(list1);
      print(list2);
      expect(list2, [1, 2, 3]);
    });
  });
}
