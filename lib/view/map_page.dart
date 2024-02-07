import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:profile_app/controller/map_controller.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
        leading: IconButton(
          onPressed: () {
            mapController.resetData();
            mapController.resetDestinationData();
            Get.back();
          },
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Coordinates
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Address text
                  const Text(
                    'Source Coordinates',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //paste logo
                      IconButton(
                        onPressed: () => mapController.pasteCoordinates(),
                        icon: const Icon(
                          Icons.paste_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      // copy logo
                      IconButton(
                        onPressed: () {
                          final String coordinates =
                              mapController.coordinatesController.text;
                          FlutterClipboard.copy(coordinates);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('coordinates copied to clipboard'),
                              //duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.content_copy_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextField(
              controller: mapController.coordinatesController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: '(latitude (N or -S), longitude (E or -W))',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(200, 255, 255, 255),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    mapController.coordinatesController.clear();
                  },
                  icon: const Icon(Icons.clear),
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
            const SizedBox(height: 20),

            // Destination Coordinates
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Address text
                  const Text(
                    'Destination Coordinates',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //paste logo
                      IconButton(
                        onPressed: () => mapController.pasteCoordinates(),
                        icon: const Icon(
                          Icons.paste_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      // copy logo
                      IconButton(
                        onPressed: () {
                          final String coordinates =
                              mapController.destinationCoordinatesController.text;
                          FlutterClipboard.copy(coordinates);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('destination coordinates copied to clipboard'),
                              //duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.content_copy_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextField(
              controller: mapController.destinationCoordinatesController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: '(latitude (N or -S), longitude (E or -W))',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(200, 255, 255, 255),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    mapController.destinationCoordinatesController.clear();
                  },
                  icon: const Icon(Icons.clear),
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
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Google Maps text
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Gmaps',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // show location button
                ElevatedButton(
                  onPressed: () {
                    mapController.enterdLocation();
                  },
                  child: const Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(26, 26, 26, 1),
                    ),
                  ),
                ),

                // show direction button
                ElevatedButton(
                  onPressed: () {
                    mapController.enterdLocation();
                    mapController.enterDestinationLocation();
                    mapController.getPolyline();
                  },
                  child: const Text(
                    'Direction',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(26, 26, 26, 1),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                //width: 300,
                //height: 400,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 26, 26, 26),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GetBuilder<MapController>(
                    builder: (controller) {
                      // Add onMapCreated callback
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: controller.currentLocation ??
                              controller.defaultLocation,
                          zoom: 4,
                        ),
                        onMapCreated: (GoogleMapController mapController) {
                          controller.mapController.complete(mapController);
                        },
                        markers: {
                          if (controller.marker != null) controller.marker!,
                          if (controller.destinationMarker != null) controller.destinationMarker!,
                        },
                        polylines: Set<Polyline>.of(controller.polylines.values),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
