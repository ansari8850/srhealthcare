import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:srhealthcare/model/login_user_model.dart';

class LoginApiService {
  static const String _baseUrl = "https://backend.srhealthcarecommunity.com/api/";

  Future<(String? error, LoginResModel?)?> login(String email, String password) async {
    final url = Uri.parse("${_baseUrl}mobile_login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      log("Login Response:: ${response.body}");

      if (response.statusCode == 200) {
        try {
          final rawJson = jsonDecode(response.body);
          final data = LoginResModel.fromJson(rawJson);

          // Check for errors in the JSON response (more robust)
          if (rawJson.containsKey('errors') && rawJson['errors'] != false) {
            // Errors exist (handle them appropriately)
            final errorMessage = rawJson['message'] ?? "Login failed"; // Get message or default
            return (errorMessage.toString(), null);
          }
          return (null, data); // Success!
        } catch (e) {
          return ("Error parsing JSON: $e", null); // JSON parsing error
        }
      } else {
        // HTTP error (e.g., 400, 500)
        return ("HTTP Error: ${response.statusCode}", null);
      }
    } catch (e) {
      return ("Network Error: $e", null); // Network or other error
    }
  }
}