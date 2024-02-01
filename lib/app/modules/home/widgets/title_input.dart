import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Place',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Form(
          key: ctrl.formKey,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter place name';
              }
              return null;
            },
            controller: ctrl.textController,
            decoration: InputDecoration(
              hintText: "home",
              hintStyle: TextStyle(
                color: Colors.grey[450],
                fontWeight: FontWeight.w300
              ),
              filled: true,
              fillColor: Colors.grey[350],
              border: InputBorder.none,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
