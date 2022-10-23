// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';

class ComparisonController extends GetxController {
  var monToThursSlots = <String>[];
  var friSlots = <String>[];

  late final studentTimetable;
  late final teacherTimetable;

  @override
  Future<void> onInit() async {
    final boxx = await Hive.openBox(DBNames.timeSlots);
    monToThursSlots = boxx.get(DBTimeSlots.monToThur);
    friSlots = boxx.get(DBTimeSlots.fri);

    final box = await Hive.openBox(DBNames.timetableData);
    studentTimetable = await box.get(DBTimetableData.studentsData);
    teacherTimetable = await box.get(DBTimetableData.teachersData);

    super.onInit();
  }
}
