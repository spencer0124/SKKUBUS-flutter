import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'mainpage_controller.dart';

final controller = Get.find<MainpageController>();
int finalIndex = 0; // 아래 Switch-case문에서 사용할 최종 역 차이를 담은 변수

Future<void> calculateRemainingStationsToHyehwaStation() async {
  await dotenv.load(fileName: ".env");
  var baseUrl = Uri.parse(dotenv.env['KingoBusApi']!);
  final response = await http.get(baseUrl);

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    var items = jsonData['items'] as List;

    List<BusData> busDataList =
        items.map((item) => BusData.fromJson(item)).toList();

    int hyehwaStationIndex =
        busDataList.indexWhere((station) => station.stationName == '혜화역(승차장)');

    // '혜화역 정류장' 정보를 찾지 못했을 경우
    if (hyehwaStationIndex == -1) {
      controller.hsscBusMessage.value = '오류 [1]';
      return;
    }

    // '혜화역 정류장' 정보를 찾은 경우
    // 남아있는 정류장 수를 계산
    int closestBusIndex = -1; // -1로 초기화

    for (int i = hyehwaStationIndex; i >= 0; i--) {
      // 혜화역(승차장)부터 정차소(인문.농구장)까지 순서대로 버스가 있는지 찾기
      // carNumber값이 비어있는지로 버스가 있는지 판단

      if (busDataList[i].carNumber.isNotEmpty) {
        // 혜화역 정류장 자체인 경우, 25초 내외인지를 비교하여 '도착 또는 출발'을 표시해줄지, 무시하고 다음 경우를 찾을지 결정
        if (busDataList[i].stationName == '혜화역(승차장)') {
          DateTime now = DateTime.now();
          DateTime eventDateTime = DateTime.parse(busDataList[i].eventDate);
          Duration difference = now.difference(eventDateTime);

          // 25초가 지난 경우 무시하고 다음 경우 찾기
          if (difference.inSeconds > 25) {
            continue;
          }
          // 25초 이내인 경우 당역 도착 표시 보여주기
          else {
            closestBusIndex = 0;
          }
        }

        closestBusIndex = i;
        break;
        // 가장 가까운 정보 1개만 찾고 break하기
      }
    }

// If we found a bus that is en route and not too old, calculate the remaining stations
    if (closestBusIndex != -1) {
      finalIndex = hyehwaStationIndex - closestBusIndex;
    } else {
      controller.hsscBusMessage.value = '정보없음 [1]';
      return;
    }
  } else {
    controller.hsscBusMessage.value = '오류 [2]';
    return;
  }

  switch (finalIndex) {
    case 0:
      controller.hsscBusMessage.value = '도착 또는 출발';
      break;
    case 1:
      controller.hsscBusMessage.value = '1번째 전 (혜화역U턴지점)';
      break;
    case 2:
      controller.hsscBusMessage.value = '2번째 전 (혜화로터리(하차지점))';
      break;
    case 3:
      controller.hsscBusMessage.value = '3번째 전 (정문(인문-하교))';
      break;
    case 4:
      controller.hsscBusMessage.value = '4번째 전 (학생회관(인문))';
      break;
    case 5:
      controller.hsscBusMessage.value = '5번째 전 (정차소(인문.농구장))';
      break;
    default:
      controller.hsscBusMessage.value = '정보없음 [4]';
      break;
  }
}

// 버스 데이터 모델
class BusData {
  String sequence;
  String stationName;
  String eventDate;
  String kind;
  String gpsLongitude;
  String gpsLatitude;
  String useTime;
  String carNumber;

  BusData({
    required this.sequence,
    required this.stationName,
    required this.eventDate,
    required this.kind,
    required this.gpsLongitude,
    required this.gpsLatitude,
    required this.useTime,
    required this.carNumber,
  });

  factory BusData.fromJson(Map<String, dynamic> json) {
    return BusData(
      sequence: json['sequence'] as String? ?? '',
      stationName: json['stationName'] as String? ?? '',
      eventDate: json['eventDate'] as String? ?? '',
      kind: json['kind'] as String? ?? '',
      gpsLongitude: json['gpsLongitude']?.toString() ?? '',
      gpsLatitude: json['gpsLatitude']?.toString() ?? '',
      useTime: json['useTime'] as String? ?? '',
      carNumber: json['carNumber'] as String? ?? '',
    );
  }
}
