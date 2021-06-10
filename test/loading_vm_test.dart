import 'package:covid_prediction_app_ios/services/api_service.dart';
import 'package:covid_prediction_app_ios/services/app_prefs.dart';
import 'package:covid_prediction_app_ios/viewmodels/loading_vm.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Expected parameters
  final regionListLength = 193; // number of regions

  /// Tests
  group('LoadingViewModel', () {
    test('check if AppPreferences prediction list is filled correctly',
        () async {
      final vm = LoadingViewModel();
      // simulate fetching data on loading screen
      await vm.fetchApiData(
          path: '127.0.0.1:3000'); // 127.0.0.1 used for testing
      // prediction list in AppPreferences should be filled now
      expect(AppPreferences.predictionList.length, regionListLength);
    });
    test('check if AppPreferences real list is filled correctly', () async {
      final vm = LoadingViewModel();
      // simulate fetching data on loading screen
      await vm.fetchApiData(
          path: '127.0.0.1:3000'); // 127.0.0.1 used for testing
      // real list in AppPreferences should be filled now
      expect(AppPreferences.realList.length, regionListLength);
    });
  });

  /// Summary
  // No errors
}
