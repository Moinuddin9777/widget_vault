import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:clipboard/clipboard.dart';
import 'package:geocoding/geocoding.dart' as geoc;

class LocationSelection extends StatefulWidget {
  const LocationSelection({super.key});

  @override
  State<LocationSelection> createState() {
    return _LocationSelectionState();
  }
}

class _LocationSelectionState extends State<LocationSelection> {
  final TextEditingController _cityNameController = TextEditingController();
  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    FlutterClipboard.copy("${locationData.latitude},${locationData.longitude}");
  }

  void _getLocationFromName() async {
    if (_cityNameController.text == "") return;
    print('1');

    List<geoc.Location> locations =
        await geoc.locationFromAddress(_cityNameController.text);
    print('2');
    if (locations.isEmpty) {
      print('invalid name');
      return;
    }
    print('3');
    print(locations[0].latitude);
    print(locations[0].longitude);
    FlutterClipboard.copy("${locations[0].latitude},${locations[0].longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select a location',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.copy),
              label: const Text('Copy current Location'),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text('or'),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _cityNameController,
                maxLength: 25,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _getLocationFromName,
              icon: const Icon(Icons.copy),
              label: const Text('Copy coordinates from city name'),
            ),
          ],
        ),
      ),
    );
  }
}
