import 'package:nearby_nocard/app_exports.dart';

class ToastManager {
  static final ToastManager _instance = ToastManager._internal();

  factory ToastManager() {
    return _instance;
  }

  ToastManager._internal();

  void showToast(String message) {
    Fluttertoast.cancel().then((value) => Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        ));
  }
}
