import 'package:get/get.dart';
import 'package:widget_vault/models/responses/posts_response.dart';
import 'package:widget_vault/placeholder_data.dart';
import 'package:widget_vault/services/practice_services.dart';

// Controllers are meant to serve business logic

enum PostsLoadingState { loading, loaded, cantLoad }

class HomeController extends GetxController {
  PostsLoadingState postsLoadingState = PostsLoadingState.loading;
  // List<String> namesList = ourState;
  List<Post> postsData = <Post>[];

  addNameToList(String name) {
    ourState.add(name);
    update();
  }

  // our function was triggered here
  Future<PostsResponse> fetchPosts() async {
    // loading starts
    postsLoadingState = PostsLoadingState.loading;
    update();
    // we have to trigger the API now
    // here we are hitting it
    final PostsResponse response = await PracticeServices.fetchPostsData();
    // see if our case was executed or failed
    if (response.posts != null) {
      // we add data
      postsData.addAll(response.posts!);
      update();
    }
    postsLoadingState = PostsLoadingState.loaded;
    update();
    return response;
  }
}
