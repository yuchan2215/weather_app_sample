import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app_sample/constant/storage_keys.dart';
import 'package:weather_app_sample/core/secure_storage.dart';

class ApiKey {
  static String? key;

  static Future<void> loadStorage(
      {FlutterSecureStorage storage = SecureStorage.storage}) async {
    key = await storage.read(key: apiKeyStorageKey);
  }

  static Future<void> saveStorage(String? apiKey,
      {FlutterSecureStorage storage = SecureStorage.storage}) async {
    key = apiKey;
    await storage.write(key: apiKeyStorageKey, value: apiKey);
  }
}
