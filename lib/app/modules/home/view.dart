import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_app/app/modules/home/controller/home_controller.dart';
import 'package:maps_app/app/modules/map/view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: Get.find<HomeController>(),
        builder: (ctrl) => Center(
          child: SizedBox(
            width: context.width - 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: ctrl.textEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Address',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (ctrl.textEditingController.text.trim().isEmpty) {
                      ctrl.getLocation();
                    } else {
                      ctrl.getLocationFromAddress();
                    }
                  },
                  child: const Text('Get Location'),
                ),
                ctrl.lat != null ? Text('${ctrl.lat}') : const Text(''),
                ctrl.long != null ? Text('${ctrl.long}') : const Text(''),
                IconButton(
                  onPressed: () {
                    ctrl.copyTextToClipboard();
                  },
                  icon: const Icon(Icons.copy),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(() => const MapScreen());
                  },
                  icon: const Icon(Icons.location_on_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
