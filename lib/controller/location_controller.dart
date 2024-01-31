import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  String location = '';
  void log(String message) {
    print(message);
  }

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      log('Location permission status: $permission');

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      location =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      update();
      log('Location: $location');
    } catch (e) {
      location = 'Error getting location';
      update();
      log('Error getting location: $e');
    }
  }
}
