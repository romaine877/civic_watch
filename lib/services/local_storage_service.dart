import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final _prefs = SharedPreferences.getInstance();

  Future<void> saveData(LSKey key, dynamic value) async {
    final prefs = await _prefs;
    if (value is String) {
      await prefs.setString(key.name, value);
    } else if (value is int) {
      await prefs.setInt(key.name, value);
    } else if (value is double) {
      await prefs.setDouble(key.name, value);
    } else if (value is bool) {
      await prefs.setBool(key.name, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key.name, value);
    }
  }

  Future<String?> getString(LSKey key) async {
    final prefs = await _prefs;
    return prefs.getString(key.name);
  }

  Future<int?> getInt(LSKey key) async {
    final prefs = await _prefs;
    return prefs.getInt(key.name);
  }


  Future<double?> getDouble(LSKey key) async {
    final prefs = await _prefs;
    return prefs.getDouble(key.name);
  }

  Future<bool?> getBool(LSKey key) async {
    final prefs = await _prefs;
    return prefs.getBool(key.name);
  }

  Future<List<String>?> getStringList(LSKey key) async {
    final prefs = await _prefs;
    return prefs.getStringList(key.name);
  }
}

enum LSKey{
  themeMode,
  firstLogin,
  language,
}