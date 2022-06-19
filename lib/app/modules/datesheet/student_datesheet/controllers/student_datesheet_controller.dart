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
    List list = datesheetDB.get(Get.arguments[0].toString());
    print(list.length);
    list.forEach((element) {
      print(element);
    });
    // list.forEach((element) {
    //   print(element.runtimeType);
    // });
    // await openBox();
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
    // await _setLectures(key: "10000");
    // await _setLectures(key: "1000");
    // await _setLectures(key: "100");
    // await _setLectures(key: "10");
    // await _setLectures(key: "1");

    // daywiseLectures.value = monLectures; //* For default purpose

    // yield lecturesCount;
    isLoading.value = false;
  }
}
