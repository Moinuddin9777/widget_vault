import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_vault/placeholder_data.dart';

class FormController extends GetxController {
  List<XFile> imagesList = pickedImages;

  addImageToList(XFile image) {
    pickedImages.add(image);
    update();
  }
}
