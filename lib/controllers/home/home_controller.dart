import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print('terminated state');
          _update();
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) async {
        if (message.notification != null) {
          if (message.data["update"] == "true") {
            print('Hello there');
            Get.defaultDialog(
                title: 'Update Available',
                middleText: 'Synchronized to get latest updates',
                onCancel: () {},
                onConfirm: () {},
                textConfirm: "Synchronized");
            _update();
          }
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.notification != null) {
          print('background');
          _update();
        }
      },
    );

    FlutterNativeSplash.remove();
  }

  _update() async {
    final box = await Hive.openBox('update');
    box.put("status", "true");
    print('update set');
  }
}
