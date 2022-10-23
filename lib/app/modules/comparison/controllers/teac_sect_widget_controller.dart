import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';

class TeacSetWidgetController extends GetxController {
  final TextEditingController textController = TextEditingController();
  var listVisible = true.obs;
  late final Box box;
  var teachers = [];
  var filteredList = [].obs;

  var respectiveSections =
      <String>[' '].obs; //! blank for the null section droplist
  var dropBoxValue = ' '.obs;

  @override
  Future<void> onInit() async {
    await fetchTeachers();
    box = await Hive.openBox(DBNames.timetableData);

    var string = '';

    final box2 = await Hive.openBox(DBNames.comparisonCache);

    String value = box2.get(DBComparisonCache.searchTeacher, defaultValue: "");
    if (value.isNotEmpty) {
      string = value.toString();
      listTileTap(initialData: string);
    }

    textController.text = string;
    super.onInit();
  }

  Future<void> fetchTeachers() async {
    final box = await Hive.openBox(DBNames.timetableData);
    final list = box.get(DBTimetableData.teachers);
    teachers = list ?? [];
  }

  // Use for two purpose.
  // 1. When user open the UI, it gets the stored information. and,
  // 2. When user taps on search list tiles.
  listTileTap({int index = -1, String initialData = ""}) {
    final sections = <String>{};
    if (index != -1) {
      textController.text = filteredList[index];
      textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length));
      listVisible.value = false;

      List list = box.get(DBTimetableData.teachersData)[
          filteredList[index].toString().toLowerCase()];
      for (var element in list) {
        sections.add(element.section);
      }
    } else {
      List list =
          box.get(DBTimetableData.teachersData)[initialData.toLowerCase()];
      for (var element in list) {
        sections.add(element.section);
      }
    }
    respectiveSections.value = [];
    respectiveSections.value = sections.toList();
    dropBoxValue.value = sections.elementAt(0);
  }
}
