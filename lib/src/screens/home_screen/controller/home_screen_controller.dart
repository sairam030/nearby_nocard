import 'package:nearby_nocard/app_exports.dart';

import '../../../models/user.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool enableAdvertise = false.obs;
  RxBool enableDiscover = false.obs;
  RxDouble opacity = 1.0.obs;
  RxBool userInFirestore = false.obs;
  Rx<NoCardUsers> user = NoCardUsers(email: '', uid: '' ).obs;
  // function to assing user to user.value in the controller using firestore service getUserData and email is firebase auth.currentUser.email
  //  assignUser() async {
  //   user.value = await FirestoreService().getUserData(email: FirebaseAuth.instance.currentUser!.email!);

  RxBool isContainerVisible = false.obs;

  void toggleContainerVisibility() {
    isContainerVisible.value = !isContainerVisible.value;
  }

  void swapOpacity() {
    opacity.value == 1.0 ? opacity.value = 0.0 : opacity.value = 1.0;
    update();
  }

  late TabController tabController;

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    _advertiseWorker();
    _discoverWorker();
  }

  Worker _advertiseWorker() {
    return ever(enableAdvertise, (value) {
      if (value == true) {
        enableDiscover.value = false;
      }
      ToastManager().showToast("Advertise Status: $value");
    });
  }

  Worker _discoverWorker() {
    return ever(enableDiscover, (value) {
      if (value == true) {
        enableAdvertise.value = false;
      }
      ToastManager().showToast("Discover Status: $value");
    });
  }

  void startAdvertising() {}

  void startDiscovering() {}
}



