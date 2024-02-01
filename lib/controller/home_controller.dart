import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:profile_app/model/userModel.dart';

class HomeController extends GetxController {
  File? image;
  UserModel user = UserModel();

  //image picker function
  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    this.image = File(image.path);
    update();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  String getUserName() {
    user.userName = nameController.text;
    return user.userName ?? 'no name entered';
  }

  String getUserEmail() {
    user.userEmail = emailController.text;
    return user.userEmail ?? 'no email entered';
  }

  String getAbout() {
    user.userAbout = aboutController.text;
    return user.userAbout ?? 'no about entered';
  }

  Future<Position> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denide');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permanently denied, we cannot request the permision');
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
    user = UserModel();
    nameController.clear();
    emailController.clear();
    aboutController.clear();

    user.latitude = null;
    user.longitude = null;
    update();
  }
}
