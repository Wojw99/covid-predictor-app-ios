import 'package:covid_prediction_app_ios/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Expected parameters
  final regionListLength = 193; // number of regions
  final polandPredictedAtFirstDayOfYear = 28956;
  final polandRealAtFirstDayOfYear = 1305774;
  final firstDate = DateTime.utc(2020, 4, 9);
  final lastDate = DateTime.utc(2021, 6, 8);

  /// Tests
  group('ApiService', () {
    /// Length of regions
    test('check if length of predicted regions is correct', () async {
      var service = ApiService();
      var list = await service.getPredictionsList(path: '127.0.0.1:3000');
      expect(list.length, regionListLength);
    });
    test('check if length of real regions is correct', () async {
      var service = ApiService();
      var list = await service.getRealList(path: '127.0.0.1:3000');
      expect(list.length, regionListLength);
    });

    /// First date
    test('check if first data in predicted list is correct', () async {
      var service = ApiService();
      var list = await service.getPredictionsList(path: '127.0.0.1:3000');
      var polandOutputs = list
          .where((element) => element.region == 'Poland')
          .toList()
          .first
          .outputs;
      expect(polandOutputs.first.date, firstDate);
    });
    test('check if first data in real list is correct', () async {
      var service = ApiService();
      var list = await service.getRealList(path: '127.0.0.1:3000');
      var polandOutputs = list
          .where((element) => element.region == 'Poland')
          .toList()
          .first
          .outputs;
      expect(polandOutputs.first.date, firstDate);
    });

    /// Last date
    test('check if last data in predicted list is correct', () async {
      var service = ApiService();
      var list = await service.getPredictionsList(path: '127.0.0.1:3000');
      var polandOutputs = list
          .where((element) => element.region == 'Poland')
          .toList()
          .first
          .outputs;
      expect(polandOutputs.last.date, lastDate);
    });
    test('check if last data in real list is correct', () async {
      var service = ApiService();
      var list = await service.getRealList(path: '127.0.0.1:3000');
      var polandOutputs = list
          .where((element) => element.region == 'Poland')
          .toList()
          .first
          .outputs;
      expect(polandOutputs.last.date, lastDate);
    });
  });

  /// Summary
  // 1. By default emulator not fetching data from localhost. We had to change
  // settings in android and ios native files before fetching.
  // 2. Development machine not fetching data from 10.0.2.2 with is
  // a special alias to host loopback interface. Instead we must use
  // 127.0.0.1 with is preferred for development machine.
  // 3. Output cases was fetching with unexpected shift. We had to change it in
  // the API
}
