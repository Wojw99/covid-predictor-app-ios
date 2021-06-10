import 'package:covid_prediction_app_ios/services/storage_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('StorageManager', () {
    test('saving/loading data', () async {
      var key = 'TESTKEY';
      var expected = false;
      await StorageManager.saveData(key, expected);
      var testKeyData = await StorageManager.readBoolData(key);
      expect(testKeyData, expected);
    });

    test('deleting data', () async {
      var key = 'TESTKEY';

      await StorageManager.saveData(key, true);
      await StorageManager.deleteData(key);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey(key), false);
    });
  });
}
