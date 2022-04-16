import 'dart:developer' as devlog;

import 'package:cui_timetable/controllers/csv/csv_controller.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseController extends GetxController {
  final _csvController = Get.find<CsvController>();

  void insertData() async {
    final csvData = await _csvController.loadCSV();
    final sections = await _csvController.fetchSections(csvData);

    // inserting info into hive database
    final box = await Hive.openBox('info');
    box.put('sections', sections.toList());

    int counter = 0;
    for (var i in sections) {
      final storage = await Hive.openBox('$i');
      // print('$i created ${counter}');
      counter++;
    }

    counter = 0;
    for (var i in csvData) {
      final storage = Hive.box(i[0]);
      storage.put('lec$counter', [
        i[1].toString(),
        i[2].toString(),
        i[3].toString(),
        i[4].toString(),
        i[5].toString()
      ]);
      counter++;
    }

    Hive.close();
    devlog.log('Data inserted Successfully...', name: "HIVE");
  }

  void deleteBoxes() {
    Hive.deleteFromDisk();
    devlog.log('Data deleted Successfully...', name: "HIVE");
  }
}
