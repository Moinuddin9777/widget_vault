import 'package:flutter/material.dart';
import 'package:form/app/modules/home/controller/home_controller.dart';
import 'package:form/app/modules/home/widgets/image_input.dart';
import 'package:form/app/modules/home/widgets/location_input.dart';
import 'package:form/app/modules/home/widgets/title_input.dart';
import 'package:form/app/modules/profile/view.dart';
import 'package:get/get.dart';

import '../../data/models/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HomeController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
              image: AssetImage('assets/images/design.png'),
              alignment: Alignment.bottomRight,
              opacity: 0.08,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/home_image2.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Text(
                    'Fill Place details',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: context.width - 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 10,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const TitleInput(),
                      const SizedBox(height: 10),
                      const ImageInput(),
                      const SizedBox(height: 10),
                      const LocationInput(),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (ctrl.validate()) {
                            Get.to(
                              () => const ProfileScreen(),
                              arguments: User(
                                name: ctrl.textController.text,
                                image: ctrl.image,
                                location: ctrl.location,
                              ),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
