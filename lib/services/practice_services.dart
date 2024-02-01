import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_vault/services/practice_services.dart';

class YourWidget extends StatelessWidget {
  final PracticeServices practiceServices = Get.put(PracticeServices());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Widget'),
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (Post post in practiceServices.postsList)
                Text(post.title),
              ElevatedButton(
                onPressed: () async {
                  await practiceServices.fetchPosts();
                },
                child: Text('Fetch Posts'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
