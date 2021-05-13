import 'package:flutter/cupertino.dart';

class Output {
  final DateTime date;
  final int cases;

  Output({
    @required this.date,
    @required this.cases,
  });

  factory Output.fromJson(Map<String, dynamic> json) {
    var dateSplit = json['date'].toString().split('/');
    var year = int.parse(dateSplit[2]) + 2000;
    var month = int.parse(dateSplit[1]);
    var day = int.parse(dateSplit[0]);

    return Output(
      date: DateTime.utc(year, month, day),
      cases: int.parse(json['cases']),
    );
  }
}
