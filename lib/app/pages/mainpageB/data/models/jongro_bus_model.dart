import 'package:flutter_naver_map/flutter_naver_map.dart';

class JongroBusModel {
  final String busNumber;
  final NLatLng position;
  final int lastStationId;
  final bool isOnStation;

  JongroBusModel({
    required this.busNumber,
    required this.position,
    required this.lastStationId,
    required this.isOnStation,
  });
  bool get isLastStation => lastStationId == 100900075 && isOnStation;

  factory JongroBusModel.fromJson(Map<String, dynamic> json) {
    return JongroBusModel(
      busNumber: json['plainNo'],
      position: NLatLng(double.parse(json['tmY']), double.parse(json['tmX'])),
      lastStationId: int.tryParse(json['lastStnId']) ?? -1,
      isOnStation: json['stopFlag'] == "1",
    );
  }
}
