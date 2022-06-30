import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _apiKeyKey = "a";

class ApiKey {
  static String? key;

  static Future<void> loadStorage(FlutterSecureStorage storage) async {
    key = await storage.read(key: _apiKeyKey);
  }
}
