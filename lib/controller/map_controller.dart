import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/services/direction_services.dart';

import 'package:geocoding/geocoding.dart';
import 'dart:async';

class MapController extends GetxController {
  String? lat;
  String? long;
  LatLng? currentLocation;
  Marker? marker;
  LatLng? destinationLocation;
  Marker? destinationMarker;
  LatLng defaultLocation = const LatLng(20.5937, 78.9629);

  final TextEditingController coordinatesController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final Completer<GoogleMapController> mapController = Completer();

  Future<void> enterLocation() async {
    final String address = coordinatesController.text;
    final LatLng? location = await getLocationFromAddress(address);
    if (location != null) {
      currentLocation = location;
      marker = Marker(
        markerId: const MarkerId('current_location'),
        position: currentLocation!,
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
      destinationLocation = location;
      destinationMarker = Marker(
        markerId: const MarkerId('destination_location'),
        position: destinationLocation!,
      );
      update();
      updateMapCamera();
    } else {
      print('Destination location not found');
    }
  }

  Future<void> getDirections() async {
    if (currentLocation != null && destinationLocation != null) {
      final DirectionsService directionsService = DirectionsService(
        apiKey: 'AIzaSyA-Jm5iE4aVcTL62UaR3DYUm0Q5SUiXRe0',
      );
      final Directions? directions = await directionsService.getDirections(
        origin: currentLocation!,
        destination: destinationLocation!,
      );

      if (directions != null && directions.polylinePoints.isNotEmpty) {
        // Clear previous polylines
        directionsPolylines.clear();

        // Add new polyline for directions
        final Polyline polyline = Polyline(
          polylineId: const PolylineId('directions'),
          color: Colors.blue,
          points: directions.polylinePoints,
          width: 3,
        );
        directionsPolylines['directions'] = polyline;

        // Update the map
        update();
      } else {
        print('Failed to fetch directions or no route found');
      }
    } else {
      print('Source or destination location missing');
      // Show an error message to the user
    }
  }

  Future<void> updateMapCamera() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentLocation ?? defaultLocation,
          zoom: 15,
        ),
      ),
    );
  }

  void resetData() {
    coordinatesController.clear();
    currentLocation = null;
    marker = null;
    update();
  }

  void resetDestinationData() {
    destinationController.clear();
    destinationLocation = null;
    destinationMarker = null;
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
