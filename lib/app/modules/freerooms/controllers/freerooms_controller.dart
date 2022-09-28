import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/database/database_constants.dart';
import '../models/freerooms_model.dart';

class FreeroomsController extends GetxController {
  var mon = false.obs;
  var tue = false.obs;
  var wed = false.obs;
  var thu = false.obs;
  var fri = false.obs;

  var loading = true.obs;

  var monToThursSlots = [];
  var friSlots = [];
  var currentScreenTime = [];
  final List<FreeroomsModel> _freerooms = [];
  var freerooms = [].obs;
  // ignore: prefer_typing_uninitialized_variables
  late var freeroomsBox;

  @override
  Future<void> onInit() async {
    super.onInit();
    selectDateWiseTile();
    final box1 = await Hive.openBox(DBNames.timeSlots);
    monToThursSlots = await box1.get(DBTimeSlots.monToThur);
    friSlots = await box1.get(DBTimeSlots.fri);
    freeroomsBox = await Hive.openBox(DBNames.freerooms);

    getFreerooms(day: "Mon"); // For default behaviour
  }

  selectDateWiseTile() {
    final now = DateTime.now().weekday;
    switch (now) {
      case 1:
        mon.value = true;
        break;
      case 2:
        tue.value = true;
        break;
      case 3:
        wed.value = true;
        break;
      case 4:
        thu.value = true;
        break;
      case 5:
        fri.value = true;
        break;
      default:
        mon.value = true;
    }
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
        currentScreenTime = monToThursSlots;
        return freeroomsBox.get(DBFreerooms.monday);
      // break;
      case "Tue":
        currentScreenTime = monToThursSlots;
        return freeroomsBox.get(DBFreerooms.tuesday);
      case "Wed":
        currentScreenTime = monToThursSlots;
        return freeroomsBox.get(DBFreerooms.wednesday);
      case "Thu":
        currentScreenTime = monToThursSlots;
        return freeroomsBox.get(DBFreerooms.thursday);

      default:
        currentScreenTime = friSlots;
        return freeroomsBox.get(DBFreerooms.friday);
    }
  }

  getFreerooms({required day}) async {
    loading.value = true;
    _freerooms.clear();
    // list contains all the slots data for specific day.
    final List list =
        _getDayWiseLectures(day: day); // get required day lecture.

    List.generate(5, (index) async {
      // set to 1 for all the slots
      List data = await list[index]
          .where((element) => element.toString().isNotEmpty)
          .toList(); // filter empty cells
      List<String> filtered = List<String>.from(data); // casting..
      var storage = [];
      var classes = filtered
          .where((element) => !element.toLowerCase().contains('lab'))
          .toList(); // sortout the labs
      var totalClasses = classes.length; // total classes length

      // Filtering the classes
      storage = classes
          .where((element) => element.toLowerCase().contains('a'))
          .toList(); // fetch Classes of A
      var subclass1 =
          FreeroomsSubClass(totalClasses: storage.length, classes: storage);

      storage = classes
          .where((element) => element.toLowerCase().contains('b'))
          .toList(); // fetch Classes of B
      var subclass2 =
          FreeroomsSubClass(totalClasses: storage.length, classes: storage);

      storage = classes
          .where((element) => element.toLowerCase().contains('c'))
          .toList(); // fetch Classes of B
      var subclass3 =
          FreeroomsSubClass(totalClasses: storage.length, classes: storage);

      storage = classes
          .where((element) => element.toLowerCase().contains('w'))
          .toList(); // fetch Classes of B
      var subclass4 =
          FreeroomsSubClass(totalClasses: storage.length, classes: storage);

      var listOfSubClasses = [subclass1, subclass2, subclass3, subclass4];

      //! Calculating Labs

      storage = filtered
          .where((element) => element.toLowerCase().contains('lab'))
          .toList()
        ..sort();

      var totalLabs = storage.length;

      var freeroomsModel = FreeroomsModel(
          totalClasses: totalClasses,
          classes: listOfSubClasses,
          totalLabs: totalLabs,
          labs: storage);

      _freerooms.add(freeroomsModel);
    });
    freerooms.value = _freerooms;
    loading.value = false;
  }
}
