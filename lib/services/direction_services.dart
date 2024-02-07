import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsService {
  static const _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';
  final String? apiKey;

  DirectionsService({this.apiKey});

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    if (apiKey == null) {
      print('API key is missing.');
      return null;
    }

    final response = await http.get(
      Uri.parse(
          '$_baseUrl?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final List<LatLng> polylinePoints =
            _decodePolyline(data['routes'][0]['overview_polyline']['points']);
        return Directions(polylinePoints: polylinePoints);
      }
    }
    return null;
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<int> polylinePoints = [];
    for (int i = 0; i < encoded.length; i++) {
      int c = encoded.codeUnitAt(i) - 63;
      polylinePoints.add(c >> 1);
    }

    List<LatLng> polylineCoordinates = [];
    for (int i = 0; i < polylinePoints.length; i += 2) {
      double lat = polylinePoints[i] / 1E5;
      double lng = polylinePoints[i + 1] / 1E5;
      polylineCoordinates.add(LatLng(lat, lng));
    }

    return polylineCoordinates;
  }
}

class Directions {
  final List<LatLng> polylinePoints;

  Directions({required this.polylinePoints});
}
