import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;

  static const String kuserData = 'userData';
  static const String kwishList = 'wishList';

  static const String konboardingSeen = 'onboardingSeen';

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setOnboardingsSeen() async {
   await pref.setBool(konboardingSeen, true);
  }

  static bool isOnboardingsSeen() {
    return pref.getBool(konboardingSeen)?? false;
  }

  static void saveData(String key, dynamic value) {
    if (value is int) {
      pref.setInt(key, value);
    } else if (value is String) {
      pref.setString(key, value);
    } else if (value is bool) {
      pref.setBool(key, value);
    } else if (value is double) {
      pref.setDouble(key, value);
    } else if (value is List<String>) {
      pref.setStringList(key, value);
    }
  }

}
