import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_vault/UI/views/products_screen.dart';
import 'package:widget_vault/controllers/form_controller.dart';

class ImageSelectorField extends StatefulWidget {
  final String question;
  final List<TextEditingController>? answerControllers;
  final List<Map<String, dynamic>>? finalAnswer;
  final bool isRequired;
  final void Function(String?)? onSaved;
  const ImageSelectorField({
    required this.question,
    this.answerControllers,
    this.finalAnswer,
    required this.isRequired,
    required this.onSaved,
    super.key,
  });

  @override
  State<ImageSelectorField> createState() => _ImageSelectorFieldState();
}

class _ImageSelectorFieldState extends State<ImageSelectorField> {
  XFile? _image;
  String? _base64Url;
  TextEditingController imageUrlController = TextEditingController();

  void pickImage(Function(String) onImageSelected) async {
    // Show a bottom sheet to ask the user whether they want to pick an image from the gallery or the camera.
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Take a photo'),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            title: Text('Choose from gallery'),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );

    // If the user selected a source, then pick an image from that source.
    if (source != null) {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 50);
      if (image != null) {
        setState(() {
          _image = image;
        });

        // Convert the image to a base64 URL.
        final imageBytes = await image.readAsBytes();
        _base64Url = base64Encode(imageBytes);

        // Call the `onImageSelected` callback function with the base64 URL.
        onImageSelected(_base64Url!);

        // Print the base64 URL to the debug console.
        debugPrint('Base64 URL: $_base64Url');
      }
    }
  }

  // 1. Define source
  // 2. User ImagePicker().pickImage
  // 3. Store the image

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormController>(
      builder: (formInstance) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(children: [
            Row(
              children: [
                Text(
                  "Q:",
                  style: Get.textTheme.bodyLarge!
                      .copyWith(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: Get.width * 0.8,
                  child: RichText(
                    text: TextSpan(
                        text: widget.question,
                        style: Get.textTheme.bodyLarge!
                            .copyWith(fontSize: 16, color: Colors.black),
                        children: widget.isRequired
                            ? [
                                TextSpan(
                                  text: ' *',
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                      fontSize: 16, color: Colors.red),
                                )
                              ]
                            : []),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            TextFormField(
              validator: (value) {
                if (widget.isRequired == true &&
                    (value == null || value == '')) {
                  return "This field is required.";
                }

                return null;
              },
              onSaved: widget.onSaved,
              onTap: () {
                // addController();
                pickImage;
                setState(() {
                  imageUrlController.text = _base64Url ?? 'null';
                });
              },
              controller: imageUrlController,
              readOnly: true,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        pickImage(
                          (url) {
                            setState(() {
                              imageUrlController.text = url;
                            });
                          },
                        );
                      },
                      icon: const Icon(Icons.add_a_photo))),
            ),
            SizedBox(
              height: 150,
              width: 150,
              child: _image != null
                  ? Stack(
                      children: [
                        Image.file(File(_image!.path)),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.purpleAccent,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                                imageUrlController.clear();
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Text("No Image Selected"),
            ),
            ElevatedButton(
              onPressed: () {
                formInstance.addImageToList(_image!);
                Get.to(
                  const ProductsPage(pageName: "Prods Page"),
                  // arguments: {"pickedImage": _image}
                );
              },
              child: const Text('Send to next page'),
            ),
          ]),
        );
      },
    );
  }
}
