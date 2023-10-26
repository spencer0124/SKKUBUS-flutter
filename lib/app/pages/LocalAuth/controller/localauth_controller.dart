import 'package:get/get.dart';

import 'package:local_auth/local_auth.dart';

import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class LocalAuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();

  RxBool didAuthenticate = false.obs;
  RxString msg = 'default'.obs;

  Future<void> authfunction() async {
    final bool isDeviceSupported = await auth.isDeviceSupported();
    final bool canCheckBiometrics = await auth.canCheckBiometrics;

    if (!isDeviceSupported) {
      // 디바이스 자체가 지원이 안되는 경우
      msg.value = 'Device not supported';
      didAuthenticate.value = false;

      await FlutterPlatformAlert.showAlert(
        windowTitle: '설정에 실패했어요',
        text: '에러코드: Device not supported',
        alertStyle: AlertButtonStyle.ok,
      );
    }

    if (isDeviceSupported && !canCheckBiometrics) {
      // 디바이스는 지원이 되지만, 생체인식을 지원하지 않는 경우
      msg.value = 'cannott CheckBiometrics';
      try {
        didAuthenticate.value = await auth.authenticate(
            localizedReason: '본인 인증을 진행해주세요',
            options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: false,
            ));
        if (didAuthenticate.value) {
          saveAuthfunction();
        }
      } catch (e) {
        msg.value = '${e}hi0';
        didAuthenticate.value = false;
        await FlutterPlatformAlert.showAlert(
          windowTitle: '설정에 실패했어요',
          text: '에러코드: $e',
          alertStyle: AlertButtonStyle.ok,
        );
      }
    } else if (isDeviceSupported && canCheckBiometrics) {
      // 디바이스도 지원하고, 생체인식도 지원하는 경우
      msg.value = 'canCheckBiometrics';
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (availableBiometrics.isEmpty) {
        // 디바이스도 지원하고, 생체인식도 지원하지만 생체인식을 등록하지 않은 경우
        try {
          didAuthenticate.value = await auth.authenticate(
              localizedReason: '본인 인증을 진행해주세요',
              options: const AuthenticationOptions(
                stickyAuth: true,
                biometricOnly: false,
              ));
          if (didAuthenticate.value) {
            saveAuthfunction();
          }
        } catch (e) {
          msg.value = '${e}hi';
          didAuthenticate.value = false;
          await FlutterPlatformAlert.showAlert(
            windowTitle: '설정에 실패했어요',
            text: '에러코드: $e',
            alertStyle: AlertButtonStyle.ok,
          );
        }
      } else {
        // 디바이스도 지원하고, 생체인식도 지원하고, 생체인식을 등록한 경우
        try {
          didAuthenticate.value = await auth.authenticate(
              localizedReason: '본인 인증을 진행해주세요',
              options: const AuthenticationOptions(
                stickyAuth: true,
                // biometricOnly: true,
              ));
          if (didAuthenticate.value) {
            saveAuthfunction();
          }
        } catch (e) {
          msg.value = '${e}hi2';
          didAuthenticate.value = false;
          await FlutterPlatformAlert.showAlert(
            windowTitle: '설정에 실패했어요',
            text: '에러코드: $e',
            alertStyle: AlertButtonStyle.ok,
          );
        }
      }
    }
  }

  Future<void> saveAuthfunction() async {
    // await storageController.writeValue(
    //     'didAuthenticate', didAuthenticate.value.toString());
    // await storageController.writeValue('didinitial', 'true');
    // await Future.delayed(const Duration(seconds: 1));

    // Get.toNamed('/mainpage');
  }

  Future<void> saveLaterfunction() async {
    // await storageController.writeValue('didAuthenticate', 'false');
    // await storageController.writeValue('didinitial', 'true');
    // Get.toNamed('/mainpage');
  }
}
