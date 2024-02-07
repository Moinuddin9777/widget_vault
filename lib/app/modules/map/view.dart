import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/app/modules/map/controller/map_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: Get.put(MapController()),
        builder: (ctrl) => SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: ctrl.kGooglePlex,
                onMapCreated: (GoogleMapController c) {
                  ctrl.controller.complete(c);
                },
              ),
              Positioned(
                top: 10.0,
                left: 10.0,
                right: 10.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: ctrl.searchController,
                      decoration: InputDecoration(
                        hintText: 'Search location',
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          onPressed: () {
                            ctrl.pasteFromClipboard();
                          },
                          icon: const Icon(Icons.paste_outlined),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            ctrl.pinLocation();
                          },
                          icon: const Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
