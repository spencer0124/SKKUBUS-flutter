class MainBusLocation {
  @override
  String toString() {
    return 'MainBusLocation{sequence: $sequence, stationName: $stationName, carNumber: $carNumber, eventDate: $eventDate, estimatedTime: $estimatedTime}';
  }

  final String sequence;
  final String stationName;
  final String carNumber;
  final String eventDate;
  final int estimatedTime;
  final bool isLastBus;

  MainBusLocation({
    required this.sequence,
    required this.stationName,
    required this.carNumber,
    required this.eventDate,
    required this.estimatedTime,
    required this.isLastBus,
  });

  factory MainBusLocation.fromJson(Map<String, dynamic> json) {
    return MainBusLocation(
      sequence: json['sequence'] as String,
      stationName: json['stationName'] as String,
      carNumber: json['carNumber'] as String,
      eventDate: json['eventDate'] as String,
      estimatedTime: json['estimatedTime'] as int,
      isLastBus: json['isLastBus'] as bool,
    );
  }
}
