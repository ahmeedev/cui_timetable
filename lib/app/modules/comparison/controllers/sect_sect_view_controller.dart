import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';

class SectSectViewController extends GetxController {
  final TextEditingController section1Controller = TextEditingController();
  final TextEditingController section2Controller = TextEditingController();

  late final List<String> sections;
  var listVisible = true.obs;
  late final Box box;
  var filteredList1 = [].obs;
  var filteredList2 = [].obs;

  @override
  Future<void> onInit() async {
    await fetchSections();
    super.onInit();
  }

  Future<void> fetchSections() async {
    final box = await Hive.openBox(DBNames.timetableData);
    final list = box.get(DBTimetableData.sections);
    sections = list ?? [];
  }
}
