import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';

class TeacTeacWidgetController extends GetxController {
  final TextEditingController teacher1Controller = TextEditingController();
  final TextEditingController teacher2Controller = TextEditingController();

  late final List<String> teachers;
  var listVisible1 = true.obs;
  var listVisible2 = true.obs;
  late final Box box;
  var filteredList1 = [].obs;
  var filteredList2 = [].obs;

  @override
  Future<void> onInit() async {
    await fetchteachers();

    final box1 = await Hive.openBox(DBNames.comparisonCache);
    teacher1Controller.text =
        box1.get(DBComparisonCache.teacher1, defaultValue: "");
    teacher2Controller.text =
        box1.get(DBComparisonCache.teacher2, defaultValue: "");
    super.onInit();
  }

  Future<void> fetchteachers() async {
    final box = await Hive.openBox(DBNames.timetableData);
    final list = box.get(DBTimetableData.teachers);
    teachers = list ?? [];
  }
}
