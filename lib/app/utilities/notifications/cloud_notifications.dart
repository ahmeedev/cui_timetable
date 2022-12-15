import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> sendNotification(
    {required String topic,
    required String title,
    required String description}) async {
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
  return Future.value(result);
}
