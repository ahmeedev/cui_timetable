import 'package:cui_timetable/app/modules/comparison/controllers/comparison_controller.dart';
import 'package:get/get.dart';

class SecSecController extends GetxController {
  final section1 = Get.arguments["section1"];
  final section2 = Get.arguments["section2"];

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
    // final list = await box.get(DBTimetableData.studentsData);
    final sec1Lectures = Get.find<ComparisonController>()
        .studentTimetable[section1.toLowerCase()];
    final sec2Lectures = Get.find<ComparisonController>()
        .studentTimetable[section2.toLowerCase()];

    for (var element in days) {
      final dayWiseSec1 =
          sec1Lectures.where((element2) => element2.day == element).toList();
      final dayWiseSec2 =
          sec2Lectures.where((element2) => element2.day == element).toList();

      final sec1Slots = [];
      for (var element in dayWiseSec1) {
        sec1Slots.add(element.slot);
      }
      final sec2Slots = [];
      for (var element in dayWiseSec2) {
        sec2Slots.add(element.slot);
      }
      sec1Slots.sort();
      sec2Slots.sort();

      // print(sec2Slots);

      final common = <int>[];
      // check the common elements in five slots
      for (var i = 1; i <= 5; i++) {
        if (!(sec1Slots.contains(i) || sec2Slots.contains(i))) {
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
