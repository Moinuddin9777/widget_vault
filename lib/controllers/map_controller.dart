import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/services/direction_services.dart';

import 'package:geocoding/geocoding.dart';
import 'dart:async';

class MapController extends GetxController {
  RxString? lat;
  RxString? long;
  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  Rx<Marker?> marker = Rx<Marker?>(null);
  Rx<LatLng?> destinationLocation = Rx<LatLng?>(null);
  Rx<Marker?> destinationMarker = Rx<Marker?>(null);
  LatLng defaultLocation = const LatLng(20.5937, 78.9629);

  final TextEditingController coordinatesController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final Completer<GoogleMapController> mapController = Completer();

  Future<void> enterLocation() async {
    final String address = coordinatesController.text;
    final LatLng? location = await getLocationFromAddress(address);
    if (location != null) {
      currentLocation.value = location;
      marker.value = Marker(
        markerId: const MarkerId('current_location'),
        position: currentLocation.value!,
      );
      update();
      updateMapCamera();
    } else {
      print('Location not found');
    }
  }

  Future<void> enterDestinationLocation() async {
    final String address = destinationController.text;
    final LatLng? location = await getLocationFromAddress(address);
    if (location != null) {
      destinationLocation.value = location;
      destinationMarker.value = Marker(
        markerId: const MarkerId('destination_location'),
        position: destinationLocation.value!,
      );
      update();
      updateMapCamera();
    } else {
      print('Destination location not found');
    }
  }

  Future<void> getDirections() async {
    if (currentLocation.value != null && destinationLocation.value != null) {
      final DirectionsService directionsService = DirectionsService(
        apiKey: 'AIzaSyA-Jm5iE4aVcTL62UaR3DYUm0Q5SUiXRe0',
      );
      final Directions? directions = await directionsService.getDirections(
        origin: currentLocation.value!,
        destination: destinationLocation.value!,
      );

      if (directions != null && directions.polylinePoints.isNotEmpty) {
        final Polyline polyline = Polyline(
          polylineId: const PolylineId('directions'),
          color: Colors.blue,
          points: directions.polylinePoints,
          width: 3,
        );
        directionsPolylines['directions'] = polyline;
        update();
      } else {
        print('Failed to fetch directions or no route found');
      }
    } else {
      print('Source or destination location missing');
    }
  }

  Future<void> updateMapCamera() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentLocation.value ?? defaultLocation,
          zoom: 15,
        ),
      ),
    );
  }

  void resetData() {
    coordinatesController.clear();
    currentLocation.value = null;
    marker.value = null;
    update();
  }

  void resetDestinationData() {
    destinationController.clear();
    destinationLocation.value = null;
    destinationMarker.value = null;
    update();
  }

  Map<String, Polyline> directionsPolylines = {};
}

Future<LatLng?> getLocationFromAddress(String address) async {
  try {
    final locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      final location = locations.first;
      return LatLng(location.latitude, location.longitude);
    }
  } catch (e) {
    print('Error fetching location from address: $e');
  }
  return null;
}
