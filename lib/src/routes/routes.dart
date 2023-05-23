import 'package:nearby_nocard/app_exports.dart';

class AppRoutes {
  static const String authScreen = '/auth_screen';
  static const String homeScreen = "/home_screen";
  static const String formScreen = '/form_screen';

  static String get initialRoute =>
      FirebaseAuth.instance.currentUser == null ? authScreen : homeScreen;
}
