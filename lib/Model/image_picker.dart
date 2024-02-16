// image_picker_controller.dart

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();
  RxString imagePath = ''.obs;

  Future<void> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imagePath.value = pickedFile.path;
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
  /// Firebase Storage

}
