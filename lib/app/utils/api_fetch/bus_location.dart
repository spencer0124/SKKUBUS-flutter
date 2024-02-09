import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:skkumap/app/model/mainpage_buslist_model.dart';
import 'package:skkumap/app/model/main_bus_location.dart';
// import 'package:skkumap/app/model/hssc_station_model.dart';
import 'package:skkumap/app/types/bus_type.dart';

Future<List<MainBusLocation>> fetchMainBusLocation(
    {required BusType busType}) async {
  String url;

  if (busType == BusType.jongro07Bus) {
    // url = 'http://localhost:3000/bus/jongro/v1/buslocation/07';
    url =
        'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/bus/jongro/v1/buslocation/07';
  } else if (busType == BusType.jongro02Bus) {
    // url = 'http://localhost:3000/bus/jongro/v1/buslocation/02';
    url =
        'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/bus/jongro/v1/buslocation/02';
  } else {
    // url = 'http://localhost:3000/bus/hssc/v1/buslocation';
    url =
        'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/bus/hssc/v1/buslocation/';
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    // print(l);
    // print('MainBusLocation fetched');
    return List<MainBusLocation>.from(
        l.map((model) => MainBusLocation.fromJson(model)));
  } else {
    throw Exception('Failed to fetch MainBusLocation');
  }
}
