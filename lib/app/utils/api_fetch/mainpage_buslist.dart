import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skkumap/app/model/mainpage_buslist_model.dart';
import 'package:skkumap/app/model/station_model.dart';
import 'package:skkumap/app/utils/api_fetch/mainpage_buslist.dart';

Future<MainPageBusListResponse> fetchMainpageBusList() async {
  const url = 'http://localhost:3000/mobile/v1/mainpage/buslist';
  // const url =
  //     'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/mobile/v1/mainpage/buslist';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print(response.body);
    return MainPageBusListResponse.fromJson(json.decode(response.body));
  } else {
    // Handle errors
    throw Exception('Failed to load mainpage buslist data');
  }
}
