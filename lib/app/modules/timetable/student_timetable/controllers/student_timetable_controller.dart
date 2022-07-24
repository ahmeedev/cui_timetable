import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/database_constants.dart';

class StudentTimetableController extends GetxController {
  var monToThursSlots = [];
  var friSlots = [];
  var currentTimeSlots = [];

  var mon = true.obs; //* mon is selected by default
  var tue = false.obs;
  var wed = false.obs;
  var thu = false.obs;
  var fri = false.obs;

  var daywiseLectures = {}.obs; //* Current day lectures.

  var monLectures = {};
  // var tueLectures = [];
  Map tueLectures = {};
  var wedLectures = {};
  var thuLectures = {};
  var friLectures = {};
  var lecturesCount = <String, String>{}.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final box = await Hive.openBox(DBNames.timeSlots);
    currentTimeSlots = monToThursSlots = await box.get(DBTimeSlots.monToThur);
    friSlots = await box.get(DBTimeSlots.fri);
  }

  // Methods for Controlling DayTile.
  void allFalse() {
    mon.value = false;
    tue.value = false;
    wed.value = false;
    thu.value = false;
    fri.value = false;
  }

  giveValue(index) {
    if (index == 0) {
      return mon;
    } else if (index == 1) {
      return tue;
    } else if (index == 2) {
      return wed;
    } else if (index == 3) {
      return thu;
    } else {
      return fri;
    }
  }

  // Methods for controlling LectureTile
  openBox({required String section}) async* {
    final box = await Hive.openBox(DBNames.timetableData);

    final list = box.get(DBTimetableData.studentsData)[section.toLowerCase()];
    await _setLectures(list: list, key: "10000");
    await _setLectures(list: list, key: "1000");
    await _setLectures(list: list, key: "100");
    await _setLectures(list: list, key: "10");
    await _setLectures(list: list, key: "1");

    daywiseLectures.value = monLectures; //* For default purpose

    yield lecturesCount;
  }

  _setLectures({required list, required String key}) {
    if (key == "10000") {
      List lectures =
          list.where((element) => element[3].toString() == key).toList();
      lectures.sort((a, b) => a[2].compareTo(b[2]));
      final result = _calculateCombineIndexes(lectures);

      monLectures['lectures'] = lectures;
      monLectures['combineIndexes'] = result['combineIndexes'];
      monLectures['actualTileIndexes'] = result['actualTileIndexes'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "1000") {
      List lectures =
          list.where((element) => element[3].toString() == key).toList();
      debugPrint(lectures[0][2].runtimeType.toString());
      lectures.sort((a, b) => a[2].compareTo(b[2]));

      final result = _calculateCombineIndexes(lectures);

      tueLectures['lectures'] = lectures;
      tueLectures['combineIndexes'] = result['combineIndexes'];
      tueLectures['actualTileIndexes'] = result['actualTileIndexes'];

      // lecturesCount[key] = tueLectures.length.toString();
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "100") {
      List lectures =
          list.where((element) => element[3].toString() == key).toList();
      lectures.sort((a, b) => a[2].compareTo(b[2]));
      final result = _calculateCombineIndexes(lectures);
      wedLectures['lectures'] = lectures;
      wedLectures['combineIndexes'] = result['combineIndexes'];
      wedLectures['actualTileIndexes'] = result['actualTileIndexes'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "10") {
      List lectures =
          list.where((element) => element[3].toString() == key).toList();
      lectures.sort((a, b) => a[2].compareTo(b[2]));

      final result = _calculateCombineIndexes(lectures);

      thuLectures['lectures'] = lectures;
      thuLectures['combineIndexes'] = result['combineIndexes'];
      thuLectures['actualTileIndexes'] = result['actualTileIndexes'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "1") {
      List lectures =
          list.where((element) => element[3].toString() == key).toList();

      final result = _calculateCombineIndexes(lectures);

      friLectures['lectures'] = lectures;
      friLectures['combineIndexes'] = result['combineIndexes'];
      friLectures['actualTileIndexes'] = result['actualTileIndexes'];
      lectures.sort((a, b) => a[2].compareTo(b[2]));
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    }
  }

  Map<String, dynamic> _calculateCombineIndexes(List<dynamic> lectures) {
    var list1 = [];
    var actualTileIndexes = [];
    // list2.contains(2);
    for (var i = 0; i < lectures.length; i++) {
      if (i != lectures.length - 1) {
        if (lectures[i][1] == lectures[i + 1][1] &&
            lectures[i][4] == lectures[i + 1][4]) {
          list1.add(i);
          actualTileIndexes.add(i);
          list1.add(i + 1);
        }
      }
    }
    return {"combineIndexes": list1, "actualTileIndexes": actualTileIndexes};
  }

  void getLectures({required String key}) {
    if (key == "10000") {
      daywiseLectures.value = monLectures;
    } else if (key == "1000") {
      // daywiseLectures.value = tueLectures;
      daywiseLectures.value = tueLectures;
    } else if (key == "100") {
      daywiseLectures.value = wedLectures;
    } else if (key == "10") {
      daywiseLectures.value = thuLectures;
    } else if (key == "1") {
      daywiseLectures.value = friLectures;
    }
  }
}
