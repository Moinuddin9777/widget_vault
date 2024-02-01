import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  RxString location = ''.obs;

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

      location.value =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      log('Location: ${location.value}');
    } catch (e) {
      location.value = 'Error getting location';
      log('Error getting location: $e');
    }
  }
}

