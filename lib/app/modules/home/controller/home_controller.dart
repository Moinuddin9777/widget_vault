import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final textEditingController = TextEditingController();
  Position? loaction;
  String? lat;
  String? long;
  String? value;
  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Service is not disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Permission is denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      debugPrint('Permission denied forever');
    }
    loaction = await Geolocator.getCurrentPosition();
    if (loaction != null) {
      debugPrint(
        'latitude : ${loaction!.latitude} longitude : ${loaction!.longitude}',
      );
      value = '${loaction!.latitude} ${loaction!.longitude}';
      lat = loaction!.latitude.toString();
      long = loaction!.longitude.toString();
      update();
    }
  }

  void getLocationFromAddress() async {
    List<Location> locations =
        await locationFromAddress(textEditingController.text);
    if (locations.isNotEmpty) {
      debugPrint(
          'Latitude: ${locations.first.latitude}, Longitude: ${locations.first.longitude}');
      lat = locations.first.latitude.toString();
      long = locations.first.longitude.toString();
      value = '$lat $long';
      update();
    } else {
      debugPrint('No location found for the address.');
    }
  }

  Future<void> copyTextToClipboard() async {
    if (value != null) {
      FlutterClipboard.copy(value!);
    }
  }
}
