// import 'package:get/get.dart';
// import 'package:skkumap/app/pages/homepage/data/repositories/jongro_bus_repository.dart';

// import 'mainpage_controller.dart';

// /*
// mainpage에서 사용되는 종로07 버스와 관련된 api를 호출하는 controller
//  */

// bool isHewaStation = false;
// bool totalisHewaStation = false;
// DateTime isHewaStationUpdateTime = DateTime.now();
// // 혜화역 정류장에 도착한 경우 '당역 도착'이라고 설정해줘야하므로 bool값 담는 변수 설정
// /*
// stopflag가 생각보다 부정확하다! 어떻게 '도착 혹은 출발'을 표시해줄지 고민
// -> 20초 후면 이동한걸로 판단하자
//  */

// Future<void> calculateRemainingStationsToHyehwaStation2() async {
//   final controller = Get.find<MainpageController>();
//   // controller.jongro07BusMessage.value = "";
//   // controller.jonro07BusMessageVisible.value = false;
//   // controller.jongro07BusMessage.value = "";
//   isHewaStation = false;
//   controller.jonroLoadingDone.value = false;

//   try {
//     final list = await getJongroBusList();
//     controller.fetchBusMap(list);

//     for (var bus in list) {
//       if (bus.isLastStation && totalisHewaStation == false) {
//         isHewaStation = true;
//         isHewaStationUpdateTime = DateTime.now();
//         totalisHewaStation = true;
//       }
//     }
//   } on FailedToGetJongroBusListException {
//     controller.fetchBusMap([]);
//     controller.jongro07BusMessage.value = "정보 없음 [2]";
//     controller.jonro07BusMessageVisible.value = true;
//     controller.jonroLoadingDone.value = true;
//     return;
//   } on NoJongroBusListException {
//     controller.fetchBusMap([]);
//     controller.jongro07BusMessage.value = "정보 없음 [1]";
//     controller.jonro07BusMessageVisible.value = true;
//     controller.jonroLoadingDone.value = true;
//     return;
//   }

//   try {
//     final [hewa] = await getJongroBusArrivalList(true);
//     final arrival = hewa.arrivals.first;

//     var duration = 100;
//     var currentTime = DateTime.now();
//     if (isHewaStation) {
//       duration = currentTime.difference(isHewaStationUpdateTime).inSeconds;
//     }

//     // 메세지가 주어진 형식과 일치하는 경우

//     if (!(isHewaStation && duration.abs() < 20)) {
//       totalisHewaStation = false;
//     }

//     if (isHewaStation && duration.abs() < 20 && totalisHewaStation == true) {
//       controller.jongro07BusMessage.value = '도착 또는 출발';
//       controller.jonro07BusMessageVisible.value = true;
//     } else if (arrival.duration != Duration.zero) {
//       controller.jongro07BusRemainTimeMin.value =
//           arrival.duration.inMinutes % 60;
//       controller.jongro07BusRemainTimeSec.value =
//           arrival.duration.inSeconds % 60;
//       controller.jongro07BusRemainStation.value = arrival.left;
//       controller.jongro07BusRemainTotalTimeSec.value =
//           controller.jongro07BusRemainTimeMin.value * 60 +
//               controller.jongro07BusRemainTimeSec.value;
//     } else {
//       // 메세지가 주어진 형식과 일치하지 않는 경우. 이 경우 msg자체를 변수에 저장
//       controller.jongro07BusMessage.value = arrival.message;
//       controller.jonro07BusMessageVisible.value = true;
//     }
//   } on FailedToGetJongroBusListException {
//     controller.jongro07BusMessage.value = "정보 없음 [4]";
//     controller.jonro07BusMessageVisible.value = true;
//     return;
//   } on NoJongroBusListException {
//     controller.jongro07BusMessage.value = "정보 없음 [3]";
//     controller.jonro07BusMessageVisible.value = true;
//     return;
//   }
//   controller.jonroLoadingDone.value = true;
// }
