class ArrivalInfo {
  final String message;
  late final Duration duration;
  late final int left;

  ArrivalInfo(this.message) {
    final regExp = RegExp(r'(\d+)분((\d+)초)?후\[(\d+)번째 전\]');
    final match = regExp.firstMatch(message);

    if (match == null) {
      duration = Duration.zero;
      left = 0;
    } else {
      duration = Duration(
        minutes: int.parse(match.group(1)!),
        seconds: int.parse(match.group(3) ?? '0'),
      );
      left = int.parse(match.group(4)!);
    }
  }
}

class JongroBusArrivalModel {
  final List<ArrivalInfo> arrivals;

  JongroBusArrivalModel(this.arrivals);

  factory JongroBusArrivalModel.fromJson(Map<String, dynamic> json) {
    return JongroBusArrivalModel(
      [json['arrmsg1'], json['arrmsg2']].map((e) => ArrivalInfo(e)).toList(),
    );
  }
}
