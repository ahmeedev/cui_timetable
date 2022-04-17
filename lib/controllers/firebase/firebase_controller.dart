import 'dart:convert';
import 'dart:developer' as devlog;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// TimeSlots for all the days for flexibility reason.
  ///
  /// changes will be done at firebase console.
  void updateTime() {
    final days = ["mon", "tue", "wed", "thu", "fri"];
    final slots = [
      "08:00AM - 10:00AM",
      "10:00AM - 11:30AM",
      "11:30AM - 01:00PM",
      "01:30PM - 3:00PM",
      "03:00PM - 04:30PM"
    ];
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('time');
    for (var item in days) {
      timetable
          .doc(item)
          .set({
            'time': {
              "1": slots[0],
              "2": slots[1],
              "3": slots[2],
              "4": slots[3],
              "5": slots[4]
            }
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }
}
