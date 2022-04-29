import 'dart:async';

import 'package:cui_timetable/controllers/sync/sync_controller.dart';
import 'package:cui_timetable/models/utilities/get_utilities.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var status = false.obs;
  var first = 10.0.obs;
  var second = 10.0.obs;
  late Timer timer;
  late AnimationController controller;

  @override
  Future<void> onInit() async {
    super.onInit();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2000,
      ),
    )..repeat();

    final box = await Hive.openBox('info');
    var value = box.get('new_user').toString();
    // box.delete('new_user');

    print(value);
    if (value == '' || value == 'null') {
      GetXUtilities.dialog();
      await _syncData();
    }
    // print(box.put('last_update', ''));

    // timer = Timer.periodic(
    //   const Duration(milliseconds: 1000),
    //   (timer) {
    //     first.value += 10;
    //     second.value += 10;
    //     print('ma hu khalayak');
    //   },
    // );

    // FirebaseMessaging.instance.getInitialMessage().then(
    //   (message) async {
    //     print("FirebaseMessaging.instance.getInitialMessage");
    //     if (message != null) {
    //       Get.dialog(const Text('hello'));

    //       print('terminated state');

    //       if (message.data['update'] != null) {
    //         final box = await Hive.openBox('info');
    //         box.put('info', false);
    //       }
    //     }
    //   },
    // );

    // // 2. This method only call when App in forground it mean app must be opened
    // FirebaseMessaging.onMessage.listen(
    //   (message) async {
    //     if (message.notification != null) {
    //       Get.dialog(const Text('hello'));

    //       if (message.data["update"]) {
    //         final box = await Hive.openBox('info');
    //         box.put('info', false);
    //         Get.defaultDialog(
    //             title: 'Update Available',
    //             middleText: 'Synchronized to get latest updates',
    //             onCancel: () {},
    //             onConfirm: () {},
    //             textConfirm: "Synchronized");
    //       }
    //     }
    //   },
    // );

    // // 3. This method only call when App in background and not terminated(not closed)
    // FirebaseMessaging.onMessageOpenedApp.listen(
    //   (message) async {
    //     if (message.notification != null) {
    //       Get.dialog(const Text('hello'));
    //       final box = await Hive.openBox('info');
    //       box.put('info', false);
    //     }
    //   },
    // );

    FlutterNativeSplash.remove();
  }

  Future<bool> _syncData() {
    final controller = SyncController();
    controller.syncData(dialogPop: true);
    return Future.value(true);
  }
}
