import 'package:get/get.dart';

import '../../controllers/comparison_controller.dart';

class TeacSectController extends GetxController {
  final teacher = Get.arguments["teacher"];
  final section = Get.arguments["section"];

  // final results = <String, List<int>>{};
  final daysName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final days = ["10000", "1000", "100", "10", "1"];
  var currentTimeSlots = [];

  late final Future<List> future;

  @override
  Future<void> onInit() async {
    future = calculate();
    selectDateWiseTile();

    currentTimeSlots = Get.find<ComparisonController>().monToThursSlots;
    super.onInit();
  }

  final dayWiseFreeLectures = <List<int>>[].obs;
  Future<List> calculate() async {
    // final box = await Hive.openBox(DBNames.timetableData);
    // final secLectures =
    //     await box.get(DBTimetableData.studentsData)[section.toLowerCase()];
    // final teacLectures =
    //     await box.get(DBTimetableData.teachersData)[teacher.toLowerCase()];
    final secLectures = Get.find<ComparisonController>()
        .studentTimetable[section.toLowerCase()];
    final teacLectures = Get.find<ComparisonController>()
        .teacherTimetable[teacher.toLowerCase()];

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
