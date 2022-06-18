import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ComparisonController extends GetxController {
  var isLoading = true.obs;
  var monToThursSlots = [];
  var friSlots = [];
  var currentTimeSlots = [];
  late final Box studentsDB;
  late final Box teachersDB;
  @override
  Future<void> onInit() async {
    super.onInit();
    final box = await Hive.openBox(DBNames.timeSlots);
    currentTimeSlots = monToThursSlots = await box.get(DBTimeSlots.monToThur);
    friSlots = await box.get(DBTimeSlots.fri);

    teachersDB = await Hive.openBox(DBNames.teachersDB);
    studentsDB = await Hive.openBox(DBNames.studentsDB);

    await openBox();
  }

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

  openBox() async {
    await _setLectures(key: "10000");
    await _setLectures(key: "1000");
    await _setLectures(key: "100");
    await _setLectures(key: "10");
    await _setLectures(key: "1");

    daywiseLectures.value = monLectures; //* For default purpose

    // yield lecturesCount;
    isLoading.value = false;
  }

  _setLectures({required String key}) {
    if (key == "10000") {
      monLectures = _calculateLecturesSlot(dayKey: key);
      lecturesCount[key] = monLectures.length.toString();
    } else if (key == "1000") {
      tueLectures = _calculateLecturesSlot(dayKey: key);
      lecturesCount[key] = tueLectures.length.toString();
    } else if (key == "100") {
      wedLectures = _calculateLecturesSlot(dayKey: key);
      lecturesCount[key] = wedLectures.length.toString();
    } else if (key == "10") {
      thuLectures = _calculateLecturesSlot(dayKey: key);

      lecturesCount[key] = thuLectures.length.toString();
    } else if (key == "1") {
      friLectures = _calculateLecturesSlot(dayKey: key);
      lecturesCount[key] = friLectures.length.toString();
    }
  }

  List _calculateLecturesSlot({required String dayKey}) {
    final List teachers =
        teachersDB.get(Get.arguments[0].toString().toLowerCase());
    final List students =
        studentsDB.get(Get.arguments[1].toString().toLowerCase());

    final result1 =
        teachers.where((element) => element[3].toString() == dayKey);
    print("Teacher Lectures : ${result1.length}");

    final result2 =
        students.where((element) => element[3].toString() == dayKey);
    print("Student Lectures : ${result2.length}");

    final teachersSlotsList = <String>{};
    result1.forEach((element) {
      teachersSlotsList.add(element[2].toString());
    });
    final studentsSlotsList = <String>{};
    result2.forEach((element) {
      studentsSlotsList.add(element[2].toString());
    });

    teachersSlotsList.addAll(
        studentsSlotsList); //! critical slots, in which lecture not available

    final listt = [1, 2, 3, 4, 5];
    final resultSlots = [];
    listt.forEach((element) {
      if (!teachersSlotsList.contains(element.toString())) {
        resultSlots.add(element);
      }
    });
    resultSlots.sort();
    return resultSlots;
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

  @override
  void onClose() {}
}
