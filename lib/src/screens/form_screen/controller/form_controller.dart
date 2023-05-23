import 'package:nearby_nocard/app_exports.dart';

class FormController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final roleController = TextEditingController();

  final mailController = TextEditingController();

  void submit() {
    // Implement form submission logic here
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    roleController.dispose();
    mailController.dispose();
    super.dispose();
  }
}
