import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/controller/location_controller.dart';
import 'package:map/controller/clipboard_controller.dart';

import 'package:map/views/map_page.dart';

class HomePage extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());
  final ClipboardController clipboardController =
      Get.put(ClipboardController());
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String address = addressController.text.trim();
                if (address.isNotEmpty) {
                  await locationController.getLocationFromAddress(address);
                } else {
                  print('Address is empty');
                }
              },
              child: Text('Fetch Location'),
            ),
            SizedBox(height: 20),
            GetBuilder<LocationController>(
              builder: (locationController) {
                if (locationController.locations.isEmpty) {
                  return Text('No location fetched');
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: locationController.locations.map((location) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Latitude: ${location.latitude}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Longitude: ${location.longitude}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String coordinates =
                    '${locationController.locations.first.latitude}, ${locationController.locations.first.longitude}';
                clipboardController.copyToClipboard(coordinates);
                Get.to(MapPage());
              },
              child: Text('Go to Map Page'),
            ),
          ],
        ),
      ),
    );
  }
}
