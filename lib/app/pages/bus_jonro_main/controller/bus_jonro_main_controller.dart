import 'dart:js_interop';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:skkumap/app/pages/LocalAuth/mainpage/controller/hsscbus_controller.dart';
import 'dart:convert';
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';

/*
라이프사이클 감지 -> 화면이 다시 보일 때마다 데이터 갱신
*/
class JonroMainLifeCycle extends GetxController with WidgetsBindingObserver {
  JonroMainController controller = Get.find<JonroMainController>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      controller.fetchJonrobusApi();
    }
  }
}

/*
메인 컨트롤러
*/

class JonroMainController extends GetxController {
  RxBool loading = true.obs;
  final currentTime = ''.obs; // 현재시간
  final activeBusCount = Rx<int?>(null); // 현재 운영중인 버스 대수
  Timer? _updateCurrentTime; // 현재시간을 10초마다 업데이트해주는 타이머
  Timer? _updateBusApi; // 버스 정보를 30초마다 업데이트해주는 타이머

  // 종로07 버스 정류장 이름
  // 19개
  List<String> stationNames = [
    '명륜새마을금고',
    '서울국제고등학교',
    '국민생활관',
    '혜화 초등학교',
    '혜화우체국',
    '혜화역4번출구',
    '혜화역.서울대병원입구',
    '방송통신대앞',
    '이화사거리',
    '방송통신대.이화장',
    '혜화역.마로니에공원',
    '혜화역1번출구',
    '혜화동로터리',
    '성대입구',
    '성균관대 정문',
    '600주년 기념관',
    '성균관대운동장',
    '학생회관',
    '성균관대학교',
  ];

  // 명륜새마일금고(100900197) 1번 -> 19개
  List<int> stationNodeId = [
    100900197,
    100900031,
    100900017,
    100900003,
    100900063,
    100900027,
    100000125,
    100900028,
    100900043,
    100000123,
    100000124,
    100900075,
    100000130,
    100900199,
    100900218,
    100900219,
    100900220,
    100900221,
    100900110,
  ];

  var arrmsg1 = RxList<String>(List.filled(19, '도착 정보 없음'));
  var arrmsg2 = RxList<String>(List.filled(19, '도착 정보 없음'));
  var flag = RxList<int>(List.filled(19, 0));

  @override
  void onInit() async {
    super.onInit();
    updateTime();
    fetchJonrobusApi();
    _startTimer();
  }

  @override
  void onClose() {
    super.onClose();
    _updateCurrentTime?.cancel();
    _updateBusApi?.cancel();
  }

  // 10초마다 현재 시간 업데이트
  void _startTimer() {
    const duration = Duration(seconds: 10);
    _updateCurrentTime = Timer.periodic(duration, (Timer t) => updateTime());

    const duration2 = Duration(seconds: 30);
    _updateBusApi = Timer.periodic(duration2, (Timer t) => fetchJonrobusApi());
  }

  // 실제로 현재 시간을 가져오는 부분
  void updateTime() {
    final format = DateFormat.jm();
    currentTime.value = format.format(DateTime.now());
  }

  // 종로07 정보를 가져오는 api 호출
  Future<void> fetchJonrobusApi() async {
    await dotenv.load(fileName: ".env");

    /*
  종로 07의 도착 정보를 확인할 수 있는 api 호출
  <버스도착정보조회 서비스>

  응답형태
  xml

  응답예시
  (너무 길어서 생략, 문서 참조)
  */

    var baseUrl = Uri.parse(dotenv.env['JonroBusAllApi']!);
    final response = await http.get(baseUrl);

    if (response.statusCode == 200) {
      final document = XmlDocument.parse(response.body);

      var headerCd = document.findAllElements('headerCd').first.text;
      var headerMsg = document.findAllElements('headerMsg').first.text;

      if (headerCd == "0" && headerMsg == "정상적으로 처리되었습니다.") {
        final items = document.findAllElements('itemList');

        int index = 0;
        for (var item in items) {
          String msg1 = item.findAllElements('arrmsg1').first.text;
          String msg2 = item.findAllElements('arrmsg2').first.text;

          print(
              "Index $index: arrmsg1 = $msg1, arrmsg2 = $msg2"); // Debugging print

          arrmsg1[index] = msg1;
          arrmsg2[index] = msg2;

          index++;
        }

        arrmsg1.refresh();
        arrmsg2.refresh();
      } else {
        // controller.jongro07BusMessage.value = "정보 없음 [3]";
        // print('error 1');
        return;
      }
    } else {
      // controller.jongro07BusMessage.value = "정보 없음 [4]";
      // print('error 2');
      return;
    }

    var baseUrl2 = Uri.parse(dotenv.env['JonroBusHewaLocApi']!);
    final response2 = await http.get(baseUrl2);

    if (response2.statusCode == 200) {
      var jsonResponse = jsonDecode(response2.body);

      String headerMsg = jsonResponse['msgHeader']['headerMsg'];
      String headerCd = jsonResponse['msgHeader']['headerCd'];

      if (headerMsg == "정상적으로 처리되었습니다." && headerCd == "0") {
        List<dynamic> itemList = jsonResponse['msgBody']['itemList'];
        controller.fetchBusMap(itemList);

        int count = 0;

        for (var item in itemList) {
          count++;
          String stopFlag = item['stopFlag'];
          // String posX = item['posX'];
          // String posY = item['posY'];
          // String plainNo = item['plainNo'];
          String lastStnId = item['lastStnId'];

          int index = stationNodeId.indexWhere((id) => id == lastStnId);
          if (stopFlag == "1") {
            flag[index] = 2;
          } else if (index != -1) {
            flag[index] = 1;
          } else {
            flag[index] = 0;
          }

          activeBusCount.value = count;
        }
        print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=');
        print(flag);
        print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=');
      } else {
        // 기타 예외 처리
        // controller.jongro07BusMessage.value = "정보 없음 [2]";
        return;
      }
    }
  }
}
