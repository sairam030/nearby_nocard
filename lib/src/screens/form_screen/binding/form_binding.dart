import 'package:nearby_nocard/app_exports.dart';

class FormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FormController());
  }
}
