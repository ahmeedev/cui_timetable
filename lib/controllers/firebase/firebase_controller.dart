import 'dart:convert';
import 'dart:developer' as devlog;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Update the timetable in firebase.
  ///
  /// [data] from the admin controller.
  void updateLectures(List<dynamic> data) {
    if (data.isNotEmpty) {
      CollectionReference timetable =
          FirebaseFirestore.instance.collection('lectures');

      // Fetching sections from the list.
      final sections = <String>{};
      for (var item in data) {
        sections.add(item[0]);
      }
      // Section Fetched

      // Adding sections in firebase.
      // for (var item in sections) {
      //   timetable
      //       .doc(item)
      //       .set({'name': item})
      //       .then((value) => print("User Added"))
      //       .catchError((error) => print("Failed to add user: $error"));
      // }

      var sectionLecture =
          data.where((element) => element[0] == "FA19-BS(SE)-6-A");
      // print(sectionLecture);
      var dayLectures = sectionLecture
          .where((element) => element[3].toString() == "10000")
          .toList();
      // print(dayLectures);

    } else {
      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 2),
        title: "Error Occured!",
        message: "Select the file first",
      ));
    }
  }

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
