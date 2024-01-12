import 'package:skkumap/app/types/bus_type.dart';

class BusStation {
  final String stationName;
  final String? stationNumber;
  final String eta;
  final bool isFirstStation;
  final bool isLastStation;
  final bool isRotationStation;
  final String busType;

  BusStation({
    required this.stationName,
    this.stationNumber,
    required this.eta,
    required this.isFirstStation,
    required this.isLastStation,
    required this.isRotationStation,
    required this.busType,
  });

  factory BusStation.fromJson(Map<String, dynamic> json) {
    return BusStation(
      stationName: json['stationName'],
      stationNumber: json['stationNumber'],
      eta: json['eta'],
      isFirstStation: json['isFirstStation'],
      isLastStation: json['isLastStation'],
      isRotationStation: json['isRotationStation'],
      busType: json['busType'],
    );
  }
}
