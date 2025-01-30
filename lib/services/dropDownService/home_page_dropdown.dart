import 'dart:convert';
import 'dart:developer';

import 'package:srhealthcare/model/filed_response_model.dart';
import 'package:srhealthcare/services/sharedprefrence_helper.dart';
import 'package:http/http.dart' as http;

class HomePageDropdown {
  Future<FiledResponseModel?> fethInitialData(
    String type,
  ) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final url = Uri.parse(
 "https://backend.srhealthcarecommunity.com/api/master/list?fy=2024&noofrec=10&currentpage=1&type=$type", 
   );
    
    String message = '';
    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          );
      final jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200 ) {
        final data = FiledResponseModel.fromJson(jsonResponse);

        return data;
      } else {
        log('Failded to load ${response.body}');
        message = jsonResponse['message'];
      }
    } catch (e) {
      log("$e");
      message = e.toString();
    }
    return (null);
  }
}