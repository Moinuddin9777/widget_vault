import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _MyAppState();
}

class _MyAppState extends State<GoogleMaps> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    late Map<String, dynamic> argument = Get.arguments;
    final double? latitude = argument["latitude"];
    final double? longitude = argument["longitude"];
    final Position? location = argument['position'];
    final LatLng center = LatLng(latitude!, longitude!);
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          elevation: 2,
        ),
        body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 11.0,
            ),
            myLocationEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId("Entered Location"),
                position: LatLng(latitude, longitude),
                infoWindow: InfoWindow(
                  title: "Entered Location",
                  snippet: "$latitude,$longitude",
                ), // InfoWindow
              ),
              Marker(
                markerId: const MarkerId("Current Location"),
                position: LatLng(location!.latitude, location.longitude),
                infoWindow: InfoWindow(
                  title: "Current Location",
                  snippet: "${location.latitude},${location.longitude}",
                ), // InfoWindow
              ),
            } //Mark
            ),
      ),
    );
  }
}
