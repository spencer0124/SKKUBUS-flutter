import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Function to call the API, calculate, and return the number of remaining stations
Future<int> calculateRemainingStationsToHyehwaStation() async {
  await dotenv.load(fileName: ".env");
  var baseUrl =
      Uri.parse(dotenv.env['KingoBusApi']!); // Replace with your actual API URL
  final response = await http.get(baseUrl);
  print('response: $response');

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    var items = jsonData['items'] as List;

    // Convert the JSON items to BusData objects
    List<BusData> busDataList =
        items.map((item) => BusData.fromJson(item)).toList();

    // Find the index of '혜화역(승차장)'
    int hyehwaStationIndex =
        busDataList.indexWhere((station) => station.stationName == '혜화역(승차장)');

    // Check if '혜화역(승차장)' exists in the data
    if (hyehwaStationIndex == -1) {
      return -1; // If '혜화역(승차장)' is not found in the list, return -1
    }

    // Calculate the remaining stations
    int closestBusIndex = -1; // Initialize with -1 to indicate not found

    for (int i = hyehwaStationIndex; i >= 0; i--) {
      if (busDataList[i].carNumber.isNotEmpty) {
        // If this is the Hyehwa station and the eventDate is older than 25 seconds, ignore it
        if (busDataList[i].stationName == '혜화역(승차장)') {
          DateTime now = DateTime.now();
          DateTime eventDateTime;
          try {
            eventDateTime = DateTime.parse(busDataList[i].eventDate);
          } catch (e) {
            print('Error parsing date: ${e.toString()}');
            continue; // Skip this and try the next one
          }

          Duration difference = now.difference(eventDateTime);
          if (difference.inSeconds > 25) {
            continue; // This bus is too old, continue searching
          } else {
            return 0; // Bus is currently at '혜화역(승차장)' and eventDate is within the last 25 seconds
          }
        }

        // Keep track of the closest bus that is not at the Hyehwa station
        closestBusIndex = i;
        break; // We found the closest bus, no need to check earlier ones
      }
    }

// If we found a bus that is en route and not too old, calculate the remaining stations
    if (closestBusIndex != -1) {
      return hyehwaStationIndex - closestBusIndex;
    }

    return -1; // If no valid bus is found, return -1
  } else {
    throw Exception('Failed to load bus data'); // Handle non-200 responses
  }
}

// BusData model
class BusData {
  String sequence;
  String stationName;
  String eventDate;
  String kind;
  String gpsLongitude;
  String gpsLatitude;
  String useTime;
  String carNumber;

  BusData({
    required this.sequence,
    required this.stationName,
    required this.eventDate,
    required this.kind,
    required this.gpsLongitude,
    required this.gpsLatitude,
    required this.useTime,
    required this.carNumber,
  });

  factory BusData.fromJson(Map<String, dynamic> json) {
    return BusData(
      sequence: json['sequence'] as String? ?? '',
      stationName: json['stationName'] as String? ?? '',
      eventDate: json['eventDate'] as String? ?? '',
      kind: json['kind'] as String? ?? '',
      gpsLongitude: json['gpsLongitude']?.toString() ?? '',
      gpsLatitude: json['gpsLatitude']?.toString() ?? '',
      useTime: json['useTime'] as String? ?? '',
      carNumber: json['carNumber'] as String? ?? '',
    );
  }
}

void main() async {
  try {
    int remainingStations = await calculateRemainingStationsToHyehwaStation();
    print('Remaining stations to Hyehwa Station: $remainingStations');
  } catch (e) {
    print('An error occurred: $e');
  }
}
