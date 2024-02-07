import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationOnMap extends StatelessWidget {
  const LocationOnMap({super.key, required this.lat, required this.long});
  final String lat;
  final String long;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location:'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              double.parse(lat),
              double.parse(long),
            ),
            zoom: 13,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("Home"),
              icon: BitmapDescriptor.defaultMarker,
              position: LatLng(
                double.parse(lat),
                double.parse(long),
              ),
            ),
          },
        ),
      ),
    );
  }
}
