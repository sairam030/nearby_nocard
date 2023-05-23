import 'package:firebase_auth/firebase_auth.dart';

import '../../../app_exports.dart';

class AuthScreen extends GetView<AuthScreenController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(

        actions: [
          AuthStateChangeAction<SignedIn>((context, state) async {
            Get.offAndToNamed(AppRoutes.homeScreen);
          }),
          AuthStateChangeAction<UserCreated>((context, state) async {
            await controller.buildUserCreatedDialog(context);
          }),
        ],
      ),
    );
  }
}
