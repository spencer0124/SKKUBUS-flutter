import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart'; // Import GetX package for Rx
import 'package:skkumap/app/model/hssc_station_model.dart'; // Assuming your combined models are in 'models.dart'

// This function should return a Future of HSSCstationModel, not void
Future<HSSCstationModel> fetchBusStations() async {
  const url = 'http://localhost:3000/bus/hssc/v1/busstation';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return HSSCstationModel.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load bus stations data');
  }
}
