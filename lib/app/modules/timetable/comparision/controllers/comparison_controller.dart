import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ComparisonController extends GetxController {
  var monToThursSlots = [];
  var friSlots = [];
  var currentTimeSlots = [];
  late final Box studentsDB;
  late final Box teachersDB;
  @override
  Future<void> onInit() async {
    super.onInit();
    final box = await Hive.openBox(DBNames.timeSlots);
    currentTimeSlots = monToThursSlots = box.get(DBTimeSlots.monToThur);
    friSlots = box.get(DBTimeSlots.fri);

    teachersDB = await Hive.openBox(DBNames.teachersDB);
    studentsDB = await Hive.openBox(DBNames.studentsDB);
    print(teachersDB.get(Get.arguments[0].toString().toLowerCase()).length);
    print(studentsDB.get(Get.arguments[1].toString().toLowerCase()).length);
  }

  var mon = true.obs; // mon is selected by default
  var tue = false.obs;
  var wed = false.obs;
  var thu = false.obs;
  var fri = false.obs;

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

  getLecturesCount({required dayKey}) {}

  @override
  void onClose() {}
}
