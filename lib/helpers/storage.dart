import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String tokenKey = 'token';
String profileKey = 'profile';

class SecureStorage {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<void> _setData({required String? value, required String key}) async {
    if (value != null) {
      await secureStorage.write(key: key, value: value);
    }
  }

  static Future<String?> _getData({required String key}) async => secureStorage.read(key: key);

  static Future<bool> isAuthenticated() async => await getToken() != null;

  static void setToken(String token) => _setData(key: tokenKey, value: token);

  static Future<String?> getToken() async => _getData(key: tokenKey);

  static Future<String?> getProfile() async => _getData(key: profileKey);

  static void setProfile({required String data}) => _setData(key: profileKey, value: data);
}
