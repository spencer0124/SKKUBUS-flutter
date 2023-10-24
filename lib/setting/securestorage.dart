import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  final storage = const FlutterSecureStorage();
  var storedValue = ''.obs; // Observable variable to hold the value

  Future<void> writeValue(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String> readValue(String key) async {
    String value = await storage.read(key: key) ?? 'null';
    return value;
  }

  Future<void> deleteallValue() async {
    await storage.deleteAll();
  }
}
