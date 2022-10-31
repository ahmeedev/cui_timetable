import 'dart:convert';

import 'package:cui_timetable/app/modules/sync/controllers/sync_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'package:http/http.dart' as http;

class ForDeveloperController extends GetxController {
  Future<String> getId() async {
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    return deviceId.toString();
  }

  syncAllFiles() async {
    await Get.find<SyncController>().syncAllFiles();
  }

  sendNotification() async {
    final result = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'key=AAAAmoNHYFY:APA91bF6JSaQjsYhwcc5b5TbkkqgyfCWT468dM1H_NVZcWnpG7RVniY2Kzr2UsY6h6lY7AalesPHsl8q04QEfwmOCcAkydT4mCtwAa1XoD3THUn7-u98jpTi2KyCUyJmtbkqjbu1waKR'
      },
      body: jsonEncode(<String, dynamic>{
        "to": "/topics/all",
        "notification": {
          "body": "This is a Firebase Cloud Messaging Topic Message!",
          "title": "FCM Message"
        }
      }),
    );
    return result;
  }
}
