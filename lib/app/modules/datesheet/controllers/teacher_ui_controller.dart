import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';

class DatesheetTeacherUIController extends GetxController {
  var teachers = [];
  final TextEditingController textController = TextEditingController();
  var filteredList = [].obs;
  var listVisible = true.obs;
  var dialogHistoryList = [].obs;

  @override
  Future<void> onInit() async {
    await fetchTeachers();
    var string = '';

    final box = await Hive.openBox(DBNames.info);
    try {
      String value = box.get(DBInfo.datesheetSearchTeacher, defaultValue: "");
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
    final list = await box.get(DBInfo.datesheetTeachers);
    teachers = list ?? [];
  }
}
