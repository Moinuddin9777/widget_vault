// To parse this JSON data, do
//
//     final postsResponse = postsResponseFromJson(jsonString);

import 'dart:convert';

PostsResponse postsResponseFromJson(String str) =>
    PostsResponse.fromJson(json.decode(str));

String postsResponseToJson(PostsResponse data) => json.encode(data.toJson());

class PostsResponse {
  bool? success;
  String? message;
  List<Post>? posts;

  PostsResponse({
    this.success,
    this.message,
    this.posts,
  });

  factory PostsResponse.fromJson(Map<String, dynamic> json) => PostsResponse(
        success: json["success"],
        message: json["message"],
        posts: json["posts"] == null
            ? []
            : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "posts": posts == null
            ? []
            : List<dynamic>.from(posts!.map((x) => x.toJson())),
      };
}

// entity
class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
