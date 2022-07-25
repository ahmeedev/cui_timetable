// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';

import '../../../../data/models/timetable/teacher_timetable/teacher_timetable.dart';

class TeacherTimetableController extends GetxController {
  var monToThursSlots = [];
  var friSlots = [];
  var currentTimeSlots = [];

  late final box;
  var mon = true.obs; //! mon is selected by default
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
    final box = await Hive.openBox(DBNames.timeSlots);
    currentTimeSlots = monToThursSlots = box.get(DBTimeSlots.monToThur);
    friSlots = box.get(DBTimeSlots.fri);
    super.onInit();
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
  openBox({required String teacher}) async* {
    box = await Hive.openBox(DBNames.timetableData);
    List<TeacherTimetable> list =
        List.from(box.get(DBTimetableData.teachersData)[teacher.toLowerCase()]);
    await _setLectures(list: list, key: "10000");
    await _setLectures(list: list, key: "1000");
    await _setLectures(list: list, key: "100");
    await _setLectures(list: list, key: "10");
    await _setLectures(list: list, key: "1");

    daywiseLectures.value = monLectures; //* For default purpose

    yield lecturesCount;
  }

  _setLectures({required List<TeacherTimetable> list, required String key}) {
    if (key == "10000") {
      List<TeacherTimetable> lectures =
          list.where((element) => element.day == key).toList();

      lectures.sort((a, b) => a.slot.compareTo(b.slot));
      final result = _calculateCombineIndexes(lectures);

      monLectures['lectures'] = lectures;
      monLectures['combineIndexes'] = result['combineIndexes'];
      monLectures['actualTileIndexes'] = result['actualTileIndexes'];
      monLectures['subjectAndSection'] = result['subjectAndSection'];
      monLectures['subjectAndTime'] = result['subjectAndTime'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "1000") {
      List<TeacherTimetable> lectures =
          list.where((element) => element.day.toString() == key).toList();
      lectures.sort((a, b) => a.slot.compareTo(b.slot));

      final result = _calculateCombineIndexes(lectures);

      tueLectures['lectures'] = lectures;
      tueLectures['combineIndexes'] = result['combineIndexes'];
      tueLectures['actualTileIndexes'] = result['actualTileIndexes'];
      tueLectures['subjectAndSection'] = result['subjectAndSection'];
      tueLectures['subjectAndTime'] = result['subjectAndTime'];
      // lecturesCount[key] = tueLectures.length.toString();
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "100") {
      List<TeacherTimetable> lectures =
          list.where((element) => element.day.toString() == key).toList();
      lectures.sort((a, b) => a.slot.compareTo(b.slot));
      final result = _calculateCombineIndexes(lectures);
      wedLectures['lectures'] = lectures;
      wedLectures['combineIndexes'] = result['combineIndexes'];
      wedLectures['actualTileIndexes'] = result['actualTileIndexes'];
      wedLectures['subjectAndSection'] = result['subjectAndSection'];
      wedLectures['subjectAndTime'] = result['subjectAndTime'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "10") {
      List<TeacherTimetable> lectures =
          list.where((element) => element.day.toString() == key).toList();
      lectures.sort((a, b) => a.slot.compareTo(b.slot));

      final result = _calculateCombineIndexes(lectures);

      thuLectures['lectures'] = lectures;
      thuLectures['combineIndexes'] = result['combineIndexes'];
      thuLectures['actualTileIndexes'] = result['actualTileIndexes'];
      thuLectures['subjectAndSection'] = result['subjectAndSection'];
      thuLectures['subjectAndTime'] = result['subjectAndTime'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    } else if (key == "1") {
      List<TeacherTimetable> lectures =
          list.where((element) => element.day.toString() == key).toList();
      lectures.sort((a, b) => a.slot.compareTo(b.slot));

      final result = _calculateCombineIndexes(lectures);

      friLectures['lectures'] = lectures;
      friLectures['combineIndexes'] = result['combineIndexes'];
      friLectures['actualTileIndexes'] = result['actualTileIndexes'];
      friLectures['subjectAndSection'] = result['subjectAndSection'];
      friLectures['subjectAndTime'] = result['subjectAndTime'];
      lecturesCount[key] =
          "${lectures.length - result['actualTileIndexes'].length}";
    }
  }

  void getLectures({required String key}) {
    if (key == "10000") {
      daywiseLectures.value = monLectures;
    } else if (key == "1000") {
      daywiseLectures.value = tueLectures;
    } else if (key == "100") {
      daywiseLectures.value = wedLectures;
    } else if (key == "10") {
      daywiseLectures.value = thuLectures;
    } else if (key == "1") {
      daywiseLectures.value = friLectures;
    }
  }

  Map<String, dynamic> _calculateCombineIndexes(
      List<TeacherTimetable> lectures) {
    var list1 = [];
    var actualTileIndexes = [];
    // list2.contains(2);
    var a, b = false;
    for (var i = 0; i < lectures.length; i++) {
      if (i != lectures.length - 1) {
        final subjectAndSection = a =
            lectures[i].subject == lectures[i + 1].subject &&
                lectures[i].section == lectures[i + 1].section;

        final subjectAndTime = b =
            lectures[i].subject == lectures[i + 1].subject &&
                lectures[i].slot == lectures[i + 1].slot;
        if (subjectAndSection || subjectAndTime) {
          list1.add(i);
          actualTileIndexes.add(i);
          list1.add(i + 1);
        }
      }
    }
    return {
      "combineIndexes": list1,
      "actualTileIndexes": actualTileIndexes,
      "subjectAndSection": a,
      "subjectAndTime": b
    };
  }
}
