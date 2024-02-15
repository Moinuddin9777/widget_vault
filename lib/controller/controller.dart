import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

class Controller extends GetxController {
  var count = 0;

  void increment() {
    count++;
    update();
  }

  File? pickedimagefile;
  String? imagePath;
  Position? currentPosition;
  String alert = '';
  final text1 = TextEditingController();
  final text2 = TextEditingController();
  String copyLocation = '';

  var loading = true;
  void _pickimage() async {
    final picker = ImagePicker();
    final pickedimage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      pickedimagefile = File(pickedimage.path);
      imagePath = pickedimage.path;
      update();
    }
  }

  void _pickimageCamera() async {
    final picker = ImagePicker();
    final pickedimage = await picker.pickImage(source: ImageSource.camera);
    if (pickedimage != null) {
      pickedimagefile = File(pickedimage.path);
      imagePath = pickedimage.path;
      update();
    }
  }

  @override
  void dispose() {
    text1.dispose();
    text2.dispose();
    super.dispose();
  }

  Future location() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Alert to enable the location services.
        loading = false;
        update();
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          loading = false;
          update();
        }
      }
      if (permission == LocationPermission.deniedForever) {
        loading = false;
        update();
      }
      return {
        currentPosition = await Geolocator.getCurrentPosition(),
        text1.text = currentPosition!.latitude.toString(),
        text2.text = currentPosition!.longitude.toString(),
        loading = true,
        print(currentPosition),
        update(),
      };
    } catch (e) {
      update();
      alert = '$e';
    }
  }

//Text editing control
  void copy() {
    if (currentPosition != null) {
      copyLocation =
          (currentPosition!.latitude, currentPosition!.longitude).toString();
      Clipboard.setData(ClipboardData(text: copyLocation));
      Get.snackbar('Copied', 'Successfully copied the Location');
    } else {
      copyLocation = text1.text.toString() + text2.text.toString();
      Clipboard.setData(ClipboardData(text: copyLocation));
      Get.snackbar('Copied', 'Successfully copied the Location');
    }
  }

  void share() {
    Share.share(copyLocation);
  }

  void Function() get pickimage => _pickimage;
  void Function() get pickimageCamera => _pickimageCamera;
}
