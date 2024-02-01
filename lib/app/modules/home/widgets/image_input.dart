import 'package:flutter/material.dart';
import 'package:form/app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class ImageInput extends StatelessWidget {
  const ImageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Get.defaultDialog(
          title: 'Capture Image',
          content: GetBuilder(
            init: Get.find<HomeController>(),
            builder: (ctrl) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                ),
                width: 150,
                height: 200,
                alignment: Alignment.center,
                child: ctrl.image == null
                    ? GestureDetector(
                        onTap: () => ctrl.captureImage(),
                        child: const Icon(Icons.camera),
                      )
                    : GestureDetector(
                        onTap: () => ctrl.captureImage(),
                        child: Image.file(
                          ctrl.image!,
                          fit: BoxFit.fill,
                        ),
                      ),
              );
            },
          ),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'done',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        );
      },
      icon: Container(
        alignment: Alignment.centerRight,
        width: 120,
        height: 40,
        child: const Icon(Icons.image),
      ),
      label: Container(
        alignment: Alignment.centerLeft,
        width: 180,
        height: 40,
        child: const Text('Upload Image'),
      ),
      style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all(Colors.grey[350]),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
