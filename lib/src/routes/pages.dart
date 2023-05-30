import '../../app_exports.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
        name: AppRoutes.homeScreen,
        page: () {
          return  HomeScreen();
        },
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.authScreen,
        page: () => const AuthScreen(),
        binding: AuthBinding()),
    GetPage(
        name: AppRoutes.formScreen,
        page: () => FormScreen(),
        binding: FormBinding()),
  ];
}
