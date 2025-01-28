import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:srhealthcare/model/login_user_model.dart';

class LoginApiService {
  static const String _baseUrl = "https://backend.srhealthcarecommunity.com/api/mobile_login";

   Future<(String? error, LoginModelClass?)?> login(String email, String password) async {
    final url = Uri.parse("${_baseUrl}mobile_login");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      log("Login Response:: ${response.body}");
      final rawJson = jsonDecode(response.body);

      final error = rawJson['error'];
      final message = rawJson['message'];

      if (response.statusCode == 200 && (error is bool && error == false)) {
        try {
          final data = LoginModelClass.fromJson(jsonDecode(response.body));
          return (null, data);
        } catch (e) {
          return ("$e", null);
        }
      } else {
        return (message.toString(), null);
      }
    } catch (e) {
      return ("$e", null);
    }
  }
}
