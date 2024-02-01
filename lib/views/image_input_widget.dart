import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;
  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImage == null) return;
    setState(() {
      _selectImage = File(pickedImage.path);
    });
    widget.onPickImage(_selectImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: _selectImage == null
          ? TextButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text('Take Picture:'),
              onPressed: _takePicture,
            )
          : GestureDetector(
              onTap: _takePicture,
              child: Image.file(
                _selectImage!,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
    );
  }
}
