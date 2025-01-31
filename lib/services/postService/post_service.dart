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

  Future<(String? error, List<PostListModel>?)> fetchPosts({
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
    required int currentPage,
    required int noOfRec,
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
        'currentpage': currentPage,
        'noofrec': noOfRec,
      };

      log("Bearer Token: $bearerToken");

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
      log("Response: ${response.body}");

      if (response.statusCode == 200) {
        /// ✅ Extract the list of posts from `data`
        List<PostListModel> posts = (rawJson['data'] as List?)
            ?.map((item) => PostListModel.fromJson(item))
            .toList() ?? [];

        return (null, posts); // ✅ Return list of `PostListModel`
      } else {
        return (message.toString(), null);
      }
    } catch (e) {
      return ('$e', null);
    }
  }

Future<List<String>> fetchPostTypeList() async {
  final token = SharedPreferenceHelper().getAccessToken();
  final url = Uri.parse(
      'https://backend.srhealthcarecommunity.com/api/master/post_type_list');

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      log(response.body);

      // Fetch post types from response and return as a list of strings
      final postTypes = (jsonResponse['post_type_list'] as List)
          .map((e) => e['name'] as String)
          .toSet()
          .toList(); // Remove duplicates if any
      return postTypes;
    } else {
      final errorResponse = jsonDecode(response.body);
      log(errorResponse['message'] ?? 'Unknown error');
    }
  } catch (e) {
    log('Error fetching post types: $e');
  }
  return [];
}
}
