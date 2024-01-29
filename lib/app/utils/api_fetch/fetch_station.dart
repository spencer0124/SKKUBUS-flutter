import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skkumap/app/model/station_model.dart';

Future<StationResponse> fetchStationData(String stationId) async {
  final url = 'http://localhost:3000/v1/station/$stationId';
  // const url = 'http://localhost:3000/bus/hssc/v1/busstation';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return StationResponse.fromJson(json.decode(response.body));
  } else {
    // Handle errors
    throw Exception('Failed to load station data');
  }
}
