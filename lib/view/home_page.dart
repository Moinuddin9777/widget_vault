import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_app/controller/home_page_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_app/view/profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
        leading: const Icon(
          Icons.home,
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text('Home Page', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //profile photo
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 100,
                  height: 100,
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
                              'lib/assets/personImage.png',
                              fit: BoxFit.cover,
                            );
                    },
                  ),
                ),

                // get image buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          homeController.pickImage(ImageSource.gallery),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Set your desired border radius
                        ),
                      ),
                      child: const Text(
                        'Gallery',
                        style: TextStyle(
                          color: Color.fromRGBO(26, 26, 26, 1.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () =>
                          homeController.pickImage(ImageSource.camera),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Set your desired border radius
                        ),
                      ),
                      child: const Text(
                        'Camera',
                        style: TextStyle(
                          color: Color.fromRGBO(26, 26, 26, 1.0),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // user details column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // get user name
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(200, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // get user email address
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextField(
                      controller: homeController.emailController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'example@gmail.com',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(200, 255, 255, 255),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            homeController.emailController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(200, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // get user about section
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'About',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextField(
                      controller: homeController.aboutController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Write something about you',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(200, 255, 255, 255),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            homeController.aboutController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(200, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // get user location
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Address',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
                                color: Colors.white,
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
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5), // Set your desired border radius
                              ),
                            ),
                            child: const Text(
                              'get location',
                              style: TextStyle(
                                color: Color.fromRGBO(26, 26, 26, 1.0),
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
        color: const Color.fromRGBO(26, 26, 26, 1),
        child: ElevatedButton(
          onPressed: () => Get.to(() => ProfilePage(
                image: homeController.image,
                userName: homeController.getUserName(),
                userEmail: homeController.getUserEmail(),
                userAbout: homeController.getAbout(),
                latitude: homeController.user.latitude,
                longitude: homeController.user.longitude,
              )),

          child: const Text(
            'Save',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(26, 26, 26, 1),
            ),
          ),
        ),
      ),
    );
  }
}
