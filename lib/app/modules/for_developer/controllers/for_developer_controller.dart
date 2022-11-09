import 'package:cui_timetable/app/modules/sync/controllers/sync_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ForDeveloperController extends GetxController {
  Future<String> getId() async {
    String? uid;
    // String? deviceId;
    try {
      // deviceId = await PlatformDeviceId.getDeviceId;
      uid = FirebaseAuth.instance.currentUser!.uid;
      // print(uid);
    } on PlatformException {
      // deviceId = 'Failed to get deviceId.';
      uid = "You must be signIn in order to proceed";
    }
    // return deviceId.toString();
    return uid.toString();
  }

  syncAllFiles() async {
    await Get.find<SyncController>().syncAllFiles();
  }
}
