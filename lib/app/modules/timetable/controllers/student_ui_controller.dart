// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:cui_timetable/app/data/database/database_constants.dart';

class StudentUIController extends GetxController {
  var sections = [];
  final TextEditingController textController = TextEditingController();
  var filteredList = [].obs;
  var listVisible = true.obs;
  var dialogHistoryList = [].obs;

  @override
  Future<void> onInit() async {
    await fetchSections();
    var string = '';

    final box = await Hive.openBox(DBNames.info);
    try {
      String value = box.get(DBInfo.searchSection, defaultValue: "");
      if (value.isNotEmpty) {
        string = value.toString();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    textController.text = string;

    super.onInit();
  }

  Future<void> fetchSections() async {
    final box = await Hive.openBox(DBNames.info);
    final list = box.get(DBInfo.sections);
    sections = list ?? [];
  }
}
