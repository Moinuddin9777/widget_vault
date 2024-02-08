import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickercontroller extends GetxController{
  String selectedImagepath="";
  final ImagePicker _picker=ImagePicker() ;

  
  
  Future<void> pickImage(ImageSource source)async{
    final _PickedFile=await _picker.pickImage(source: source);
    if(_PickedFile != null){
      selectedImagepath=_PickedFile.path;
      update();
    }
  }

  
 }
 
 