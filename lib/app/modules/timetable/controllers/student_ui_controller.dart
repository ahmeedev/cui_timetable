import 'dart:developer';

import '../../settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';

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

    final box1 = await Hive.openBox(DBNames.timetableCache);
    final box2 = await Hive.openBox(DBNames.timetableData);

    // box.clear();
    try {
      String value =
          box1.get(DBTimetableCache.studentSection, defaultValue: "");
      if (value.isNotEmpty) {
        string = value.toString();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    textController.text = string;

    searchBy.value = Get.find<SettingsController>().searchBy;
    if (searchBy["list"] == true) {
      // fetching cached tokens
      overallTokens =
          await box2.get(DBTimetableData.overallTokens, defaultValue: []);
      yearTokens = await box2.get(DBTimetableData.yearTokens, defaultValue: []);
      sectionTokens =
          await box2.get(DBTimetableData.sectionTokens, defaultValue: []);
      sectionVariantsTokens = await box2
          .get(DBTimetableData.sectionVariantsTokens, defaultValue: []);

      log(yearTokens.toString());
      log(sectionTokens.toString());
      log(sectionVariantsTokens.toString());

      yearTokenSelected.value = await box1
          .get(DBTimetableCache.studentYearToken, defaultValue: yearTokens[0]);
      sectionTokenSelected.value = await box1.get(
          DBTimetableCache.studentSecToken,
          defaultValue: sectionTokens[0]);
      sectionVariantsTokenSelected.value = await box1.get(
          DBTimetableCache.studentSecVToken,
          defaultValue: sectionVariantsTokens[0]);

      log(yearTokenSelected.value);
      log(sectionTokenSelected.value);
      log(sectionVariantsTokenSelected.value);
      changeSectionTokens(yearTokens[0],
          sectionToken: "", sectionVariantToken: "");
    }

    super.onInit();
  }

  Future<void> fetchSections() async {
    final box = await Hive.openBox(DBNames.timetableData);
    final list = box.get(DBTimetableData.sections);
    sections = list ?? [];
  }

  void changeSectionTokens(String value,
      {sectionToken = "", sectionVariantToken = ""}) async {
    // sectionTokens.clear();
    // sectionVariantsTokens.clear();
    final sections = <String>{};
    for (var element in overallTokens) {
      if (element[0].toString().contains(value)) {
        sections.add(element[1]);
      }
    }

    sectionTokens = sections.toList();
    sectionTokenSelected.value =
        sectionToken == "" ? sectionTokens[0] : sectionToken;

    changeSectionVariantsTokens(
        sectionVariantToken == "" ? sectionTokenSelected.value : sectionToken,
        sectionVariantToken: sectionVariantToken);
  }

  void changeSectionVariantsTokens(String value,
      {sectionVariantToken = ""}) async {
    // sectionVariantsTokens.clear();
    final sectionsVariants = <String>{};
    for (var element in overallTokens) {
      if (element[0] == yearTokenSelected.value && element[1] == value) {
        sectionsVariants.add(element[2]);
      }
    }
    sectionVariantsTokens = sectionsVariants.toList();
    sectionVariantsTokenSelected.value = sectionVariantToken == ""
        ? sectionVariantsTokens[0]
        : sectionVariantToken;
  }
}
