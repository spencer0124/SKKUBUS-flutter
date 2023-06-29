class BusData {
  final String sequence;
  final String stationName;
  final String eventDate;
  final String kind;
  final String? gpsLongitude;
  final String? gpsLatitude;
  final String useTime;
  final String carNumber;

  BusData(
      {required this.sequence,
      required this.stationName,
      required this.eventDate,
      required this.kind,
      required this.gpsLongitude,
      required this.gpsLatitude,
      required this.useTime,
      required this.carNumber});

  factory BusData.fromJson(Map<String, dynamic> json) {
    return BusData(
      sequence: json['sequence'],
      stationName: json['stationName'],
      eventDate: json['eventDate'],
      kind: json['kind'],
      gpsLongitude: json['gpsLongitude'],
      gpsLatitude: json['gpsLatitude'],
      useTime: json['useTime'],
      carNumber: json['carNumber'],
    );
  }
}
