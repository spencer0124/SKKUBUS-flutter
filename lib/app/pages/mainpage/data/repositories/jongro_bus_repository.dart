import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:skkumap/app/pages/mainpage/data/models/jongro_bus_model.dart';

/// 기타 예외
class FailedToGetJongroBusListException implements Exception {}

/// 운영시간이 아니여서 정보를 반환하지 않는 경우
class NoJongroBusListException implements Exception {}

/// 종로07 버스의 현재 위치, 번호판, 도착했는지 여부를 확인할 수 있는 api
/// <버스위치정보조회 서비스>
Future<List<JongroBusModel>> getJongroBusList() async {
  // 응답 형태
  // json

  // 응답 예시
  // "posX": "199326.19175136427",
  // "posY": "454260.7792981323",
  // "plainNo": "서울70사5537",
  // "lastStnId": "100900220",
  // "stopFlag": "1", -> 0: 운행중, 1: 도착
  var baseUrl = Uri.parse(dotenv.env['JonroBusHewaLocApi']!);
  final response = await http.get(baseUrl);
  if (response.statusCode != 200) throw FailedToGetJongroBusListException();
  final json = jsonDecode(response.body);
  String headerCd = json['msgHeader']['headerCd'];
  if (headerCd != "0") throw NoJongroBusListException();
  final list = json['msgBody']['itemList'] as List;
  return list.map((e) => JongroBusModel.fromJson(e)).toList();
}
