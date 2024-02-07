import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_vault/views/location_selection_page.dart';
import 'package:widget_vault/views/coords_paste_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Satya Maps',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              label: const Text('Choose Location'),
              onPressed: () {
                Get.to(() => const LocationSelection());
              },
              icon: const Icon(
                Icons.location_on_outlined,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              label: const Text('Location on Map'),
              onPressed: () {
                Get.to(() => const CoordsPaste());
              },
              icon: const Icon(
                Icons.map_sharp,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
