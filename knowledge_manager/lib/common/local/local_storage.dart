
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static save(String key, value) async {
    // 获取本地缓存
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 存储
    prefs.setString(key, value);
  }

  static get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}