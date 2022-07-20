import '../../../../objectbox.g.dart';
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

  late Store store;
  @override
  Future<void> onInit() async {
    await fetchSections();
    store = await openStore();

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
    final box = await Hive.openBox(DBNames.info);
    final list = await box.get(DBInfo.sections);

    sections = list ?? [];
  }
}
