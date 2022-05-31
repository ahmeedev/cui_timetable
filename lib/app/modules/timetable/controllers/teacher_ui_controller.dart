// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:cui_timetable/app/data/database/database_constants.dart';

class TeacherUIController extends GetxController {
  var teachers = [];
  final TextEditingController textController = TextEditingController();
  var filteredList = [].obs;
  var listVisible = true.obs;
  @override
  Future<void> onInit() async {
    await fetchTeachers();
    var string = '';

    final box = await Hive.openBox(DBNames.info);
    try {
      String value = box.get(DBInfo.searchTeacher, defaultValue: '');
      if (value.isNotEmpty) {
        string = value.toString();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    textController.text = string;

    super.onInit();
  }

  Future<void> fetchTeachers() async {
    final box = await Hive.openBox(DBNames.info);
    final list = box.get(DBInfo.teachers);
    teachers = list ?? [];
  }
}
