import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';

class SectSectWidgetController extends GetxController {
  final TextEditingController section1Controller = TextEditingController();
  final TextEditingController section2Controller = TextEditingController();

  late final List<String> sections;
  var listVisible1 = true.obs;
  var listVisible2 = true.obs;
  late final Box box;
  var filteredList1 = [].obs;
  var filteredList2 = [].obs;

  @override
  Future<void> onInit() async {
    await fetchSections();

    final box1 = await Hive.openBox(DBNames.comparisonCache);
    section1Controller.text =
        box1.get(DBComparisonCache.section1, defaultValue: "");
    section2Controller.text =
        box1.get(DBComparisonCache.section2, defaultValue: "");
    super.onInit();
  }

  Future<void> fetchSections() async {
    final box = await Hive.openBox(DBNames.timetableData);
    final list = box.get(DBTimetableData.sections);
    sections = list ?? [];
  }
}
