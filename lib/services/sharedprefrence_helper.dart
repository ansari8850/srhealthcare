import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srhealthcare/model/login_user_model.dart';

class SharedPreferenceHelper {
  static SharedPreferenceHelper? _instance; // Make _instance nullable

  SharedPreferenceHelper._internal(); // Private constructor

  factory SharedPreferenceHelper() {
    return _instance ??= SharedPreferenceHelper._internal(); // Initialize only once
  }

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String _accessTokenKey = "access_tokken";
  static const String _userData = "user_data";
  static const String onBoardingView = "onboarding_view";

  Future<void> saveLoginData(String accessToken, UserModel userData) async {
    await _prefs!.setString(_accessTokenKey, accessToken);
    await _prefs!.setString(_userData, jsonEncode(userData.toJson()));
  }

  String? getAccessToken() { // Corrected typo: getAccessTokken to getAccessToken
    return _prefs?.getString(_accessTokenKey); // Use null-aware operator
  }

  Future<void> saveOnBoardingView() async {
    await _prefs!.setBool(onBoardingView, true);
  }

  bool getOnBoardingView() {
    return _prefs?.getBool(onBoardingView) ?? false; // Use null-aware operator
  }

  UserModel? getUserData() {
    final userDataString = _prefs?.getString(_userData); // Get the string first
    return userDataString != null
        ? UserModel.fromJson(jsonDecode(userDataString))
        : null;
  }

  Future<void> clearUserData() async {
    await _prefs?.remove(_accessTokenKey); // Use null-aware operator
    await _prefs?.remove(_userData); // Use null-aware operator
  }
}