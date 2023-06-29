import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:skkumap/app/data/model/bus_data_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var baseUrl = Uri.parse(dotenv.env['KingoBusApi']!);

// var baseUrl = Uri.parse(dotenv.env['KingoBusApiTest']!);

class BusDataProvider {
  Future<List<BusData>> fetchBusData() async {
    final response = await http.get(baseUrl);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var items = jsonData['items'] as List;
      return items.map((busData) => BusData.fromJson(busData)).toList();
    } else {
      throw Exception('Failed to load bus data');
    }
  }
}
