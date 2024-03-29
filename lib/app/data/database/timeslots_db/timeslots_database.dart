import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import '../database_constants.dart';
import '../database_utilities_methods.dart';
import '../../models/timetable_model.dart';

class TimeslotsDatabase {
  Future<bool> createDatabase() async {
    await downloadFile(
        fileName: 'timetable.json', callback: insertTimeslotsData, csv: false);
    return Future.value(true);
  }
}

//! All the code run in working Isolate, Be aware

void insertTimeslotsData(
    {required String filePath, required String data}) async {
  Hive.init(filePath); // initialize the data, bcz of their separate isolate.
  await deleteData();
  final json = jsonDecode(data);
  final timetable = TimetableSlots.fromJson(json);
  final lectures = timetable.lectures;
  final monToThursList = [
    lectures!.monToThurs!.s1.toString(),
    lectures.monToThurs!.s2.toString(),
    lectures.monToThurs!.s3.toString(),
    lectures.monToThurs!.s4.toString(),
    lectures.monToThurs!.s5.toString(),
  ];

  final firList = [
    lectures.fri!.s1.toString(),
    lectures.fri!.s2.toString(),
    lectures.fri!.s3.toString(),
    lectures.fri!.s4.toString(),
    lectures.fri!.s5.toString(),
  ];
  final box = await Hive.openBox(DBNames.timeSlots);
  box.put(DBTimeSlots.monToThur, monToThursList);
  box.put(DBTimeSlots.fri, firList);
  await Future.delayed(const Duration(milliseconds: 200));
  await box.close();
  await Future.delayed(const Duration(milliseconds: 200));
}

Future<void> deleteData() async {
  var box = await Hive.openBox(DBNames.timeSlots);
  try {
    // box.deleteAll([DBTimeSlots.monToThur, DBTimeSlots.fri]);
    await box.clear();
  } catch (e) {
    debugPrint(e.toString());
  } finally {
    box.close();
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
