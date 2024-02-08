import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class nextpage extends StatelessWidget{
  const nextpage({super.key});
  
  
  
  @override
  Widget build(BuildContext context){
     final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
     final String name = arguments?['name'] ?? '';
    final String imagePath = arguments?['imagePath'] ?? '';
    final String location = arguments?['location'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Information Details'),
        backgroundColor: Colors.green, // Set app bar color
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'place:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Text(
                    name,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Container(
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
              ),
              SizedBox(height: 20),
              
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Location:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    location.length > 1 ? location : '',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 20),
             
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Back to homepage'),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
      
    