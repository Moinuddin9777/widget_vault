import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final RxList<LatLng> polylinePoints;

  Directions({required List<LatLng> polylinePoints})
      : polylinePoints = polylinePoints.obs;
}
