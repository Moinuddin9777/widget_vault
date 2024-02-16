import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:core';
import 'package:widget_vault/controller/controller.dart';

class GeoLocator extends StatefulWidget {
  const GeoLocator({super.key});
  @override
  State<GeoLocator> createState() => _GeoLocatorState();
}

class _GeoLocatorState extends State<GeoLocator> {
  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: controller.text1,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
            ],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter the latitude: 23.777777",
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: controller.text2,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
            ],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter the longitude : 41.88",
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Please provide the permissions to provide the accurate location",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
              onPressed: () async {
                await controller.location();
              },
              icon: const Icon(Icons.location_on),
              label: const Text("Add Current Location")),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  controller.copy();
                },
                icon: const Icon(Icons.copy),
                label: const Text("Copy"),
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                  onPressed: () {
                    if (controller.currentPosition == null) {
                      Get.snackbar("Error",
                          "Please enter the valid location in double type and current location");
                    } else {
                      Get.toNamed('/thirdpage', arguments: {
                        "latitude": double.parse(controller.text1.text),
                        "longitude": double.parse(controller.text2.text),
                        "position": controller.currentPosition,
                      });
                    }
                  },
                  icon: const Icon(Icons.map_outlined),
                  label: const Text("Open Map")),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                  onPressed: () {
                    controller.share1;
                  },
                  icon: const Icon(Icons.share_rounded),
                  label: const Text("Share")),
            ],
          ),

          const SizedBox(height: 8),
          //Getbuilder
          GetBuilder<Controller>(
            builder: (controller) {
              if (!controller.loading) {
                return Text(
                  "\"ERROR\" : ${controller.alert}. Please disable the Location !!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                );
              }
              if (controller.currentPosition == null) {
                return const Text("Please add the location",
                    style: TextStyle(color: Colors.red));
              } else {
                return Text('${controller.currentPosition}');
              }
            },
          ),
        ],
      ),
    );
  }
}
