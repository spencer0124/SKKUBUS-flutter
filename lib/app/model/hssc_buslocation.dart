class HSSCBusLocation {
  @override
  String toString() {
    return 'HSSCBusLocation{sequence: $sequence, stationName: $stationName, carNumber: $carNumber, eventDate: $eventDate, estimatedTime: $estimatedTime}';
  }

  final String sequence;
  final String stationName;
  final String carNumber;
  final String eventDate;
  final int estimatedTime;

  HSSCBusLocation({
    required this.sequence,
    required this.stationName,
    required this.carNumber,
    required this.eventDate,
    required this.estimatedTime,
  });

  factory HSSCBusLocation.fromJson(Map<String, dynamic> json) {
    return HSSCBusLocation(
      sequence: json['sequence'] as String,
      stationName: json['stationName'] as String,
      carNumber: json['carNumber'] as String,
      eventDate: json['eventDate'] as String,
      estimatedTime: json['estimatedTime'] as int,
    );
  }
}
