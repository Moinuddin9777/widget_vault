import 'dart:async';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  final searchController = TextEditingController();

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  void pinLocation() async {
    List<String> values = searchController.text.split(' ');
    debugPrint('${values[0]} ${values[1]}');
    double lat = double.parse(values[0]);
    double long = double.parse(values[1]);

    GoogleMapController mapCtrl = await controller.future;
    mapCtrl.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 11,
        ),
      ),
    );
  }

  void pasteFromClipboard() async {
    final data = await FlutterClipboard.paste();
    if (data.isNotEmpty) {
      searchController.text = data;
    }
  }
}
