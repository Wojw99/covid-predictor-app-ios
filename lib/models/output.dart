import 'package:flutter/cupertino.dart';

class Output {
  final DateTime date;
  final int infected;
  final int recovered;
  final int deaths;

  Output({
    @required this.date,
    @required this.infected,
    @required this.recovered,
    @required this.deaths,
  });

  factory Output.fromJson(Map<String, dynamic> json) {
    var dateSplit = json['date'].toString().split('/');
    var year = int.parse(dateSplit[2]) + 2000;
    var month = int.parse(dateSplit[0]);
    var day = int.parse(dateSplit[1]);

    return Output(
      date: DateTime.utc(year, month, day),
      infected: int.parse(json['cases']),
      recovered: int.parse(json['recovered']),
      deaths: int.parse(json['deaths']),
    );
  }
}
