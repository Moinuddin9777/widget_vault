import 'dart:io';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_vault/models/passing_data.dart';
import 'package:widget_vault/views/display_page.dart';
import 'package:widget_vault/views/image_input_widget.dart';
import 'package:widget_vault/views/location_input_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController _textController = TextEditingController();
  File? _selectedImage;
  double latitude = double.infinity, longitude = double.infinity;
  void sendInfo() {
    if (_selectedImage == null ||
        _textController.text == "" ||
        latitude == double.infinity ||
        longitude == double.infinity) return;
    Get.to(
      () => const DisplayPage(),
      arguments: {
        "name": _textController.text,
        "image": _selectedImage!,
        "latitude": latitude,
        "longitude": longitude,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter you name:',
                  ),
                  controller: _textController,
                  scrollPadding: const EdgeInsets.all(20),
                ),
              ),
              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
              LocationInput(
                onPickLocation: (long, lat) {
                  latitude = lat;
                  longitude = long;
                },
              ),
              ElevatedButton(
                onPressed: sendInfo,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
