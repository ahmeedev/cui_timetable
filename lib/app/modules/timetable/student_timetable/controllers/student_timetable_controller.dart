import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import '../../../../data/database/database_constants.dart';
import '../../../../data/models/timetable/student_timetable/student_timetable.dart';

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
  var tueLectures = {};
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

    List<StudentTimetable> list =
        List.from(box.get(DBTimetableData.studentsData)[section.toLowerCase()]);
    // final log = Logger();
    // log.d(list.runtimeType);
    await _setLectures(list: list, key: "10000");
    await _setLectures(list: list, key: "1000");
    await _setLectures(list: list, key: "100");
    await _setLectures(list: list, key: "10");
    await _setLectures(list: list, key: "1");

    daywiseLectures.value = monLectures; //* For default purpose

    yield lecturesCount;
  }

  _setLectures({required List<StudentTimetable> list, required String key}) {
    if (key == "10000") {
      List<StudentTimetable> lectures =
          list.where((element) => element.day == key).toList();

      lectures.sort((a, b) => a.slot.compareTo(b.slot));
      final result = _calculateCombineIndexes(lectures);

      monLectures['lectures'] = lectures;
      monLectures['combineIndexes'] = result['combineIndexes'];
      monLectures['actualTileIndexes'] = result['actualTileIndexes'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "1000") {
      List<StudentTimetable> lectures =
          list.where((element) => element.day.toString() == key).toList();
      lectures.sort((a, b) => a.slot.compareTo(b.slot));

      final result = _calculateCombineIndexes(lectures);

      tueLectures['lectures'] = lectures;
      tueLectures['combineIndexes'] = result['combineIndexes'];
      tueLectures['actualTileIndexes'] = result['actualTileIndexes'];

      // lecturesCount[key] = tueLectures.length.toString();
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "100") {
      List<StudentTimetable> lectures =
          list.where((element) => element.day.toString() == key).toList();
      lectures.sort((a, b) => a.slot.compareTo(b.slot));
      final result = _calculateCombineIndexes(lectures);
      wedLectures['lectures'] = lectures;
      wedLectures['combineIndexes'] = result['combineIndexes'];
      wedLectures['actualTileIndexes'] = result['actualTileIndexes'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "10") {
      List<StudentTimetable> lectures =
          list.where((element) => element.day.toString() == key).toList();
      lectures.sort((a, b) => a.slot.compareTo(b.slot));

      final result = _calculateCombineIndexes(lectures);

      thuLectures['lectures'] = lectures;
      thuLectures['combineIndexes'] = result['combineIndexes'];
      thuLectures['actualTileIndexes'] = result['actualTileIndexes'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "1") {
      List<StudentTimetable> lectures =
          list.where((element) => element.day.toString() == key).toList();
      lectures.sort((a, b) => a.slot.compareTo(b.slot));

      final result = _calculateCombineIndexes(lectures);

      friLectures['lectures'] = lectures;
      friLectures['combineIndexes'] = result['combineIndexes'];
      friLectures['actualTileIndexes'] = result['actualTileIndexes'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    }
  }

  Map<String, dynamic> _calculateCombineIndexes(
      List<StudentTimetable> lectures) {
    var list1 = [];
    var actualTileIndexes = [];
    // list2.contains(2);
    for (var i = 0; i < lectures.length; i++) {
      if (i != lectures.length - 1) {
        if (lectures[i].subject == lectures[i + 1].subject &&
            lectures[i].teacher == lectures[i + 1].teacher) {
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
