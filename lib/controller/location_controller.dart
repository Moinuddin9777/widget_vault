import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  List<Location> locations = [];

  Future<void> getLocationFromAddress(String address) async {
    if (await _requestLocationPermission()) {
      try {
        List<Location> newLocations = await locationFromAddress(address);
        locations = newLocations;
        update();
      } catch (e) {
        print('Error getting location from address: $e');
      }
    } else {
      print('Location permission denied');
    }
  }

  Future<bool> _requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }
}
