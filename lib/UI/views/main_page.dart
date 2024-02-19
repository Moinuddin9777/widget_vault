import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/controller/map_controller.dart';
import 'package:clipboard/clipboard.dart';

class MapPage extends StatelessWidget {
  MapPage({Key? key}) : super(key: key);

  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 13, 13),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 73, 71, 71),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Map Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Latitude, Longitude',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: mapController.coordinatesController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Enter Coordinates (latitude, longitude)',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(200, 255, 255, 255),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    String? clipboardText = await FlutterClipboard.paste();
                    mapController.coordinatesController.text = clipboardText;
                  },
                  icon: const Icon(Icons.paste),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(200, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              mapController.enterLocation();
            },
            child: const Text('Show Location'),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              'Destination Address',
              style: TextStyle(
                color: Color.fromARGB(255, 237, 185, 12),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: mapController.destinationController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Enter Destination Address',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(200, 255, 255, 255),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    mapController.destinationController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 4, 6, 5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(199, 2, 138, 22),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          ElevatedButton(
            onPressed: () {
              mapController.enterDestinationLocation();
            },
            child: const Text('Set Destination'),
          ),
          ElevatedButton(
            onPressed: () {
              mapController.getDirections();
            },
            child: const Text('Get Directions'),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 26, 26, 26),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color.fromARGB(255, 16, 156, 3),
                  width: 1,
                ),
              ),
              child: GetBuilder<MapController>(
                builder: (controller) {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: controller.defaultLocation,
                      zoom: 5,
                    ),
                    onMapCreated: (GoogleMapController mapController) {
                      controller.mapController.complete(mapController);
                    },
                    polylines:
                        Set<Polyline>.of(controller.directionsPolylines.values),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
