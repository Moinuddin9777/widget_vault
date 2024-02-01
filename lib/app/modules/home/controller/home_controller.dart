import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;
  Position? location;
  bool isLoading = false;

  captureImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 300,
    );
    if (pickedImage != null) {
      image = File(pickedImage.path);
      update();
    }
  }

  getLocation() async {
    isLoading = true;
    update();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        'Location service is not enabled!',
        'Please enable location service',
      );
    } else {
      debugPrint('service is available');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Location permission denied!',
            'Please provide the location permission');
      }
    } else {
      debugPrint('permission is available');
    }

    try {
      location = await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoading = false;
    update();
    debugPrint(location.toString());
  }

  bool validate() {
    if (formKey.currentState!.validate()) {
      if (image != null) {
        if (location != null) {
          return true;
        } else {
          Get.snackbar(
            'Location is empty',
            'Fetch Location',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            titleText: const Text(
              'Location is empty',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          );
        }
      } else {
        location != null
            ? Get.snackbar(
                '',
                'Capture Image',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                titleText: const Text(
                  'Image is empty',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              )
            : Get.snackbar(
                '',
                'Fetch Location and capture Image',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                titleText: const Text(
                  'Location and image are empty',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
      }
    }
    return false;
  }
}
