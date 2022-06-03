import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';

// Package imports:

// Project imports:

class TeacherTimetableController extends GetxController {
  var monToThursSlots = [];
  var friSlots = [];
  // var timeMap = {
  //   '1': ["08:30AM", "10:00AM"],
  //   '2': ["10:00AM", "11:30AM"],
  //   '3': ["11:30AM", "01:00PM"],
  //   '4': ["01:30PM", "03:00PM"],
  //   '5': ["03:00PM", "04:30PM"]
  // };

  // var timeMap;
  // final timeMap = {
  //   "1": ["08:30AM", "10:00AM"],
  //   "2": ["10:00AM", "11:30AM"],
  //   "3": ["11:30AM", "01:00PM"],
  //   "4": ["01:30PM", "03:00PM"],
  //   "5": ["03:00PM", "04:30PM"],
  // };

  @override
  Future<void> onInit() async {
    final box = await Hive.openBox(DBNames.timeSlots);
    monToThursSlots = box.get(DBTimeSlots.monToThur);
    friSlots = box.get(DBTimeSlots.fri);
    super.onInit();
  }

  late final box;
  var mon = true.obs; // mon is selected by default
  var tue = false.obs;
  var wed = false.obs;
  var thu = false.obs;
  var fri = false.obs;

  var daywiseLectures = [].obs;

  var monLectures = [];
  var tueLectures = [];
  var wedLectures = [];
  var thuLectures = [];
  var friLectures = [];
  var lecturesCount = <String, String>{}.obs;

  openBox({required String teacher}) async* {
    box = await Hive.openBox(DBNames.teachersDB);
    final list = box.get(teacher.toLowerCase());
    await _setLectures(list: list, key: "10000");
    await _setLectures(list: list, key: "1000");
    await _setLectures(list: list, key: "100");
    await _setLectures(list: list, key: "10");
    await _setLectures(list: list, key: "1");

    daywiseLectures.value = monLectures; //* For default purpose

    yield lecturesCount;
  }

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

  _setLectures({required list, required String key}) {
    if (key == "10000") {
      monLectures =
          list.where((element) => element[3].toString() == key).toList();
      monLectures.sort((a, b) => a[2].compareTo(b[2]));
      lecturesCount[key] = monLectures.length.toString();
    } else if (key == "1000") {
      tueLectures =
          list.where((element) => element[3].toString() == key).toList();
      tueLectures.sort((a, b) => a[2].compareTo(b[2]));
      lecturesCount[key] = tueLectures.length.toString();
    } else if (key == "100") {
      wedLectures =
          list.where((element) => element[3].toString() == key).toList();
      wedLectures.sort((a, b) => a[2].compareTo(b[2]));
      lecturesCount[key] = wedLectures.length.toString();
    } else if (key == "10") {
      thuLectures =
          list.where((element) => element[3].toString() == key).toList();
      thuLectures.sort((a, b) => a[2].compareTo(b[2]));
      lecturesCount[key] = thuLectures.length.toString();
    } else if (key == "1") {
      friLectures =
          list.where((element) => element[3].toString() == key).toList();
      friLectures.sort((a, b) => a[2].compareTo(b[2]));
      lecturesCount[key] = friLectures.length.toString();
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
}
