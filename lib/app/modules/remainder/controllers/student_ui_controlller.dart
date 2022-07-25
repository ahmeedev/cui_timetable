import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';

class RemainderStudentUIController extends GetxController {
  var sections = [];
  final TextEditingController textController = TextEditingController();
  var filteredList = [].obs;
  var listVisible = true.obs;
  // var dialogHistoryList = [].obs;

  @override
  Future<void> onInit() async {
    await fetchSections();

    // var string = '';

    // final box = await Hive.openBox(DBNames.info);
    // try {
    //   String value = box.get(DBInfo.datesheetSearchSection, defaultValue: "");
    //   if (value.isNotEmpty) {
    //     string = value.toString();
    //   }
    // } catch (e) {
    //   debugPrint(e.toString());
    // }

    // textController.text = string;

    super.onInit();
  }

  Future<void> fetchSections() async {
    final box = await Hive.openBox(DBNames.timetableData);
    final list = await box.get(DBTimetableData.sections);

    sections = list ?? [];
  }
}
