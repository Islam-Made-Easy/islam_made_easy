import 'package:shared_preferences/shared_preferences.dart';

class SharedP {
  static SharedPreferences _sp;
  SharedP._internal();
  static final SharedP _appSP = SharedP._internal();
  int getInt(String key) => _sp.getInt(key);
  Future<bool> setInt(String key, int value) => _sp.setInt(key, value);
  String getString(String key) => _sp.getString(key);
  Future<bool> setString(String key, String value) => _sp.setString(key, value);
  factory SharedP() => _appSP;
  Future<void> init() async {
    if (_sp == null) _sp = await SharedPreferences.getInstance();
  }
}
SharedP appSP = SharedP();
