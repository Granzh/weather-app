import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  Future<void> saveData(String key, dynamic value) async {
    final prefs =  await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<dynamic> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
