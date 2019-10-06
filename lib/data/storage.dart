import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  Future<bool> saveThemePreference(bool isDark) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.setBool('darkTheme', isDark);
  }

  Future<dynamic> getData(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.get(key);
  }

}
