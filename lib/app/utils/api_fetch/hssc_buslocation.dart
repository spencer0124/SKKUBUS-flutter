import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skkumap/app/model/mainpage_buslist_model.dart';
import 'package:skkumap/app/model/hssc_buslocation.dart';

Future<List<HSSCBusLocation>> fetchHSSCBusLocation() async {
  const url = 'http://localhost:3000/bus/hssc/v1/buslocation';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    print('hssc bus location fetch');
    return List<HSSCBusLocation>.from(
        l.map((model) => HSSCBusLocation.fromJson(model)));
  } else {
    throw Exception('Failed to load HSSC bus location data');
  }
}
