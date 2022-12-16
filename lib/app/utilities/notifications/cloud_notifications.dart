import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> sendCloudNotification({
  required String topic,
  required String title,
  required String description,
  bool toAdmin = false,
}) async {
  final result = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':
          'key=AAAAmoNHYFY:APA91bF6JSaQjsYhwcc5b5TbkkqgyfCWT468dM1H_NVZcWnpG7RVniY2Kzr2UsY6h6lY7AalesPHsl8q04QEfwmOCcAkydT4mCtwAa1XoD3THUn7-u98jpTi2KyCUyJmtbkqjbu1waKR'
    },
    body: jsonEncode(<String, dynamic>{
      "to": "/topics/$topic",
      "notification": {
        "title": title,
        "body": description,
      }
    }),
  );

  // store in admin db
  if (toAdmin) {
    await storeNotifiationInAdminDB(title: title, description: description);
  }
  return Future.value(result);
}

storeNotifiationInAdminDB(
    {required String title, required String description}) async {
  final db = FirebaseFirestore.instance;
  await db.collection('admin').doc("notifications").set({
    DateTime.now().toString(): {
      'title': title,
      'description': description,
      // 'isRead': false,
    },
  }, SetOptions(merge: true));
}
