import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class Model {
  String? userName;
  String? latitude;
  String? longitude;
}

class HomeController extends GetxController {
  File? image;
  Model user = Model();

  //image picker function
  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    this.image = File(image.path);
    update();
  }

  final TextEditingController nameController = TextEditingController();

  String getUserName() {
    user.userName = nameController.text;
    return user.userName ?? 'Enter Name';
  }

  Future<Position> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are not enabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are  denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> updateLocation() async {
    final position = await getUserLocation();
    user.latitude = '${position.latitude}';
    user.longitude = '${position.longitude}';
    update(); // Update the UI with the new location data
  }

  Future<void> clearData() async {
    image = null;
    user = Model();
    nameController.clear();
    update();
  }
}
