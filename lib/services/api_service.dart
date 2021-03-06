import 'dart:convert';
import 'package:covid_prediction_app_ios/models/output.dart';
import 'package:covid_prediction_app_ios/models/region.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /// Fetch data from API and return response body
  Future<String> getPredictionsBody() async {
    final uri = Uri.http('10.0.2.2:3000', '/api/predictions');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unable to perform request!');
    }
  }

  /// Fetch data from API and return list of Region model
  Future<List<Region>> getPredictionsList({path = '10.0.2.2:3000'}) async {
    final uri = Uri.http(path, '/api/predictions');
    final response = await http.get(uri);
    final regionList = <Region>[];

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      for (var regJson in json) {
        var region = Region.fromJson(regJson);
        regionList.add(region);
      }

      return regionList;
    } else {
      throw Exception('Unable to perform request!');
    }
  }

  /// Fetch data from API and return list of Region model
  Future<List<Region>> getRealList({path = '10.0.2.2:3000'}) async {
    final uri = Uri.http(path, '/api/reals');
    final response = await http.get(uri);
    final regionList = <Region>[];

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      for (var regJson in json) {
        var region = Region.fromJson(regJson);
        regionList.add(region);
      }

      return regionList;
    } else {
      throw Exception('Unable to perform request!');
    }
  }

  Future<List<Region>> getRealListTest() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      Region(
        region: 'Poland',
        outputs: [
          Output(date: DateTime.utc(2021, 04, 21), cases: 99),
          Output(date: DateTime.utc(2021, 04, 22), cases: 999),
          Output(date: DateTime.utc(2021, 04, 23), cases: 9999),
          Output(date: DateTime.utc(2021, 04, 24), cases: 244),
        ],
      ),
      Region(
        region: 'Germany',
        outputs: [
          Output(date: DateTime.utc(2021, 04, 21), cases: 11245),
          Output(date: DateTime.utc(2021, 04, 22), cases: 11500),
          Output(date: DateTime.utc(2021, 04, 23), cases: 11656),
          Output(date: DateTime.utc(2021, 04, 24), cases: 11567),
          Output(date: DateTime.utc(2021, 04, 25), cases: 11667),
          Output(date: DateTime.utc(2021, 04, 26), cases: 11267),
          Output(date: DateTime.utc(2021, 04, 27), cases: 11467),
        ],
      ),
      Region(
        region: 'United Kingdom',
        outputs: [
          Output(date: DateTime.utc(2021, 04, 21), cases: 1),
          Output(date: DateTime.utc(2021, 04, 22), cases: 23),
          Output(date: DateTime.utc(2021, 04, 23), cases: 266),
          Output(date: DateTime.utc(2021, 04, 24), cases: 3223),
        ],
      ),
    ];
  }

  /// Poland, USA - two more outputs than the real list,
  /// Germany - same amount of outputs
  Future<List<Region>> getPredictionsListTest() async {
    await Future.delayed(Duration(seconds: 2), () {});
    return [
      Region(
        region: 'Poland',
        outputs: [
          Output(date: DateTime.utc(2021, 04, 21), cases: 23),
          Output(date: DateTime.utc(2021, 04, 22), cases: 43),
          Output(date: DateTime.utc(2021, 04, 23), cases: 56),
          Output(date: DateTime.utc(2021, 04, 24), cases: 123),
          Output(date: DateTime.utc(2021, 04, 25), cases: 666),
          Output(date: DateTime.utc(2021, 04, 26), cases: 666),
        ],
      ),
      Region(
        region: 'Germany',
        outputs: [
          Output(date: DateTime.utc(2021, 04, 21), cases: 12330),
          Output(date: DateTime.utc(2021, 04, 22), cases: 11500),
          Output(date: DateTime.utc(2021, 04, 23), cases: 12656),
          Output(date: DateTime.utc(2021, 04, 24), cases: 13567),
          Output(date: DateTime.utc(2021, 04, 25), cases: 14667),
          Output(date: DateTime.utc(2021, 04, 26), cases: 15267),
          Output(date: DateTime.utc(2021, 04, 27), cases: 10467),
          Output(date: DateTime.utc(2021, 04, 28), cases: 12330),
          Output(date: DateTime.utc(2021, 04, 29), cases: 11500),
          Output(date: DateTime.utc(2021, 04, 30), cases: 12656),
          Output(date: DateTime.utc(2021, 05, 1), cases: 13567),
          Output(date: DateTime.utc(2021, 04, 2), cases: 14667),
          Output(date: DateTime.utc(2021, 04, 3), cases: 15267),
          Output(date: DateTime.utc(2021, 04, 4), cases: 10467),
          Output(date: DateTime.utc(2021, 04, 5), cases: 12330),
          Output(date: DateTime.utc(2021, 04, 6), cases: 11500),
          Output(date: DateTime.utc(2021, 04, 7), cases: 12656),
          Output(date: DateTime.utc(2021, 04, 8), cases: 13567),
          Output(date: DateTime.utc(2021, 04, 9), cases: 14667),
          Output(date: DateTime.utc(2021, 04, 10), cases: 15267),
          Output(date: DateTime.utc(2021, 04, 11), cases: 10467),
          Output(date: DateTime.utc(2021, 04, 12), cases: 11500),
          Output(date: DateTime.utc(2021, 04, 13), cases: 12656),
          Output(date: DateTime.utc(2021, 04, 14), cases: 13567),
          Output(date: DateTime.utc(2021, 04, 15), cases: 14667),
          Output(date: DateTime.utc(2021, 04, 16), cases: 15267),
          Output(date: DateTime.utc(2021, 04, 17), cases: 10467),
          Output(date: DateTime.utc(2021, 04, 18), cases: 10467),
        ],
      ),
      Region(
        region: 'United Kingdom',
        outputs: [
          Output(date: DateTime.utc(2021, 04, 21), cases: 123),
          Output(date: DateTime.utc(2021, 04, 22), cases: 143),
          Output(date: DateTime.utc(2021, 04, 23), cases: 256),
          Output(date: DateTime.utc(2021, 04, 24), cases: 3123),
          Output(date: DateTime.utc(2021, 04, 25), cases: 666),
          Output(date: DateTime.utc(2021, 04, 26), cases: 666),
        ],
      ),
    ];
  }
}
