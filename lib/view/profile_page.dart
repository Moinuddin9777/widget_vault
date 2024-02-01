import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_app/controller/home_controller.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({
    super.key,
    required this.image,
    required this.userName,
    required this.userEmail,
    required this.userAbout,
    required this.latitude,
    required this.longitude,
  });

  final File? image;
  String userName;
  String userEmail;
  String userAbout;
  String? latitude;
  String? longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
        leading: IconButton(
          onPressed: () async {
            //clear everything and go back
            await Get.find<HomeController>().clearData();
            Get.toNamed('/home_page');
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title:
            const Text('Products Page', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // show profile photo
                SizedBox(
                  width: 100,
                  height: 100,
                  child: image != null
                      ? ClipOval(
                        child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                      )
                      : Image.asset(
                          'lib/assets/personImage.png',
                          fit: BoxFit.cover,
                        ),
                ),

                // show user name
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 26, 26, 26),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // show email address
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 26, 26, 26),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      userEmail,
                      style: const TextStyle(
                        color: Color.fromARGB(175, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Edit my details',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(26, 26, 26, 1),
                    ),
                  ),
                ),
                // user details column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // display about user
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
                    const SizedBox(height: 10),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 26, 26, 26),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          userAbout,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // display user address
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
                    const SizedBox(height: 10),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 26, 26, 26),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Latitude : $latitude \nLongitude : $longitude',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
