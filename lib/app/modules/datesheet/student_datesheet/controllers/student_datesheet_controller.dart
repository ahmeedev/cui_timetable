import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';

class StudentDatesheetController extends GetxController {
  var isLoading = true.obs;
  var monToThursSlots = [];
  var friSlots = [];
  var currentTimeSlots = [];

  var mon = true.obs; //! mon is selected by default
  var tue = false.obs;
  var wed = false.obs;
  var thu = false.obs;
  var fri = false.obs;

  var daywiseLectures = [].obs; //! Current day lectures.

  var monLectures = [];
  var tueLectures = [];
  var wedLectures = [];
  var thuLectures = [];
  var friLectures = [];
  var lecturesCount = <String, String>{}.obs;

  late Box datesheetDB;
  @override
  Future<void> onInit() async {
    super.onInit();

    datesheetDB = await Hive.openBox(DBNames.datesheetDB);

    // list.forEach((element) {
    //   print(element.runtimeType);
    // });
    await openBox();
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
  openBox() async {
    List list = await datesheetDB.get(Get.arguments[0].toString());
    // list.forEach((element) {
    //   print(element);
    // });

    await _setLectures(list: list, key: "10000");
    await _setLectures(list: list, key: "1000");
    await _setLectures(list: list, key: "100");
    await _setLectures(list: list, key: "10");
    await _setLectures(list: list, key: "1");
    daywiseLectures.value = monLectures; //* For default purpose

    print(daywiseLectures.length);
    // yield lecturesCount;
    isLoading.value = false;
  }

  _setLectures({required list, required String key}) {
    if (key == "10000") {
      monLectures = list
          .where(
              (element) => element[0].toString().toLowerCase().contains("mon"))
          .toList();
      // monLectures.sort((a, b) => a[2].compareTo(b[2]));
      lecturesCount[key] = monLectures.length.toString();
    } else if (key == "1000") {
      tueLectures = list
          .where(
              (element) => element[0].toString().toLowerCase().contains("tue"))
          .toList();
      // tueLectures.sort((a, b) => a[2].compareTo(b[2]));
      lecturesCount[key] = tueLectures.length.toString();
    } else if (key == "100") {
      wedLectures = list
          .where(
              (element) => element[0].toString().toLowerCase().contains("wed"))
          .toList();
      // wedLectures.sort((a, b) => a[2].compareTo(b[2]));
      lecturesCount[key] = wedLectures.length.toString();
    } else if (key == "10") {
      thuLectures = list
          .where((element) =>
              element[0].toString().toLowerCase().contains("thurs"))
          .toList();
      // t    list.where((element) => element[0].toString().toLowerCase().contains("mon")).toList();
      lecturesCount[key] = thuLectures.length.toString();
    } else if (key == "1") {
      friLectures = list
          .where(
              (element) => element[0].toString().toLowerCase().contains("fri"))
          .toList();
      // friLectures.sort((a, b) => a[2].compareTo(b[2]));
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
