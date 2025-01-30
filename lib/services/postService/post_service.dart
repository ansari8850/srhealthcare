import 'dart:convert';
import 'dart:developer';

import 'package:srhealthcare/model/post_model.dart';
import 'package:srhealthcare/services/sharedprefrence_helper.dart';
import 'package:http/http.dart' as http;

class PostService {
  final String tokken = SharedPreferenceHelper().getAccessToken().toString();

  static const String apiUrl =
      'https://backend.srhealthcarecommunity.com/api/post/list';

  late final String bearerToken;

  PostService() {
    bearerToken = 'Bearer $tokken';
  }
  Future<(String? error, PostModel?)> fetchPosts({
    String search = '',
    String customDate = '',
    String fromDate = '',
    String toDate = '',
    String type = '',
    String fieldId = '',
    String postType = '',
    String location = '',
    String date = '',
    String status = '',
   required int currentPage , // New parameter for pagination
   required int noOfRec , // New parameter for pagination
  }) async {
    try {
      final body = {
        'search': search,
        'custom_date': customDate,
        'fromDate': fromDate,
        'toDate': toDate,
        'type': type,
        'field_id': fieldId,
        'post_type': postType,
        'location': location,
        'date': date,
        'status': status,
        'currentpage': currentPage, // Added for pagination
        'noofrec': noOfRec, // Added for pagination
      };
      print(bearerToken);
      print('bearerToken');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': bearerToken,
        },
        body: json.encode(body),
      );
      final rawJson = jsonDecode(response.body);
      final message = rawJson['message'];
      log(response.body);

      if (response.statusCode == 200) {
        final data = PostModel.fromJson(json.decode(response.body));
        return (null, data);
      } else {
        return (message.toString(), null);
      }
    } catch (e) {
      return ('$e', null);
    }
  }
}