// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:skkumap/app/data/model/bus_data_detail_model.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class BusDetailDataProvider {
//   final String url = dotenv.env['BusDetailAPi']!;

//   Future<BusDetail> getBusDetail() async {
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       //print('Response data: ${response.body}'); // Add this line
//       return BusDetail.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load bus info');
//     }
//   }
// }
