import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  SharedPreferences _sharedPreferences;

  Future<bool> setData(String key, value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    print("saving this value $value into local prefrence with key $key");
    Future returnedValue;
    if (value is String) {
      returnedValue = _sharedPreferences.setString(key, value);
    } else if (value is int) {
      returnedValue = _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      returnedValue = _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      returnedValue = _sharedPreferences.setDouble(key, value);
    } else {
      return Future.error(NotValidCacheTypeException());
    }
    return returnedValue;
  }

  Future<bool> getBoolean(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(_sharedPreferences.getBool(key) ?? false);
  }

  Future<double> getDouble(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(_sharedPreferences.getDouble(key) ?? 0.0);
  }

  Future<int> getInteger(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(_sharedPreferences.getInt(key) ?? 0);
  }

  Future<String> getString(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(_sharedPreferences.getString(key) ?? "");
  }

  removeKey(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.remove(key);
  }

  logout() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.remove('token');
  }
}

class NotValidCacheTypeException implements Exception {
  String message() => "Not a valid cahing type";
}
