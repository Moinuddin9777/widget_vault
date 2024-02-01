import 'package:flutter/material.dart';
import 'package:form/app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

class LocationInput extends StatelessWidget {
  const LocationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: DottedBorder(
        color: Colors.grey[400]!,
        dashPattern: const [8, 4],
        child: GetBuilder(
          init: Get.find<HomeController>(),
          builder: (ctrl) {
            Widget content = Image.asset(
              'assets/images/home_image.png',
              height: 50,
              width: 50,
            );
            if (ctrl.isLoading) {
              content = const CircularProgressIndicator();
            }
            if (ctrl.location != null) {
              content = Image.asset(
                'assets/images/map.png',
                fit: BoxFit.fill,
              );
            }
            return GestureDetector(
              onTap: () {
                ctrl.getLocation();
              },
              child: Container(
                height: 175,
                width: 290,
                alignment: Alignment.center,
                child: content,
              ),
            );
          },
        ),
      ),
    );
  }
}
