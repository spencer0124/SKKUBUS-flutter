import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skkumap/app/model/search_option3_model.dart';

Future<SearchOption3Model> searchOption3(String queryString) async {
  String encodedQuery = Uri.encodeComponent(queryString);
  print("encodedQuery: $encodedQuery");
  String url = 'http://localhost:3000/search/option3/$encodedQuery';
  // String url = 'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/mobile/v1/mainpage/buslist/$encodedQuery';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // print(response.body);
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(SearchOption3Model.fromJson(json.decode(response.body)));
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return SearchOption3Model.fromJson(json.decode(response.body));
  } else {
    // Handle errors
    throw Exception('Failed to load data');
  }
}
