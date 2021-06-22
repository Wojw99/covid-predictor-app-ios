import 'dart:convert';
import 'package:covid_prediction_app_ios/models/output.dart';
import 'package:covid_prediction_app_ios/models/region.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /// Fetch data from API and return response body
  Future<String> getPredictionsBody({path = 'kwolp.pl'}) async {
    final uri = Uri.http(path, '/covid/predictions.json');
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
}
