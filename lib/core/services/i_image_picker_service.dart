import 'package:image_picker/image_picker.dart';

abstract class IImagePickerService{
/// Get images
  Future<XFile?> getImg();

  ///Get images
  Future<List<XFile>?> getImages();

}