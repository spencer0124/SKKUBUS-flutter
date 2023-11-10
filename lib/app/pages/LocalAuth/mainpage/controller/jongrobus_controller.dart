import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml/xml.dart';
import 'package:get/get.dart';
import 'mainpage_controller.dart';

final controller = Get.find<MainpageController>();
Future<void> calculateRemainingStationsToHyehwaStation2() async {
  await dotenv.load(fileName: ".env");
  var baseUrl2 = Uri.parse(dotenv.env['JonroBusHewaLocApi']!);
  final response2 = await http.get(baseUrl2);

  if (response2.statusCode == 200) {
    // 예외 처리 (버스 없는 경우 해야함)
    print('response2');
    var jsonResponse = jsonDecode(response2.body);
    print(jsonResponse);
    print('---');
    List<dynamic> itemList = jsonResponse['msgBody']['itemList'];

    for (var item in itemList) {
      String stopFlag = item['stopFlag'];
      String posX = item['posX'];
      String posY = item['posY'];
      String plainNo = item['plainNo'];
      String lastStnId = item['lastStnId'];

      // Now you have the data for each item, you can process it as needed
      print(
          'Bus $plainNo at position ($posX, $posY) with stop flag $stopFlag is heading to station ID $lastStnId');
    }
  } else {
    // Handle the case where the API call was not successful
    print('Failed to load data');
  }

  var baseUrl = Uri.parse(dotenv.env['JonroBusHewaApi']!);
  final response = await http.get(baseUrl);

  if (response.statusCode == 200) {
    final document = XmlDocument.parse(response.body);
    final arrmsg1 = document.findAllElements('arrmsg1').first.text;

    // Check if the message is '출발대기'

    // Use a RegExp to extract the time and remaining stations
    final RegExp regExp = RegExp(r'(\d+)분(\d+)초후\[(\d+)번째 전\]');
    final match = regExp.firstMatch(arrmsg1);

    if (match != null) {
      controller.jongro07BusRemainTimeMin.value = int.parse(match.group(1)!);
      controller.jongro07BusRemainTimeSec.value = int.parse(match.group(2)!);
      controller.jongro07BusRemainStation.value = int.parse(match.group(3)!);
    } else {
      controller.jongro07BusMessage.value = arrmsg1;
      // Set to -2 if arrmsg1 is not '출발대기' and doesn't match the time pattern
      controller.jongro07BusRemainTimeMin.value = -2;
      controller.jongro07BusRemainTimeSec.value = -2;
      controller.jongro07BusRemainStation.value = -2;
    }
  } else {
    throw Exception('Failed to load bus data');
  }
}
