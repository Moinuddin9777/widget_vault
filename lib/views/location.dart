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
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.text1,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the latitude or try to add location",
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: TextField(
                    controller: controller.text2,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the longitude or try to add location",
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.copy();
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text(""),
                ),
                const SizedBox(width: 4),
                ElevatedButton.icon(
                    onPressed: () {
                      controller.share;
                    },
                    icon: const Icon(Icons.share_location),
                    label: const Text("Share")),
              ],
            ),
          ),
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
              label: const Text("Add Location")),
          const SizedBox(height: 4),
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
                return const Text("Please add the location");
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
