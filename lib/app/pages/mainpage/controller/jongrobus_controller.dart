import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:skkumap/app/pages/mainpage/data/repositories/jongro_bus_repository.dart';
import 'package:xml/xml.dart';

import 'mainpage_controller.dart';

/*
mainpage에서 사용되는 종로07 버스와 관련된 api를 호출하는 controller
 */

bool isHewaStation = false;
bool totalisHewaStation = false;
DateTime isHewaStationUpdateTime = DateTime.now();
// 혜화역 정류장에 도착한 경우 '당역 도착'이라고 설정해줘야하므로 bool값 담는 변수 설정
/*
stopflag가 생각보다 부정확하다! 어떻게 '도착 혹은 출발'을 표시해줄지 고민
-> 20초 후면 이동한걸로 판단하자
 */

Future<void> calculateRemainingStationsToHyehwaStation2() async {
  final controller = Get.find<MainpageController>();
  // controller.jongro07BusMessage.value = "";
  // controller.jonro07BusMessageVisible.value = false;
  // controller.jongro07BusMessage.value = "";
  isHewaStation = false;
  controller.jonroLoadingDone.value = false;

  try {
    final list = await getJongroBusList();
    controller.fetchBusMap(list);

    for (var bus in list) {
      if (bus.isLastStation && totalisHewaStation == false) {
        isHewaStation = true;
        isHewaStationUpdateTime = DateTime.now();
        totalisHewaStation = true;
      }
    }
  } on FailedToGetJongroBusListException {
    controller.fetchBusMap([]);
    controller.jongro07BusMessage.value = "정보 없음 [2]";
    controller.jonro07BusMessageVisible.value = true;
    controller.jonroLoadingDone.value = true;
  } on NoJongroBusListException {
    controller.fetchBusMap([]);
    controller.jongro07BusMessage.value = "정보 없음 [1]";
    controller.jonro07BusMessageVisible.value = true;
    controller.jonroLoadingDone.value = true;
  }

  /*
  종로 07의 도착 정보를 확인할 수 있는 두번째 api 호출
  <버스도착정보조회 서비스>

  응답형태
  xml

  응답예시
  (너무 길어서 생략, 문서 참조)
  */

  var baseUrl = Uri.parse(dotenv.env['JonroBusHewaApi']!);
  final response = await http.get(baseUrl);

  if (response.statusCode == 200) {
    final document = XmlDocument.parse(response.body);

    var headerCd = document.findAllElements('headerCd').first.text;
    var headerMsg = document.findAllElements('headerMsg').first.text;

    if (headerCd == "0" && headerMsg == "정상적으로 처리되었습니다.") {
      final arrmsg1 = document.findAllElements('arrmsg1').first.text;

      // Check if the message is '출발대기'

      // Use a RegExp to extract the time and remaining stations
      final RegExp regExptypeA = RegExp(r'(\d+)분(\d+)초후\[(\d+)번째 전\]');
      final RegExp regExptypeB = RegExp(r'(\d+)분후\[(\d+)번째 전\]');
      final matchTypeA = regExptypeA.firstMatch(arrmsg1);
      final matchTypeB = regExptypeB.firstMatch(arrmsg1);

      var duration = 100;
      var currentTime = DateTime.now();
      if (isHewaStation) {
        duration = currentTime.difference(isHewaStationUpdateTime).inSeconds;
      }

      print('duration: $duration');
      print('isHewaStation: $isHewaStation');
      // 메세지가 주어진 형식과 일치하는 경우

      if (!(isHewaStation && duration.abs() < 20)) {
        totalisHewaStation = false;
      }

      if (isHewaStation && duration.abs() < 20 && totalisHewaStation == true) {
        controller.jongro07BusMessage.value = '도착 또는 출발';
        controller.jonro07BusMessageVisible.value = true;
      } else if (matchTypeA != null) {
        controller.jongro07BusRemainTimeMin.value =
            int.parse(matchTypeA.group(1)!);
        controller.jongro07BusRemainTimeSec.value =
            int.parse(matchTypeA.group(2)!);
        controller.jongro07BusRemainStation.value =
            int.parse(matchTypeA.group(3)!);
        controller.jongro07BusRemainTotalTimeSec.value =
            controller.jongro07BusRemainTimeMin.value * 60 +
                controller.jongro07BusRemainTimeSec.value;
      } else if (matchTypeB != null) {
        controller.jongro07BusRemainTimeMin.value =
            int.parse(matchTypeB.group(1)!);
        controller.jongro07BusRemainTimeSec.value = 0;
        controller.jongro07BusRemainStation.value =
            int.parse(matchTypeB.group(2)!);
        controller.jongro07BusRemainTotalTimeSec.value =
            controller.jongro07BusRemainTimeMin.value * 60;
      } else {
        // 메세지가 주어진 형식과 일치하지 않는 경우. 이 경우 msg자체를 변수에 저장
        controller.jongro07BusMessage.value = arrmsg1;
        controller.jonro07BusMessageVisible.value = true;
      }
    } else {
      controller.jongro07BusMessage.value = "정보 없음 [3]";
      controller.jonro07BusMessageVisible.value = true;
      return;
    }
  } else {
    controller.jongro07BusMessage.value = "정보 없음 [4]";
    controller.jonro07BusMessageVisible.value = true;
    return;
  }

  controller.jonroLoadingDone.value = true;
}
