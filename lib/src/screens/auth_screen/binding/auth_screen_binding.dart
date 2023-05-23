
import 'package:nearby_nocard/app_exports.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthScreenController());
  }
}
