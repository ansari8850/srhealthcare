import 'package:shared_preferences/shared_preferences.dart';

class SharedprefrenceHelper {
  static final SharedprefrenceHelper _instance = SharedprefrenceHelper._instance;
  SharedPreferences? _prefs;
  factory SharedprefrenceHelper()=> _instance;
}