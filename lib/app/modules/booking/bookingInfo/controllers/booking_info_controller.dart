import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/database_constants.dart';

class BookingInfoController extends GetxController {
  final teacher = Get.arguments["teacher"];
  final section = Get.arguments["section"];

  // final results = <String, List<int>>{};
  final daysName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final days = ["10000", "1000", "100", "10", "1"];
  var currentTimeSlots = [];
  var monToThursSlots = <String>[];
  var friSlots = <String>[];

  late Future<List> future;

  @override
  Future<void> onInit() async {
    future = calculate();
    final boxx = await Hive.openBox(DBNames.timeSlots);
    monToThursSlots = await boxx.get(DBTimeSlots.monToThur);
    friSlots = await boxx.get(DBTimeSlots.fri);

    currentTimeSlots = monToThursSlots;

    super.onInit();
  }

  final dayWiseFreeLectures = <List<int>>[].obs;
  Future<List> calculate() async {
    final box = await Hive.openBox(DBNames.timetableData);
    final secLectures =
        await box.get(DBTimetableData.studentsData)[section.toLowerCase()];
    final teacLectures =
        await box.get(DBTimetableData.teachersData)[teacher.toLowerCase()];

    for (var element in days) {
      final dayWiseSec1 =
          secLectures.where((element2) => element2.day == element).toList();
      final dayWiseSec2 =
          teacLectures.where((element2) => element2.day == element).toList();

      final secSlots = [];
      for (var element in dayWiseSec1) {
        secSlots.add(element.slot);
      }
      final teacSlots = [];
      for (var element in dayWiseSec2) {
        teacSlots.add(element.slot);
      }
      secSlots.sort();
      teacSlots.sort();

      // print(sec2Slots);

      final common = <int>[];
      // check the common elements in five slots
      for (var i = 1; i <= 5; i++) {
        if (!(secSlots.contains(i) || teacSlots.contains(i))) {
          common.add(i);
        }
      }

      // print(common);
      dayWiseFreeLectures.add(common);
      // results[element] = common;
    }
    selectDateWiseTile();
    return Future.value(dayWiseFreeLectures);
  }

  final dayTileState = [true.obs, false.obs, false.obs, false.obs, false.obs];
  var currentActiveIndex = 0.obs;
  changeDayTileState({index}) {
    for (var i in dayTileState) {
      i.value = false;
    }
    dayTileState[index].value = true;
    currentActiveIndex.value = index;
  }

  selectDateWiseTile() {
    final now = DateTime.now().weekday;
    switch (now) {
      case 1:
        changeDayTileState(index: now - 1);
        break;
      case 2:
        changeDayTileState(index: now - 1);

        break;
      case 3:
        changeDayTileState(index: now - 1);

        break;
      case 4:
        changeDayTileState(index: now - 1);

        break;
      case 5:
        changeDayTileState(index: now - 1);

        break;
      default:
    }
  }
}
