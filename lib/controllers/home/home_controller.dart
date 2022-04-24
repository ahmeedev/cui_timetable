import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  var status = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          Get.dialog(const Text('hello'));

          print('terminated state');

          if (message.data['update'] != null) {
            final box = await Hive.openBox('info');
            box.put('info', false);
          }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) async {
        if (message.notification != null) {
          Get.dialog(const Text('hello'));

          if (message.data["update"]) {
            final box = await Hive.openBox('info');
            box.put('info', false);
            Get.defaultDialog(
                title: 'Update Available',
                middleText: 'Synchronized to get latest updates',
                onCancel: () {},
                onConfirm: () {},
                textConfirm: "Synchronized");
          }
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        if (message.notification != null) {
          Get.dialog(const Text('hello'));
          final box = await Hive.openBox('info');
          box.put('info', false);
        }
      },
    );

    FlutterNativeSplash.remove();
  }
}
