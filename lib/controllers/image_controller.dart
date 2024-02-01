import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  RxString selectedImagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }
}

