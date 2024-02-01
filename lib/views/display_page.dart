import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Information Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Name: ${Get.arguments["name"]}'),
          const SizedBox(
            height: 15,
          ),
          const Text('Picture:'),
          const SizedBox(
            height: 15,
          ),
          Image.file(
            Get.arguments["image"],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
              'latitude: ${Get.arguments["latitude"]} longitude: ${Get.arguments["longitude"]}'),
        ],
      ),
    );
  }
}
