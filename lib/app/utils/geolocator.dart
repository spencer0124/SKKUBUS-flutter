import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var latitude = ''.obs;
  var longitude = ''.obs;

  Future<void> getCurrentPosition() async {
    // 위치 서비스 활성화 여부 확인
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("위치 서비스가 활성화되어 있지 않습니다.");
      return;
    }

    // 위치 권한 확인 및 요청
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("위치 권한이 거부되었습니다.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("위치 권한이 영구적으로 거부되었습니다.");
      return;
    }

    // 위치 정보 가져오기
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // 위도, 경도 업데이트
    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();
  }
}
