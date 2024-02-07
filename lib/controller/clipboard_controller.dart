import 'package:get/get.dart';
import 'package:flutter/services.dart';

class ClipboardController extends GetxController {
  void copyToClipboard(String data) {
    Clipboard.setData(ClipboardData(text: data));
    Get.snackbar('Copied!', 'Data copied to clipboard');
  }
}
