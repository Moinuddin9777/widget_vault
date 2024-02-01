import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/view/finalpage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 19, 228),
        centerTitle: true,
        title: const Text('Home Page', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //profile photo
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 200,
                  height: 200,
                  child: GetBuilder<HomeController>(
                    builder: (controller) {
                      return controller.image != null
                          ? ClipOval(
                            child: Image.file(
                                controller.image!,
                                fit: BoxFit.cover,
                              ),
                          )
                          : Image.asset(
                              'lib/asset/download.png',
                              fit: BoxFit.cover,
                            );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // get image buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          homeController.pickImage(ImageSource.gallery),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Set your desired border radius
                        ),
                      ),
                      child: const Text(
                        'Gallery',
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 250, 250),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () =>
                          homeController.pickImage(ImageSource.camera),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Set your desired border radius
                        ),
                      ),
                      child: const Text(
                        'Camera',
                        style: TextStyle(
                          color: Color.fromRGBO(240, 237, 237, 1),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                //name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // get user name
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextField(
                      controller: homeController.nameController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(200, 255, 255, 255),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            homeController.nameController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 179, 19, 228),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color:  Color.fromARGB(255, 179, 19, 228),
                          ),
                        ),
                      ),
                    ),
                    

                    const SizedBox(height: 20),
                    // get user location
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Geo_Locator',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.purple,
                                width: 1,
                              ),
                            ),
                            child: GetBuilder<HomeController>(
                              builder: (controller) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Latitude: ${controller.user.latitude}, \nLongitude: ${controller.user.longitude}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {
                              homeController.updateLocation();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5), // Set your desired border radius
                              ),
                            ),
                            child: const Text(
                              'get location',
                              style: TextStyle(
                                color: Color.fromRGBO(248, 246, 246, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 179, 19, 228),
        child: ElevatedButton(
          
          onPressed: () => Get.to(() => ProfilePage(
                image: homeController.image,
                userName: homeController.getUserName(),
                latitude: homeController.user.latitude,
                longitude: homeController.user.longitude,
              )),
              style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white, // Change the primary color to purple
    ),

          child: const Text(
            'Save',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
      ),
    );
  }
}
