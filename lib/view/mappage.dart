import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/controller/mapcontroller.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 207, 22, 244),
        leading: IconButton(
          onPressed: () {
            Get.back();
            mapController.resetData();
            mapController.resetDestinationData();
          },
          icon: const Icon(
            Icons.arrow_back,
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
            // Current Location Coordinates
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Address text
                  const Text(
                    'Current Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
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
                          size: 25,
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
                          size: 25,
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
                hintText: 'Enter (Longitude) , (Latitude)',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(200, 255, 255, 255),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    mapController.coordinatesController.clear();
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 186, 31, 221),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(199, 185, 19, 211),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Destination Location
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Address text
                  const Text(
                    'Destination Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
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
                          size: 25,
                        ),
                      ),
                      // copy logo
                      IconButton(
                        onPressed: () {
                          final String coordinates = mapController
                              .destinationCoordinatesController.text;
                          FlutterClipboard.copy(coordinates);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Destination Copied to Clipboard'),
                              //duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.content_copy_rounded,
                          color: Colors.white,
                          size: 25,
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
                hintText: 'Enter (Latitude) , (Longitude)',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(198, 255, 253, 255),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    mapController.destinationCoordinatesController.clear();
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 154, 18, 228),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(199, 186, 24, 235),
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
                ),

                // location button
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Set your desired border radius
                        ),
                      ),
                      onPressed: () {
                        mapController.enterCurrentLocation();
                      },
                      child: const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ),

                // show direction button
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Set your desired border radius
                      ),
                    ),
                    onPressed: () {
                      mapController.enterCurrentLocation();
                      mapController.enterDestinationLocation();
                      mapController.getPolyline();
                    },
                    child: const Text(
                      'Direction',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
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
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
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
                          if (controller.currentmarker != null) controller.currentmarker!,
                          if (controller.destinationMarker != null)
                            controller.destinationMarker!,
                        },
                        polylines:
                            Set<Polyline>.of(controller.polylines.values),
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
