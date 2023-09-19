import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static late SharedPreferences sharedPref;
  //function to initialize the class
  static init() async {
    sharedPref = await SharedPreferences.getInstance();
  }
//function to save data
  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) {
    if (value is bool) {
      return sharedPref.setBool(key, value);
    } else if (value is String) {
      return sharedPref.setString(key, value);
    } else if (value is int) {
      return sharedPref.setInt(key, value);
    } else if (value is double) {
      return sharedPref.setDouble(key, value);
    } else {
      return sharedPref.setStringList(key, value);
    }
  }
  //function to get string data

  static String? getString({required String key}) {
    return sharedPref.getString(key);
  }
  //function to get boolean data
  static bool? getBool({required String key}) {
    return sharedPref.getBool(key);
  }
  //function to delete  data
 static Future<bool> remove({required String key}) {
   return sharedPref.remove(key);
  }
}
