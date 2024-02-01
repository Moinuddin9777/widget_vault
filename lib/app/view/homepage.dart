// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:assignment2/app/controller/imagepickercontroller.dart';
import 'package:assignment2/app/controller/locationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class homepage extends StatelessWidget{


 final ImagePickercontroller image = Get.put(ImagePickercontroller());
 final locationController location = Get.put(locationController());
 final TextEditingController name = TextEditingController();


@override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 84, 130, 140) ,
         title:const Text("HOME PAGE",style: TextStyle(color: Colors.black),),
          
      ),
      body: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(  
              colors: [
                 Color.fromARGB(255, 110, 152, 186),
                  Color.fromARGB(255, 84, 130, 140),
                 ], 
                 begin: Alignment.topLeft,
                 end: Alignment.bottomRight,
            ),
        ),
        child: Center(
          child: Column(
             children: [
               TextField(
                maxLength: 30,
                controller: name,
                decoration: InputDecoration(
                  label:Text(' Place'), 
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GetBuilder<ImagePickercontroller>(
                  builder: (controller) {
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: (controller.selectedImagepath.isNotEmpty)
                          ? Image.file(
                              File(controller.selectedImagepath),
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Text('Image not Selected'),
                            ),
                    );
                  },
                ),
              ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('choose photo'),
                actions: [
                  TextButton(
                    onPressed: () {
                   image.pickImage(ImageSource.gallery);
                    },
                
                    child:const Text('select photo from gallery'),
                  ),
                  TextButton(
                    onPressed: () { 
                      
                      image.pickImage(ImageSource.camera); 
                    },
                    child:const Text('Take photo from camera'),
                  ),
                ],
              ),
            );
          },
          child:const Text('choose photo'),
        ),
        
         const SizedBox(
          height: 20,
         ),
         GetBuilder<locationController>(
                  builder: (controller) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        controller.location,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    await location.getCurrentLocation();
                  },
                  child:const Text('Get Location'),
                  
                ),
                 const SizedBox(
          height: 20,
         ),
         ElevatedButton(onPressed: (){
          Get.toNamed('/next', arguments: {
                        'name': name.text,
                        'imagePath': image.selectedImagepath,
                        'location': location.location,
                      });
         }, 
         child: Text("Tap to Display")),
             ],
          ),
        ),
      ),

    );
}
}






