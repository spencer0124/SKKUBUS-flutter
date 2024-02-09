import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart'; // Import GetX package for Rx
import 'package:skkumap/app/model/main_bus_stationlist.dart'; // Assuming your combined models are in 'models.dart'
import 'package:skkumap/app/types/bus_type.dart';

// This function should return a Future of HSSCstationModel, not void
Future<MainBusStationList> fetchMainBusStations(
    {required BusType busType}) async {
  String url;

  if (busType == BusType.jongro07Bus) {
    // url = 'http://localhost:3000/bus/jongro/v1/busstation/07';
    url =
        'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/bus/jongro/v1/busstation/07';
  } else if (busType == BusType.jongro02Bus) {
    // url = 'http://localhost:3000/bus/jongro/v1/busstation/02';
    url =
        'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/bus/jongro/v1/busstation/02';
  } else {
    // url = 'http://localhost:3000/bus/hssc/v1/busstation';
    url =
        'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/bus/hssc/v1/busstation/';
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    // print('MainBusStation fetched');
    // print(jsonResponse);
    return MainBusStationList.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load bus stations data');
  }
}
