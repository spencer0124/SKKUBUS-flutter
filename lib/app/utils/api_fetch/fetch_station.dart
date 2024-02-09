import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skkumap/app/model/station_model.dart';

Future<StationResponse> fetchStationData(String stationId) async {
  // final url = 'http://localhost:3000/station/v1/$stationId';
  var url =
      'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/station/v1/$stationId';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return StationResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load station data');
  }
}
