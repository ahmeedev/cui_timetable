import 'package:cui_timetable/app/modules/settings/controllers/settings_controller.dart';
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

    final box = await Hive.openBox(DBNames.timetableCache);
    try {
      String value = box.get(DBTimetableCache.studentSection, defaultValue: "");
      if (value.isNotEmpty) {
        string = value.toString();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    textController.text = string;

    searchBy.value = Get.find<SettingsController>().searchBy;
    if (searchBy["list"] == true) {
      final box3 = await Hive.openBox(DBNames.general);
      yearTokens = await box3.get(DBGeneral.yearTokens);
      overallTokens = await box3.get(DBGeneral.overallTokens);

      // fetching cached tokens
      final box4 = await Hive.openBox(DBNames.timetableCache);
      var yearToken = await box4.get(DBTimetableCache.studentYearToken,
          defaultValue: yearTokens[0]);
      var secToken =
          await box4.get(DBTimetableCache.studentSecToken, defaultValue: "");
      var secVToken =
          await box4.get(DBTimetableCache.studentSecVToken, defaultValue: "");

      print("Year token  $yearToken");
      print("sec token  $secToken");
      print("secb token  $secVToken");

      yearTokenSelected.value = yearToken;

      changeSectionTokens(yearToken,
          sectionToken: secToken, sectionVariantToken: secVToken);
    }

    super.onInit();
  }

  Future<void> fetchSections() async {
    final box = await Hive.openBox(DBNames.info);
    final list = box.get(DBInfo.sections);
    sections = list ?? [];
  }

  void changeSectionTokens(String value,
      {sectionToken = "", sectionVariantToken = ""}) async {
    sectionTokens.clear();
    sectionVariantsTokens.clear();
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
    sectionVariantsTokens.clear();
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
