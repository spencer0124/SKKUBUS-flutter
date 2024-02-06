import 'package:skkumap/app/types/bus_type.dart';

class ResponseMetadata {
  final String currentTime;
  final int totalBuses;

  ResponseMetadata({
    required this.currentTime,
    required this.totalBuses,
  });

  factory ResponseMetadata.fromJson(Map<String, dynamic> json) {
    return ResponseMetadata(
      currentTime: json['currentTime'],
      totalBuses: json['totalBuses'],
    );
  }
}

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

class HSSCstationModel {
  final ResponseMetadata metadata;
  final List<BusStation> stations;

  HSSCstationModel({
    required this.metadata,
    required this.stations,
  });

  factory HSSCstationModel.fromJson(Map<String, dynamic> json) {
    var stationsList = (json['HSSCStations'] as List)
        .map((i) => BusStation.fromJson(i))
        .toList();

    return HSSCstationModel(
      metadata: ResponseMetadata.fromJson(json['metadata']),
      stations: stationsList,
    );
  }
}
