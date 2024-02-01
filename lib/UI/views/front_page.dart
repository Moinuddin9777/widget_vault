import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:widget_vault/controller/location_controller.dart';
import 'package:widget_vault/controller/image_controller.dart';

class FirstPage extends StatelessWidget {
  final ImageController imageController = Get.find();
  final LocationController locationController = Get.find(); // Use Get.find() to get the controller
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Information'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => Container( // Use Obx for reactive updates
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: (imageController.selectedImagePath.isNotEmpty)
                          ? Image.file(
                              File(imageController.selectedImagePath),
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Text('No Image Selected'),
                            ),
                    )),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          imageController.pickImage(ImageSource.gallery),
                      child: Text('Gallery'),
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          imageController.pickImage(ImageSource.camera),
                      child: Text('Camera'),
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() => Container( // Use Obx for reactive updates
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        locationController.location,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )),
                ElevatedButton(
                  onPressed: () async {
                    await locationController.getCurrentLocation();
                  },
                  child: Text('Get Location'),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        imageController.selectedImagePath.isNotEmpty &&
                        locationController.location.isNotEmpty) {
                      Get.toNamed('/second', arguments: {
                        'name': nameController.text,
                        'imagePath': imageController.selectedImagePath,
                        'location': locationController.location,
                      });
                    } else {
                      // Display error popup if any field is empty
                      Get.defaultDialog(
                        title: "Error",
                        middleText: "All fields must be filled!",
                      );
                    }
                  },
                  child: Text('Go to Second Page'),
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

