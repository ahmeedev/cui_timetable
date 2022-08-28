import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/database_constants.dart';
import '../../../../data/models/timetable/student_timetable/student_timetable.dart';

class StudentRemainderController extends GetxController {
  var monToThursSlots = <String>[];
  var friSlots = <String>[];
  var currentTimeSlots = [];
  List<StudentTimetable> sectionDetails = [];
  @override
  Future<void> onInit() async {
    final boxx = await Hive.openBox(DBNames.timeSlots);
    monToThursSlots = boxx.get(DBTimeSlots.monToThur);
    friSlots = boxx.get(DBTimeSlots.fri);
    currentTimeSlots = monToThursSlots;
    super.onInit();
  }

  // return [List] of the [StudentTimetable].
  Future<List> getDetails() async {
    // print("Running");
    final box = await Hive.openBox(DBNames.timetableData);
    List<StudentTimetable> list = sectionDetails = List.from(box.get(
        DBTimetableData.studentsData)[Get.arguments["section"].toLowerCase()]);

    final filteredData = [];
    for (var i = 0; i < list.length; i++) {
      if (i == 0) {
        filteredData.add([list[i].subject, list[i].teacher]);
      } else {
        if (_checkData(value: list[i].subject, list: filteredData)) {
          filteredData.add([list[i].subject, list[i].teacher]);
        }
      }
    }
    // await Future.delayed(const Duration(seconds: 10));
    return Future.value(filteredData);
  }

  /// return [bool] if the required data is available in list.
  _checkData({required String value, required List list}) {
    for (var i = 0; i < list.length; i++) {
      if (value
              .trim()
              .toLowerCase()
              .compareTo(list[i][0].trim().toLowerCase()) ==
          0) {
        return false;
      }
    }
    return true;
  }

  setRemainder({required String subject}) {
    //TODO: set the current time slot when they are friday. rememeber.
    dev.log(currentTimeSlots.toString());
    for (var element in sectionDetails) {
      if (element.subject.toLowerCase().compareTo(subject.toLowerCase()) == 0) {
        // dev.log(element.day);
        dev.log(currentTimeSlots[element.slot - 1].toString());
      }
    }
  }
}
