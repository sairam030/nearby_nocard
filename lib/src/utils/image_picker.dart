import 'package:image_picker/image_picker.dart';
import 'package:nearby_nocard/app_exports.dart';

Future<String?> pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile == null) {
    return "No Image";
  }

  final bytes = await pickedFile.readAsBytes();
  final base64 = base64Encode(bytes);

  return base64;
}
