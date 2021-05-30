import 'output.dart';

class Region {
  final String region;
  final List<Output> outputs;

  Region({
    this.region,
    this.outputs,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    final outputs = json['outputs']
        .cast<Map<String, dynamic>>()
        .map<Output>((json) => Output.fromJson(json))
        .toList();

    return Region(
      region: json['region'],
      outputs: outputs,
    );
  }
}
