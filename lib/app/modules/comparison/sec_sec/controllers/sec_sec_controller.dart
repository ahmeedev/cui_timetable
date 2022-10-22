import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/database_constants.dart';

class SecSecController extends GetxController {
  final section1 = Get.arguments["section1"];
  final section2 = Get.arguments["section2"];

  final results = <String, List<int>>{};
  final days = ["10000", "1000", "100", "10", "1"];

  late final Future<Map> future;
  @override
  void onInit() {
    future = calculate();
    super.onInit();
  }

  Future<Map> calculate() async {
    final box = await Hive.openBox(DBNames.timetableData);
    final list = await box.get(DBTimetableData.studentsData);
    final sec1Lectures = list[section1.toLowerCase()];
    final sec2Lectures = list[section2.toLowerCase()];

    for (var element in days) {
      final dayWiseSec1 =
          sec1Lectures.where((element2) => element2.day == element).toList();
      final dayWiseSec2 =
          sec2Lectures.where((element2) => element2.day == element).toList();

      final sec1Slots = [];
      for (var element in dayWiseSec1) {
        sec1Slots.add(element.slot);
      }
      final sec2Slots = [];
      for (var element in dayWiseSec2) {
        sec2Slots.add(element.slot);
      }
      sec1Slots.sort();
      sec2Slots.sort();

      // print(sec2Slots);

      final common = <int>[];
      // check the common elements in five slots
      for (var i = 1; i <= 5; i++) {
        if (!(sec1Slots.contains(i) || sec2Slots.contains(i))) {
          common.add(i);
        }
      }

      // print(common);
      results[element] = common;
    }
    return Future.value(results);
  }
}
