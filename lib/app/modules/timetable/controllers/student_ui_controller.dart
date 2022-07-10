import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';

class StudentUIController extends GetxController {
  var sections = [];
  final TextEditingController textController = TextEditingController();
  var filteredList = [].obs;
  var listVisible = true.obs;
  var dialogHistoryList = [].obs;

  var searchBy = {}.obs;
  var yearTokens = [];
  var overallTokens = [];
  var sectionTokens = [];
  var sectionVariantsTokens = [];

  var yearTokenSelected = ''.obs;
  var sectionTokenSelected = ''.obs;
  var sectionVariantsTokenSelected = ''.obs;

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

    var box2 = await Hive.openBox(DBNames.settings);
    searchBy.value = await box2.get(DBSettings.searchBy);
    if (searchBy["list"] == true) {
      final box3 = await Hive.openBox(DBNames.general);
      yearTokens = await box3.get(DBGeneral.yearTokens);
      overallTokens = await box3.get(DBGeneral.overallTokens);

      yearTokenSelected.value = yearTokens[0];
      changeSectionTokens(yearTokens[0]);
      changeSectionVariantsTokens(sectionTokenSelected.value);
    }

    super.onInit();
  }

  Future<void> fetchSections() async {
    final box = await Hive.openBox(DBNames.info);
    final list = box.get(DBInfo.sections);
    sections = list ?? [];
  }

  void changeSectionTokens(String value) {
    sectionTokens.clear();
    sectionVariantsTokens.clear();
    final sections = <String>{};
    for (var element in overallTokens) {
      if (element[0].toString().contains(value)) {
        sections.add(element[1]);
      }
    }

    sectionTokens = sections.toList();
    sectionTokenSelected.value = sectionTokens[0];

    changeSectionVariantsTokens(sectionTokenSelected.value);
  }

  void changeSectionVariantsTokens(String value) {
    sectionVariantsTokens.clear();
    final sectionsVariants = <String>{};
    for (var element in overallTokens) {
      if (element[0] == yearTokenSelected.value && element[1] == value) {
        sectionsVariants.add(element[2]);
      }
    }
    sectionVariantsTokens = sectionsVariants.toList();
    sectionVariantsTokenSelected.value = sectionVariantsTokens[0];
  }
}
