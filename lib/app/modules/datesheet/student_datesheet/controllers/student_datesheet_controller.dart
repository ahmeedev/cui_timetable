import 'dart:math';

import '../../../../data/database/database_constants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentDatesheetController extends GetxController {
  var isLoading = true.obs;
  var daytilesLength = 0;
  var currentTimeSlots = [];
  var datesForDayList = []; // [date,day]

  var dayTilesSelection = <String, bool>{}.obs;

  var papers = <String, List<dynamic>>{}; //! Current day lectures.
  var currentDayPapers = [].obs;
  var lecturesCount = <String, int>{}.obs;

  late Box datesheetDB;

  @override
  Future<void> onInit() async {
    super.onInit();
    datesheetDB = await Hive.openBox(DBNames.datesheetStudentsDB);
    await openBox();
  }

// Methods for Controlling DayTile.
  void allFalse() {
    dayTilesSelection.forEach((date, value) {
      dayTilesSelection[date] = false;
    });
  }

  giveValue({required date}) {
    allFalse();
    dayTilesSelection[date] = true;
  }

  // Methods for controlling LectureTile
  openBox() async {
    List list = await datesheetDB.get(Get.arguments[0].toString());
    daytilesLength = list.length; //! size w.r.t papers

    //* Fetching dates from the list //
    for (var item in list) {
      datesForDayList.add([item[0], "${item[1]}-${item[2]}"]);
    }

    //* Setting all the values to false for daytile filled state
    for (var element in datesForDayList) {
      dayTilesSelection[element[1]] = false;
    }

    //? lets put the key for the papers as index, bcz they are not fixed
    for (var index = 0; index < list.length; index++) {
      await _setLectures(
          list: list, key: "$index", date: datesForDayList[index][1]);
    }

    getPapers(date: datesForDayList[0][1]); //! Get papers for first slot
    giveValue(date: datesForDayList[0][1]); //! set the first daytile selected

    isLoading.value = false;
  }

  _setLectures({required list, required String date, required String key}) {
    List result = list.where((element) {
      final value = "${element[1]}-${element[2]}";
      return value.contains(date);
    }).toList();

    papers[date] = result;
    lecturesCount[date] = result.length;
  }

  getPapers({required String date}) {
    currentDayPapers.value = papers[date]!;
  }
}
