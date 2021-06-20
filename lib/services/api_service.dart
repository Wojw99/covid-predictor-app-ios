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
  Future<List<Region>> getPredictionsList({path = 'kwolp.pl'}) async {
    final uri = Uri.http(path, '/covid/predictions.json');
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
  Future<List<Region>> getRealList({path = 'kwolp.pl'}) async {
    final uri = Uri.http(path, '/covid/reals.json');
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
          Output(date: DateTime.utc(2021, 04, 21), infected: 99),
          Output(date: DateTime.utc(2021, 04, 22), infected: 999),
          Output(date: DateTime.utc(2021, 04, 23), infected: 9999),
          Output(date: DateTime.utc(2021, 04, 24), infected: 244),
        ],
      ),
      Region(
        region: 'Germany',
        outputs: [
          Output(date: DateTime.utc(2021, 04, 21), infected: 11245),
          Output(date: DateTime.utc(2021, 04, 22), infected: 11500),
          Output(date: DateTime.utc(2021, 04, 23), infected: 11656),
          Output(date: DateTime.utc(2021, 04, 24), infected: 11567),
          Output(date: DateTime.utc(2021, 04, 25), infected: 11667),
          Output(date: DateTime.utc(2021, 04, 26), infected: 11267),
          Output(date: DateTime.utc(2021, 04, 27), infected: 11467),
        ],
      ),
      Region(
        region: 'United Kingdom',
        outputs: [
          Output(date: DateTime.utc(2021, 04, 21), infected: 1),
          Output(date: DateTime.utc(2021, 04, 22), infected: 23),
          Output(date: DateTime.utc(2021, 04, 23), infected: 266),
          Output(date: DateTime.utc(2021, 04, 24), infected: 3223),
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
          Output(date: DateTime.utc(2021, 04, 21), infected: 23),
          Output(date: DateTime.utc(2021, 04, 22), infected: 43),
          Output(date: DateTime.utc(2021, 04, 23), infected: 56),
          Output(date: DateTime.utc(2021, 04, 24), infected: 123),
          Output(date: DateTime.utc(2021, 04, 25), infected: 666),
          Output(date: DateTime.utc(2021, 04, 26), infected: 666),
        ],
      ),
      Region(
        region: 'Germany',
        outputs: [
          Output(date: DateTime.utc(2021, 04, 21), infected: 12330),
          Output(date: DateTime.utc(2021, 04, 22), infected: 11500),
          Output(date: DateTime.utc(2021, 04, 23), infected: 12656),
          Output(date: DateTime.utc(2021, 04, 24), infected: 13567),
          Output(date: DateTime.utc(2021, 04, 25), infected: 14667),
          Output(date: DateTime.utc(2021, 04, 26), infected: 15267),
          Output(date: DateTime.utc(2021, 04, 27), infected: 10467),
          Output(date: DateTime.utc(2021, 04, 28), infected: 12330),
          Output(date: DateTime.utc(2021, 04, 29), infected: 11500),
          Output(date: DateTime.utc(2021, 04, 30), infected: 12656),
          Output(date: DateTime.utc(2021, 05, 1), infected: 13567),
          Output(date: DateTime.utc(2021, 04, 2), infected: 14667),
          Output(date: DateTime.utc(2021, 04, 3), infected: 15267),
          Output(date: DateTime.utc(2021, 04, 4), infected: 10467),
          Output(date: DateTime.utc(2021, 04, 5), infected: 12330),
          Output(date: DateTime.utc(2021, 04, 6), infected: 11500),
          Output(date: DateTime.utc(2021, 04, 7), infected: 12656),
          Output(date: DateTime.utc(2021, 04, 8), infected: 13567),
          Output(date: DateTime.utc(2021, 04, 9), infected: 14667),
          Output(date: DateTime.utc(2021, 04, 10), infected: 15267),
          Output(date: DateTime.utc(2021, 04, 11), infected: 10467),
          Output(date: DateTime.utc(2021, 04, 12), infected: 11500),
          Output(date: DateTime.utc(2021, 04, 13), infected: 12656),
          Output(date: DateTime.utc(2021, 04, 14), infected: 13567),
          Output(date: DateTime.utc(2021, 04, 15), infected: 14667),
          Output(date: DateTime.utc(2021, 04, 16), infected: 15267),
          Output(date: DateTime.utc(2021, 04, 17), infected: 10467),
          Output(date: DateTime.utc(2021, 04, 18), infected: 10467),
        ],
      ),
      Region(
        region: 'United Kingdom',
        outputs: [
          Output(date: DateTime.utc(2021, 04, 21), infected: 123),
          Output(date: DateTime.utc(2021, 04, 22), infected: 143),
          Output(date: DateTime.utc(2021, 04, 23), infected: 256),
          Output(date: DateTime.utc(2021, 04, 24), infected: 3123),
          Output(date: DateTime.utc(2021, 04, 25), infected: 666),
          Output(date: DateTime.utc(2021, 04, 26), infected: 666),
        ],
      ),
    ];
  }
}
