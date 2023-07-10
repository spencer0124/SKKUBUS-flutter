import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:skkumap/app/data/model/bus_data_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var baseUrl = Uri.parse(dotenv.env['KingoBusApi']!);

// var baseUrl = Uri.parse(dotenv.env['KingoBusApiTest']!);

class BusDataProvider {
  List<BusData> _cachedData = []; // Cache to store data

  Future<List<BusData>> fetchBusData() async {
    final response = await http.get(baseUrl);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var items = jsonData['items'] as List;

      // Map json data to bus data
      List<BusData> newData =
          items.map((busData) => BusData.fromJson(busData)).toList();

      // Iterate over the new data
      for (var i = 0; i < newData.length; i++) {
        // Try to find the item in the cache
        try {
          final cachedItem = _cachedData.firstWhere((cachedItem) =>
              cachedItem.stationName == newData[i].stationName &&
              cachedItem.carNumber == newData[i].carNumber);

          // If found and the useTime is different, keep the old useTime
          if (cachedItem.useTime != newData[i].useTime) {
            newData[i] = BusData(
              sequence: newData[i].sequence,
              stationName: newData[i].stationName,
              eventDate: newData[i].eventDate,
              kind: newData[i].kind,
              gpsLongitude: newData[i].gpsLongitude,
              gpsLatitude: newData[i].gpsLatitude,
              useTime: cachedItem.useTime,
              carNumber: newData[i].carNumber,
            );
          }
        } catch (e) {
          // If item is not in cache, do nothing
        }
      }

      // Update the cache
      _cachedData = newData;

      return newData;
    } else {
      throw Exception('Failed to load bus data');
    }
  }
}
