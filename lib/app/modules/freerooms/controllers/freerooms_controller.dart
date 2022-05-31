// Package imports:
import 'package:get/get.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:cui_timetable/app/data/database/database_constants.dart';

class FreeroomsController extends GetxController {
  var mon = true.obs;
  var tue = false.obs;
  var wed = false.obs;
  var thu = false.obs;
  var fri = false.obs;

  var MonToThursSlots = [];
  var friSlots = [];

  var monList;

  @override
  Future<void> onInit() async {
    super.onInit();
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

  Future fetchDetails() async {
    // Fetching timeslots
    final box1 = await Hive.openBox(DBNames.timeSlots);
    MonToThursSlots = box1.get(DBTimeSlots.monToThur);
    friSlots = box1.get(DBTimeSlots.fri);

    // For Default Reason
    currentSecreenTime = MonToThursSlots; // select timeslots for current screen
    final box2 = await Hive.openBox(DBNames.freerooms);
    final List list = box2.get(DBFreerooms.monday);
    currentScreenSlot1Classes =
        list[0].where((element) => !element.contains('lab'));
    currentScreenSlot1Labs = list.where((element) => element.contains('lab'));
    print(currentScreenSlot1Classes);
    return Future.value(true);
  }

  var currentSecreenTime;
  var currentScreenSlot1Classes;
  var currentScreenSlot1Labs;
}
