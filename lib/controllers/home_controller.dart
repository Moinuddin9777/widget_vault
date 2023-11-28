import 'package:get/get.dart';
import 'package:widget_vault/models/responses/posts_response.dart';
import 'package:widget_vault/placeholder_data.dart';
import 'package:widget_vault/services/practice_services.dart';

// Controllers are meant to serve business logic

enum PostsLoadingState { loading, loaded, cantLoad }

class HomeController extends GetxController {
  PostsLoadingState postsLoadingState = PostsLoadingState.loading;
  List<String> namesList = ourState;
  List<Post> postsData = <Post>[];

  addNameToList(String name) {
    ourState.add(name);
    update();
  }

  Future<PostsResponse> fetchPosts() async {
    postsLoadingState = PostsLoadingState.loading;
    update();
    final PostsResponse response = await PracticeServices.fetchPostsData();
    if (response.posts != null) {
      postsData.addAll(response.posts!);
      update();
    }
    postsLoadingState = PostsLoadingState.loaded;
    update();
    return response;
  }
}
