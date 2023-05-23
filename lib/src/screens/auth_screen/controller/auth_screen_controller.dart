import 'package:nearby_nocard/app_exports.dart';

class AuthScreenController extends GetxController {
  Future<dynamic> buildUserCreatedDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Signup Done',
        icon: Icons.check_circle_outline,
        message: "New User created let's login now.",
        onTap: () {
          Get.offAndToNamed(AppRoutes.authScreen);
        },
      ),
    );
  }

  @override
  void onReady() {}
}
