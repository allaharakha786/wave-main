import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> reload() async {
    _preferences.reload();
  }

  static containKey(String key) {
    return _preferences.containsKey(key);
  }

  static setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  static String getString(String key) {
    return _preferences.getString(key) ?? "";
  }

  static setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  static bool getBool(String key) {
    return _preferences.getBool(key) ?? false;
  }

  static removeKey(String key) {
    return _preferences.remove(key);
  }

  // Add clearAll method to clear all stored preferences
  static Future<void> clearAll() async {
    await _preferences.clear();
    log("All preferences cleared");
  }

  String escapeJsonString(String input) {
    // Replace newline and carriage return characters with a space
    return input.replaceAll(RegExp(r'[\r\n]', unicode: true), ' ');
  }
}
