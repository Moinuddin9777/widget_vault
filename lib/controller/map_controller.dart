import 'dart:async';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapController extends GetxController {
  String? lat;
  String? long;
  LatLng? currentLocation;
  Marker? marker;
  LatLng? destinationLocation;
  Marker? destinationMarker;

  LatLng defaultLocation = const LatLng(20.5937, 78.9629);

  final TextEditingController coordinatesController = TextEditingController();
  final TextEditingController destinationCoordinatesController =
      TextEditingController();
  final Completer<GoogleMapController> mapController = Completer();

  void enterdLocation() {
    final coordinatesString = coordinatesController.text;
    final coordinates = coordinatesString.split(',');
    if (coordinates.length == 2) {
      try {
        final lat = double.parse(coordinates[0].trim());
        final lng = double.parse(coordinates[1].trim());
        currentLocation = LatLng(lat, lng);
        update();
        marker = Marker(
          markerId: const MarkerId('current_location'),
          position: currentLocation!,
        );
        update();
        updateMapCamera();
      } catch (e) {
        // Handle invalid coordinates input
        //print('Invalid coordinates: $e');
        // Show an error message to the user
      }
    } else {
      // Handle missing or incorrect coordinate format
      // Show an error message to the user
    }
  }

  Future<void> updateMapCamera() async {
    // Access the class-level mapController directly
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

  void pasteCoordinates() async {
    String? clipboardText = await FlutterClipboard.paste();
    coordinatesController.text = clipboardText;
  }

  void resetData() {
    coordinatesController.clear();
    currentLocation = null;
    marker = null;
    update();
  }

  void enterDestinationLocation() {
    final coordinatesString = destinationCoordinatesController.text;
    final coordinates = coordinatesString.split(',');
    if (coordinates.length == 2) {
      try {
        final lat = double.parse(coordinates[0].trim());
        final lng = double.parse(coordinates[1].trim());
        destinationLocation = LatLng(lat, lng);
        destinationMarker = Marker(
          markerId: const MarkerId('destination_location'),
          position: destinationLocation!,
        );
        update();
        updateMapCamera();
      } catch (e) {
        // Handle invalid coordinates input
      }
    } else {
      // Handle missing or incorrect coordinate format
    }
  }

  void resetDestinationData() {
    destinationCoordinatesController.clear();
    destinationLocation = null;
    destinationMarker = null;
    update();
  }

  Map<String, Polyline> polylines = {};

  Future<void> getPolyline() async {
    if (currentLocation != null && destinationLocation != null) {
      // Initialize the polyline points instance
      PolylinePoints polylinePoints = PolylinePoints();

      // Get the coordinates for the polyline
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyA-Jm5iE4aVcTL62UaR3DYUm0Q5SUiXRe0', // Replace with your Google Maps API key
        PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
        PointLatLng(
            destinationLocation!.latitude, destinationLocation!.longitude),
        travelMode: TravelMode.driving,
      );

      // If polyline points are fetched successfully
      if (result.points.isNotEmpty) {
        // Convert polyline points to LatLng list
        List<LatLng> polylineCoordinates = result.points
            .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
            .toList();

        // Create a polyline with the polyline coordinates
        Polyline polyline = Polyline(
          polylineId: PolylineId('poly'),
          color: Colors.blue,
          points: polylineCoordinates,
          width: 3,
        );

        // Clear previous polylines
        polylines.clear();

        // Update the list of polylines in the map controller
        polylines['poly'] = polyline;
        update();
      } else {
        // Handle no polyline points found
      }
    } else {
      // Handle missing source or destination location
    }
  }
}
