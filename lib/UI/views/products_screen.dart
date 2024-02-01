import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (arguments == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Text('Error: Invalid data passed to the second page'),
        ),
      );
    }

    final String name = arguments['name'] ?? '';
    final String imagePath = arguments['imagePath'] ?? '';
    final String location = arguments['location'] ?? '';

    final List<String> locationParts = location.split(',');

    return Scaffold(
      appBar: AppBar(
        title: Text('Information Details'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: (imagePath.isNotEmpty)
                        ? Image.file(
                            File(imagePath),
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text('No Image Selected'),
                          ),
                  )),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Latitude:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Obx(() => Text(
                        locationParts.isNotEmpty ? locationParts[0] : '',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Longitude:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Obx(() => Text(
                        locationParts.length > 1 ? locationParts[1] : '',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Text(
                    name,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Back to Capture Information'),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

