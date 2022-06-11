import 'package:cui_timetable/app/modules/freerooms/models/freerooms_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:cui_timetable/app/data/database/database_constants.dart';

class FreeroomsController extends GetxController {
  var mon = true.obs;
  var tue = false.obs;
  var wed = false.obs;
  var thu = false.obs;
  var fri = false.obs;

  var loading = true.obs;

  var monToThursSlots = [];
  var friSlots = [];
  var currentScreenTime = [];
  List<FreeroomsModel> freerooms = [];
  var freeroomsBox;

  @override
  Future<void> onInit() async {
    super.onInit();

    final box1 = await Hive.openBox(DBNames.timeSlots);
    monToThursSlots = await box1.get(DBTimeSlots.monToThur);
    friSlots = await box1.get(DBTimeSlots.fri);
    freeroomsBox = await Hive.openBox(DBNames.freerooms);

    // getFreerooms(day: "Mon");
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

  // Future fetchDetails() async {
  //   // Fetching timeslots
  // final box1 = await Hive.openBox(DBNames.timeSlots);
  // monToThursSlots = box1.get(DBTimeSlots.monToThur);
  // friSlots = box1.get(DBTimeSlots.fri);

  //   // For Default Reason
  //   currentScreenTime = monToThursSlots; // select timeslots for current screen
  // final box2 = await Hive.openBox(DBNames.freerooms);
  //   final List list = box2.get(DBFreerooms.monday);
  //   currentScreenSlot1Classes =
  //       list[0].where((element) => !element.contains('lab'));
  //   currentScreenSlot1Labs = list.where((element) => element.contains('lab'));
  //   print(currentScreenSlot1Classes);
  //   return Future.value(true);
  // }

  // var currentScreenSlot1Labs;

  List _getDayWiseLectures({required day}) {
    switch (day) {
      case "Mon":
        return freeroomsBox.get(DBFreerooms.monday);
      // break;
      case "Tue":
        return freeroomsBox.get(DBFreerooms.tuesday);
      case "Wed":
        return freeroomsBox.get(DBFreerooms.wednesday);
      case "Thu":
        return freeroomsBox.get(DBFreerooms.thursday);

      default:
        return freeroomsBox.get(DBFreerooms.friday);
    }
  }

  getFreerooms({required day}) async {
    if (day == "Mon") {
      currentScreenTime = monToThursSlots;
      loading.value = true;
      final List list =
          _getDayWiseLectures(day: day); // get required day lecture.

      // list contains all the slots data for specific day.

      List.generate(1, (index) async {
        // set to 1 for all the slots
        List data = await list[index]
            .where((element) => element.toString().isNotEmpty)
            .toList(); // filter empty cells
        List<String> filtered = List<String>.from(data); // casting..
        filtered = filtered
            .where((element) => !element.toLowerCase().contains('lab'))
            .toList(); // sortout the labs
        var totalClasses = filtered.length; // total classes length
        filtered = filtered
            .where((element) => element.toLowerCase().contains('a'))
            .toList(); // fetch Classes of A

        var subclass1 =
            FreeroomsSubClass(totalClasses: filtered.length, classes: filtered);

        filtered = filtered
            .where((element) => element.toLowerCase().contains('b'))
            .toList(); // fetch Classes of B

        var subclass2 =
            FreeroomsSubClass(totalClasses: filtered.length, classes: filtered);

        var listOfSubClasses = [subclass1, subclass2];

        //! Calculating Labs

        filtered = filtered
            .where((element) => element.toLowerCase().contains('lab'))
            .toList();

        var totalLabs = filtered.length;

        var freeroomsModel = FreeroomsModel(
            totalClasses: totalClasses,
            classes: listOfSubClasses,
            totalLabs: totalLabs,
            labs: filtered);

        freerooms.add(freeroomsModel);
      });

      loading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    // loading.value = false;
  }
}
