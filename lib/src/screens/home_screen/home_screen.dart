import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:easyqrimage/easyqrimage.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nearby_nocard/app_exports.dart';
import 'package:nearby_connections/nearby_connections.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  // Future<void> scanBarcodeNormal(BuildContext context) async {
  //   String barcodeScanRes;
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //       '#ff6666',
  //       'Cancel',
  //       true,
  //       ScanMode.BARCODE,
  //     );
  //     print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(barcodeScanRes)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: buildAppBar(context),
        body: !controller.userInFirestore.value
            ? TabBarView(
                controller: controller.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  AdvertiseView(),
                  DiscoverView(),
                ],
              )
            : const CustomDialog(
                title: "Missing Data",
                message: "User Card Detail's not found",
                icon: Icons.credit_card_off,
              ),
      );
    });
  }

  Future<void> signout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
  //
  // Future<void> startBarcodeScanStream(BuildContext context) async {
  //   FlutterBarcodeScanner.getBarcodeStreamReceiver(
  //     '#ff6666',
  //     'Cancel',
  //     true,
  //     ScanMode.BARCODE,
  //   )?.listen((barcode) => print(barcode));
  // }
  //
  // Future<void> scanQR(BuildContext context) async {
  //   String barcodeScanRes;
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //       '#ff6666',
  //       'Cancel',
  //       true,
  //       ScanMode.QR,
  //     );
  //     print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(barcodeScanRes)),
  //   );
  // }



  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("NoCard"),
      leading: IconButton(
        icon: const Icon(Icons.exit_to_app),
        onPressed: () async {
          try {
            await signout();
            CustomDialog(
                title: "${GoogleSignIn().currentUser?.displayName} logged out!",
                icon: Icons.check_circle_outline_outlined,
                message: '',
                onTap: () {});
          } catch (e) {
            log("Error disconnecting from Google Sign-In: $e");

            // Handle the error gracefully, show an error message, or fallback behavior
            const CustomDialog(
              title: "Failed to disconnect from Google Sign-In",
              icon: Icons.error_outline,
              message: "Please try again later.",
            );
          }

          Get.offAndToNamed(AppRoutes.initialRoute);
        },
      ),
      actions: [
        // IconButton(
        //   icon: const Icon(Icons.enhance_photo_translate_rounded),
        //   onPressed: () {
        //     // scanBarcodeNormal(context);
        //     Navigator.of(context).push(
        //         MaterialPageRoute(
        //         builder: (context) => const BarcodeScannerWithController(),
        //   },
        // ),
        IconButton(
          icon: const Icon(Icons.enhance_photo_translate_rounded),
          onPressed: () async {
            String barcodeScanRes;
            try {
              barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                '#ff6666',
                'Cancel',
                true,
                ScanMode.BARCODE,
              );
              print(barcodeScanRes);
              // Process the scanned barcode here
            } on PlatformException {
              barcodeScanRes = 'Failed to get platform version.';
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(barcodeScanRes)),
            );
          },
        ),

        const SizedBox(
          width: 14,
        ),
      ],
      centerTitle: true,
      bottom: TabBar(
        controller: controller.tabController,
        onTap: (value) {
          value == 1
              ? controller.enableDiscover.value = true
              : controller.enableAdvertise.value = true;
        },
        tabs: const [
          Tab(
            text: "Advertise",
          ),
          Tab(
            text: "Discover",
          ),
        ],
      ),
    );
  }
}

class AdvertiseView extends GetView<HomeController> {
  const AdvertiseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Center(
                child: SizedBox(
                  height: Get.height * 0.6,
                  width: Get.width * 0.8,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.toggleContainerVisibility();
                        },
                        child: Visibility(
                          visible: !controller.isContainerVisible.value,
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  CircleAvatar(
                                    foregroundImage: NetworkImage(
                                        FirebaseAuth.instance.currentUser
                                                ?.photoURL ??
                                            "https://lh3.googleusercontent.com/a/AGNmyxbSzwgCTcekOkBUrlIrTqJh4FYfqfrJ0V69_veOXw=s192-c-rg-br100",
                                        scale: 5),
                                    maxRadius: 50,
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    FirebaseAuth.instance.currentUser
                                            ?.displayName ??
                                        "",
                                    style: const TextStyle(fontSize: 45),
                                  ),
                                  const Text(
                                    "Developer",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.toggleContainerVisibility();
                        },
                        child: Visibility(
                          visible: controller.isContainerVisible.value,
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  // Set the container color to blue
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    FirebaseAuth.instance.currentUser
                                            ?.displayName ??
                                        "",
                                    style: const TextStyle(fontSize: 45),
                                  ),
                                  const Text(
                                    "Developer",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: EasyQRImage(
                                      data: 'String',
                                      //Required
                                      size: 200,
                                      //Optional
                                      color: Colors.black,
                                      //Optional
                                      backgroundColor: Colors.white,
                                      //Optional
                                      margin: 5,
                                      //Optional
                                      quietZone: 4,
                                      //Optional
                                      format: Formats.png,
                                      //Optional
                                      charsetSource: Charsets.UTF8,
                                      //Optional
                                      charsetTarget: Charsets.UTF8,
                                      //Optional
                                      ECC: Ecc.High, //Optional
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(children: [
              const SizedBox(width: 60),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            shape: const CircleBorder(),
                            child: const Icon(Icons.remove_red_eye),
                            onPressed: () async {
                              await Get.bottomSheet(
                                Container(
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.transparent,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: ListViewBox(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 150),
              Switch(
                activeColor: Colors.lightBlueAccent,
                value: controller.enableAdvertise.value,
                onChanged: (value) async {
                  controller.enableAdvertise.value =
                      !controller.enableAdvertise.value;
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class DiscoverView extends GetView<HomeController> {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DiscoverList();
  }
}

// discover list view

class DiscoverList extends StatelessWidget {
  const DiscoverList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with the actual item count
      itemBuilder: (context, index) {
        // Customize the list item based on the index
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          // Add vertical spacing
          child: SizedBox(
            height: 100,
            width: 350,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blueGrey),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                        backgroundColor: Colors.green, maxRadius: 25),
                    const Text('  Name of the person'),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // functionality here
                        print('visible button tapped');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: const Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// bottom veiw show widget

class ListViewBox extends StatelessWidget {
  const ListViewBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with the actual item count
      itemBuilder: (context, index) {
        // Customize the list item based on the index
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          // Add vertical spacing
          child: SizedBox(
            height: 75,
            width: 350,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blueGrey),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                        backgroundColor: Colors.green, maxRadius: 25),
                    const Text('  Name of the person'),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // functionality here
                        print('Plus button tapped');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class for the qr code scanner
