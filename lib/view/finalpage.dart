import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/controller.dart';
import 'package:project/view/mappage.dart';
import 'package:clipboard/clipboard.dart';

// ignore: must_be_immutable
class FinalPage extends StatelessWidget {
  FinalPage({
    super.key,
    required this.image,
    required this.userName,
    required this.latitude,
    required this.longitude,
  });

  final File? image;
  String userName;
  String? latitude;
  String? longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 169, 21, 232),
        leading: IconButton(
          onPressed: () async {
            //clear everything and go back
            await Get.find<HomeController>().clearData();
            Get.toNamed('/homepage');
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text('Final Page', style: TextStyle(color: Colors.white)),
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
                  width: 200,
                  height: 200,
                  child: image != null
                      ? ClipOval(
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          'lib/asset/download.png',
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

                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Set your desired border radius
                    ),
                  ),
                  child: const Text(
                    'Edit my details',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(249, 247, 247, 1),
                    ),
                  ),
                ),
                // user details column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // display user address
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Geo_Locator',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // copy icon
                          IconButton(
                            onPressed: () {
                              String address = '$latitude,$longitude';
                              FlutterClipboard.copy(address);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Text Copied to Clipboard'),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.content_copy_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 26, 26, 26),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.purple,
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
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 179, 19, 228),
        child: ElevatedButton(
          onPressed: () => Get.to(() => MapPage()),
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
