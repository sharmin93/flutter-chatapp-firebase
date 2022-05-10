import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _singleton =
      SharedPreferencesService.instance;

  static SharedPreferencesService get instance => _singleton;
  late Future<SharedPreferences> _prefs;

  create() {
    _prefs = SharedPreferences.getInstance();
  }

  void setString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  Future<String> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? "";
  }

  void clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
