// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:widget_vault/core/app_constants.dart';
import 'package:widget_vault/models/responses/posts_response.dart';

class PracticeServices {
  // globally we'll define api url
  // write a future method assign reponse model to it
  // save the data

  static Future<dynamic> fetchPosts() async {
    // dio instance
    final dio = Dio();

    // here is our request
    try {
      final response = await dio.get("${AppConstants.API_URL}/posts");
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return data;
      } else {
        throw Exception("API CALL HAS FAILED");
      }
    } on DioException catch (error) {
      print("++++++++++++++++++++++++");
      print(error.message);
      print("++++++++++++++++++++++++");
      return null;
    }
  }

  static Future<PostsResponse> fetchPostsData() async {
    // dio instance
    final dio = Dio();

    // here is our request
    try {
      final response = await dio.get("${AppConstants.API_URL}/posts");
      if (response.statusCode == 200) {
        final data = response.data;
        print("++++++++++ JSON DATA +++++++++++++++");
        print(data);
        print("++++++++++++++++++++++++++++++++");
        final List<Post> modelData =
            List<Post>.from(response.data.map((x) => Post.fromJson(x)));
        // return PostsResponse(
        //     success: true, message: "Success", posts: modelData);
        return data;
      } else {
        throw Exception("API CALL HAS FAILED");
      }
    } on DioException catch (error) {
      print("++++++++++++++++++++++++");
      print(error.message);
      print("++++++++++++++++++++++++");
      return PostsResponse(success: false, message: error.message);
    }
  }
}
